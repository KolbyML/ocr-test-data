# OCR Test Data

This repository contains regression test cases for the [Mangatan](https://github.com/KolbyML/Mangatan) OCR engine. It stores input images, raw OCR data (cached from Google Lens), and the manually verified "expected" output.

## Directory Structure

Test cases are organized by folder. Each test case consists of three files:

1.  **Image**: `name.png` (or .jpg, .webp, .avif) - *The input.*
2.  **Raw Data**: `name.raw.json` - *Cached raw OCR output (Auto-generated).*
3.  **Expected Output**: `name.expected.json` - *The corrected, merged text (Manually Edited).*

## How to Add a New Test Case

### Prerequisites
* You must have the [Mangatan](https://github.com/KolbyML/Mangatan) repository cloned in a sibling directory (e.g., `../Mangatan`).
* Rust installed.

### Step 1: Add the Image
Create a new folder (or use an existing one) and drop your image file into it.

```bash
mkdir -p complex-layouts
cp ~/screenshots/page_01.png complex-layouts/
