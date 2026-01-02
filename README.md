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

```

### Step 2: Generate Initial Data

Run the make command to generate the raw OCR cache and a baseline expected file.

```bash
make generate

```

* **What this does:** It runs the Mangatan OCR logic against your new image.
* **Result:** It creates `page_01.raw.json` (so tests don't hit the API repeatedly) and `page_01.expected.json` (containing the current automatic output).

### Step 3: Edit Expected Output

Open the generated `.expected.json` file in your editor. **This is the most important step.**

The generated file represents what the code *currently* does, which might be wrong (that's why you are adding a test case!).

* **Fix the text:** Correct any misread characters.
* **Fix the merges:** If two bubbles were incorrectly merged, split them into separate objects in the JSON array.
* **Fix the order:** Ensure the reading order is correct.

**Note:** Do not worry about `tightBoundingBox` coordinates. The test runner ignores them during comparison.

### Step 4: Validate

Run the validation script to ensure your changes are logically possible (i.e., you didn't add text that doesn't exist in the raw OCR).

```bash
make validate

```

### Step 5: Commit

Commit the image and the `.expected.json`.
**Note:** `*.raw.json` files are usually ignored by git to keep the repo size down, but check `.gitignore` policy.

```bash
git add complex-layouts/page_01.png complex-layouts/page_01.expected.json
git commit -m "test: add complex layout regression case"
git push

```

### Step 6: Done!
Make a pull request to add your test case to the repository.


