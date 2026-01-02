# Default path to the Mangatan repo (assuming sibling directory)
MANGATAN_DIR ?= ../Mangatan

.PHONY: help
help:
	@echo "OCR Test Data Helper"
	@echo "--------------------"
	@echo "Usage:"
	@echo "  make generate   - Generates .expected.json and .raw.json for new images"
	@echo "  make validate   - Runs validation to ensure expected data is achievable"

.PHONY: generate
generate:
	@echo "🚀 Generating missing test files..."
	@if [ ! -d "$(MANGATAN_DIR)" ]; then \
		echo "❌ Error: Mangatan repository not found at '$(MANGATAN_DIR)'"; \
		echo "   Please clone https://github.com/KolbyML/Mangatan to a sibling directory"; \
		echo "   or run 'make generate MANGATAN_DIR=/path/to/repo'"; \
		exit 1; \
	fi
	@# This triggers the regression test in Mangatan. 
	@# The test logic detects missing .expected.json files and generates them automatically.
	cd $(MANGATAN_DIR) && cargo test --package mangatan-ocr-server --test merge_regression -- --nocapture

.PHONY: validate
validate:
	@echo "🔍 Validating test data integrity..."
	@# This runs the subset validation logic to ensure expected text exists in raw OCR
	cd $(MANGATAN_DIR) && cargo test --package mangatan-ocr-server --test validate_submission -- --nocapture
