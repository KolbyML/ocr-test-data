MANGATAN_DIR ?= ../Mangatan

.PHONY: help
help:
	@echo "OCR Test Data Helper"
	@echo "--------------------"
	@echo "Usage:"
	@echo "  make generate         - Generates .expected.json only for NEW images (skips existing checks)"
	@echo "  make validate         - Runs full validation on all data"

.PHONY: generate
generate:
	@echo "🚀 Generating missing test files..."
	@if [ ! -d "$(MANGATAN_DIR)" ]; then \
		echo "❌ Error: Mangatan repository not found at '$(MANGATAN_DIR)'"; \
		exit 1; \
	fi
	@# We pass OCR_TEST_DATA_PATH=$(CURDIR) to force the test to use THIS folder
	cd $(MANGATAN_DIR) && OCR_TEST_DATA_PATH=$(CURDIR) ONLY_GENERATE_MISSING=1 cargo test --package mangatan-ocr-server --test merge_regression -- --nocapture

.PHONY: validate
validate:
	@echo "🔍 Validating test data integrity..."
	cd $(MANGATAN_DIR) && OCR_TEST_DATA_PATH=$(CURDIR) cargo test --package mangatan-ocr-server --test validate_submission -- --nocapture