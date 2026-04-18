#!/usr/bin/env python3
"""
VSCode Chat Export to Markdown Converter

Usage:
  python convert_chat.py <input.json> [output.md]
  python convert_chat.py *.json --output-dir ./markdown/
  python convert_chat.py asio.json futex.json --verbose
"""
import json
import sys
import re
import argparse
import os
import glob
from pathlib import Path

def clean_text(text):
    """Clean up text content, removing excessive whitespace and formatting issues."""
    if not text:
        return ""

    # Remove extra whitespace
    # text = re.sub(r'\n\s*\n\s*\n', '\n\n', text)
    # text = re.sub(r'[ \t]+', ' ', text)
    # text = text.strip()

    return text

def extract_response_from_toolcalls(request):
    """Extract response text from toolCallRounds, which contains clean complete text."""
    if 'result' in request and 'metadata' in request['result']:
        metadata = request['result']['metadata']
        if 'toolCallRounds' in metadata and isinstance(metadata['toolCallRounds'], list):
            for round_info in metadata['toolCallRounds']:
                if 'response' in round_info and round_info['response']:
                    return round_info['response']
    return ""

def generate_default_output(input_file, output_dir=None, suffix=None):
    """Generate default output filename based on input file."""
    input_path = Path(input_file)
    base_name = input_path.stem

    if suffix:
        output_name = f"{base_name}_{suffix}.md"
    else:
        output_name = f"{base_name}.md"

    if output_dir:
        output_path = Path(output_dir) / output_name
        # Ensure output directory exists
        output_path.parent.mkdir(parents=True, exist_ok=True)
        return str(output_path)

    return output_name

def convert_chat_to_markdown(json_file, output_file, verbose=False, include_toc=True):
    """Convert chat JSON to markdown format using toolCallRounds."""

    if verbose:
        print(f"Processing: {json_file} -> {output_file}")

    try:
        with open(json_file, 'r', encoding='utf-8') as f:
            data = json.load(f)
    except FileNotFoundError:
        print(f"Error: File '{json_file}' not found")
        return False
    except json.JSONDecodeError as e:
        print(f"Error: Invalid JSON format in '{json_file}' - {e}")
        return False
    except Exception as e:
        print(f"Error reading JSON file '{json_file}': {e}")
        return False

    # Extract requests
    if 'requests' not in data:
        print(f"No 'requests' found in JSON data from {json_file}")
        return False

    requests = data['requests']

    if not requests:
        print(f"Warning: No requests found in {json_file}")
        return False

    markdown_content = []

    # Add header with source file info
    markdown_content.append(f"# VSCode Chat Export: {Path(json_file).stem}\n")
    markdown_content.append(f"*Converted from: {json_file}*\n")
    markdown_content.append(f"*Total conversations: {len(requests)}*\n")

    # Add table of contents if requested
    if include_toc:
        markdown_content.append("## Table of Contents\n")
        for i, request in enumerate(requests, 1):
            if 'message' in request and 'text' in request['message']:
                user_text = request['message']['text'].strip()
                # Truncate long titles for TOC
                title = user_text[:80] + "..." if len(user_text) > 80 else user_text
                # Clean title for markdown link
                # title = re.sub(r'[^\w\s-]', '', title)
                markdown_content.append(f"- [{i}. {title}](#request-{i})")
        markdown_content.append("\n---\n")

    # Process each request-response pair
    for i, request in enumerate(requests, 1):
        # Extract user message
        user_message = ""
        if 'message' in request and 'text' in request['message']:
            user_message = request['message']['text'].strip()
        elif 'message' in request and 'parts' in request['message']:
            # Handle alternative message format
            parts = request['message']['parts']
            if parts and isinstance(parts, list) and len(parts) > 0:
                if 'text' in parts[0]:
                    user_message = parts[0]['text'].strip()

        markdown_content.append(f"## Request {i}")
        markdown_content.append(f"> {user_message}\n")

        # Extract response from toolCallRounds (much cleaner!)
        response_text = extract_response_from_toolcalls(request)

        # Clean and add response
        response_text = clean_text(response_text)
        if response_text:
            markdown_content.append("### Assistant Response")
            markdown_content.append(response_text)
        else:
            markdown_content.append("### Assistant Response")
            markdown_content.append("*No response content found*")

        markdown_content.append("\n---\n")

    # Write to output file
    try:
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write('\n'.join(markdown_content))

        if verbose:
            print(f"✓ Successfully converted {json_file} to {output_file}")
            print(f"  Processed {len(requests)} conversation turns")

        return True
    except PermissionError:
        print(f"Error: Permission denied writing to '{output_file}'")
        return False
    except Exception as e:
        print(f"Error writing output file '{output_file}': {e}")
        return False

def expand_file_patterns(patterns):
    """Expand glob patterns and return list of files."""
    files = []
    for pattern in patterns:
        if '*' in pattern or '?' in pattern:
            # Use glob for patterns
            matches = glob.glob(pattern)
            if not matches:
                print(f"Warning: No files found matching pattern '{pattern}'")
            files.extend(matches)
        else:
            # Direct file path
            files.append(pattern)
    return files

def main():
    parser = argparse.ArgumentParser(
        description="Convert VSCode chat exports (JSON) to readable Markdown",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  %(prog)s chat.json                           # Convert single file
  %(prog)s chat.json output.md                 # Convert with custom output name
  %(prog)s *.json                              # Convert all JSON files in current dir
  %(prog)s *.json --output-dir ./markdown/     # Convert all to specific directory
  %(prog)s chat1.json chat2.json --verbose     # Convert multiple files with verbose output
  %(prog)s *.json --no-toc --suffix processed  # Advanced options
        """
    )

    parser.add_argument(
        'input_files',
        nargs='+',
        help='Input JSON file(s). Supports glob patterns like *.json'
    )

    parser.add_argument(
        '-o', '--output-dir',
        help='Output directory for generated markdown files'
    )

    parser.add_argument(
        '-v', '--verbose',
        action='store_true',
        help='Verbose output showing processing details'
    )

    parser.add_argument(
        '--no-toc',
        action='store_true',
        help='Skip generating table of contents'
    )

    parser.add_argument(
        '--suffix',
        help='Add suffix to generated output filenames (e.g., --suffix processed)'
    )

    parser.add_argument(
        '--force',
        action='store_true',
        help='Overwrite existing output files without prompting'
    )

    args = parser.parse_args()

    # Handle the case where user provides "input.json output.md" format
    # If we have 2 args and second doesn't contain wildcards and ends with .md, treat as single file + output
    explicit_output = None
    input_patterns = args.input_files

    if (len(args.input_files) == 2 and
        not any(char in args.input_files[1] for char in ['*', '?']) and
        args.input_files[1].endswith('.md')):
        input_patterns = [args.input_files[0]]
        explicit_output = args.input_files[1]

    # Expand file patterns
    input_files = expand_file_patterns(input_patterns)

    if not input_files:
        print("Error: No input files found")
        sys.exit(1)

    # Validate arguments
    if explicit_output and len(input_files) > 1:
        print("Error: Cannot specify single output file with multiple input files")
        print("Use --output-dir instead for multiple files")
        sys.exit(1)

    # Process files
    success_count = 0
    total_files = len(input_files)

    if args.verbose:
        print(f"Processing {total_files} file(s)...")

    for input_file in input_files:
        if not os.path.exists(input_file):
            print(f"Error: Input file '{input_file}' not found")
            continue

        # Determine output file
        if explicit_output:
            output_file = explicit_output
        else:
            output_file = generate_default_output(
                input_file,
                args.output_dir,
                args.suffix
            )

        # Check if output exists and handle overwrite
        if os.path.exists(output_file) and not args.force:
            response = input(f"Output file '{output_file}' exists. Overwrite? (y/N): ")
            if response.lower() not in ['y', 'yes']:
                print(f"Skipping {input_file}")
                continue

        # Convert file
        success = convert_chat_to_markdown(
            input_file,
            output_file,
            verbose=args.verbose,
            include_toc=not args.no_toc
        )

        if success:
            success_count += 1
        else:
            print(f"Failed to process {input_file}")

    # Summary
    if args.verbose or total_files > 1:
        print(f"\nSummary: Successfully processed {success_count}/{total_files} files")

    if success_count == 0:
        sys.exit(1)

if __name__ == "__main__":
    main()
