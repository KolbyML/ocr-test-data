MANGATAN_DIR ?= ../Mangatan

.PHONY: help
help:
	@echo "OCR Test Data Helper"
	@echo "--------------------"
	@echo "Usage:"
	@echo "  make generate         - Generates .expected.json only for NEW images"
	@echo "  make generate-raw     - Force regenerates ALL .raw.json files (hits Google Lens)"
	@echo "  make validate         - Runs full validation"

.PHONY: generate
generate:
	@echo "🚀 Generating missing test files..."
	@if [ ! -d "$(MANGATAN_DIR)" ]; then echo "❌ Error: Mangatan repo not found"; exit 1; fi
	cd $(MANGATAN_DIR) && OCR_TEST_DATA_PATH=$(CURDIR) ONLY_GENERATE_MISSING=1 cargo test --package mangatan-ocr-server --test merge_regression -- --nocapture

.PHONY: generate-raw
generate-raw:
	@echo "🔄 Regenerating ALL raw OCR data (This may take a while)..."
	@if [ ! -d "$(MANGATAN_DIR)" ]; then echo "❌ Error: Mangatan repo not found"; exit 1; fi
	@# REGENERATE_RAW=1 tells the test to ignore existing .raw.json files
	@# We also allow it to update expected files if they drift, or you can remove UPDATE_EXPECTED=1 if you want to see failures first.
	cd $(MANGATAN_DIR) && OCR_TEST_DATA_PATH=$(CURDIR) REGENERATE_RAW=1 cargo test --package mangatan-ocr-server --test merge_regression -- --nocapture


.PHONY: validate
validate:
	@echo "🔍 Validating test data integrity..."
	cd $(MANGATAN_DIR) && OCR_TEST_DATA_PATH=$(CURDIR) cargo test --package mangatan-ocr-server --test validate_submission -- --nocapture