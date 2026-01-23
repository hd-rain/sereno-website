# Makefile for Lighthouse testing

# Default values
LOCAL_URL = http://127.0.0.1:1111
REMOTE_URL = https://www.sereno.insure
SLUG ?= 

# Generate timestamp for filenames
TIMESTAMP = $(shell date '+%Y-%m-%d-%H-%M-%S')

# Build URLs with optional slug
LOCAL_TEST_URL = $(LOCAL_URL)$(if $(SLUG),/$(SLUG)/)
REMOTE_TEST_URL = $(REMOTE_URL)$(if $(SLUG),/$(SLUG)/)

.PHONY: lh lh-remote lh-mobile lh-desktop lh-mobile-remote lh-desktop-remote lh-full lh-remote-full

# Run both mobile and desktop lighthouse tests locally
lh: lh-mobile lh-desktop

# Run both mobile and desktop lighthouse tests on remote
lh-remote: lh-mobile-remote lh-desktop-remote

# Local mobile lighthouse test
lh-mobile:
	@echo "Running Lighthouse mobile test for: $(LOCAL_TEST_URL)"
	lighthouse "$(LOCAL_TEST_URL)" --output-path="./lighthouse/mobile-$(TIMESTAMP).html" --view

# Local desktop lighthouse test  
lh-desktop:
	@echo "Running Lighthouse desktop test for: $(LOCAL_TEST_URL)"
	lighthouse "$(LOCAL_TEST_URL)" --output-path="./lighthouse/desktop-$(TIMESTAMP).html" --preset=desktop --view

# Remote mobile lighthouse test
lh-mobile-remote:
	@echo "Running Lighthouse mobile test for: $(REMOTE_TEST_URL)"
	lighthouse "$(REMOTE_TEST_URL)" --output-path="./lighthouse/mobile-remote-$(TIMESTAMP).html" --view

# Remote desktop lighthouse test
lh-desktop-remote:
	@echo "Running Lighthouse desktop test for: $(REMOTE_TEST_URL)"
	lighthouse "$(REMOTE_TEST_URL)" --output-path="./lighthouse/desktop-remote-$(TIMESTAMP).html" --preset=desktop --view

# Run full lighthouse tests locally (home, maritime, about) in both mobile and desktop
lh-full:
	@echo "Running full Lighthouse tests locally (home, maritime, about)..."
	@echo "Testing Home page (mobile)..."
	lighthouse "$(LOCAL_URL)" --output-path="./lighthouse/home-mobile-$(TIMESTAMP).html" --view
	@echo "Testing Home page (desktop)..."
	lighthouse "$(LOCAL_URL)" --output-path="./lighthouse/home-desktop-$(TIMESTAMP).html" --preset=desktop --view
	@echo "Testing Maritime page (mobile)..."
	lighthouse "$(LOCAL_URL)/maritime/" --output-path="./lighthouse/maritime-mobile-$(TIMESTAMP).html" --view
	@echo "Testing Maritime page (desktop)..."
	lighthouse "$(LOCAL_URL)/maritime/" --output-path="./lighthouse/maritime-desktop-$(TIMESTAMP).html" --preset=desktop --view
	@echo "Testing About page (mobile)..."
	lighthouse "$(LOCAL_URL)/about/" --output-path="./lighthouse/about-mobile-$(TIMESTAMP).html" --view
	@echo "Testing About page (desktop)..."
	lighthouse "$(LOCAL_URL)/about/" --output-path="./lighthouse/about-desktop-$(TIMESTAMP).html" --preset=desktop --view

# Run full lighthouse tests on remote (home, maritime, about) in both mobile and desktop
lh-remote-full:
	@echo "Running full Lighthouse tests on remote (home, maritime, about)..."
	@echo "Testing Home page (mobile)..."
	lighthouse "$(REMOTE_URL)" --output-path="./lighthouse/home-mobile-remote-$(TIMESTAMP).html" --view
	@echo "Testing Home page (desktop)..."
	lighthouse "$(REMOTE_URL)" --output-path="./lighthouse/home-desktop-remote-$(TIMESTAMP).html" --preset=desktop --view
	@echo "Testing Maritime page (mobile)..."
	lighthouse "$(REMOTE_URL)/maritime/" --output-path="./lighthouse/maritime-mobile-remote-$(TIMESTAMP).html" --view
	@echo "Testing Maritime page (desktop)..."
	lighthouse "$(REMOTE_URL)/maritime/" --output-path="./lighthouse/maritime-desktop-remote-$(TIMESTAMP).html" --preset=desktop --view
	@echo "Testing About page (mobile)..."
	lighthouse "$(REMOTE_URL)/about/" --output-path="./lighthouse/about-mobile-remote-$(TIMESTAMP).html" --view
	@echo "Testing About page (desktop)..."
	lighthouse "$(REMOTE_URL)/about/" --output-path="./lighthouse/about-desktop-remote-$(TIMESTAMP).html" --preset=desktop --view

# Create lighthouse directory if it doesn't exist
lighthouse:
	mkdir -p lighthouse

# Help target
help:
	@echo "Available targets:"
	@echo "  lh               - Run both mobile and desktop lighthouse tests locally"
	@echo "  lh-remote        - Run both mobile and desktop lighthouse tests on remote"
	@echo "  lh-full          - Run tests on home, maritime, and about pages locally"
	@echo "  lh-remote-full   - Run tests on home, maritime, and about pages on remote"
	@echo "  lh-mobile        - Run mobile lighthouse test locally"
	@echo "  lh-desktop       - Run desktop lighthouse test locally"
	@echo "  lh-mobile-remote - Run mobile lighthouse test on remote"
	@echo "  lh-desktop-remote- Run desktop lighthouse test on remote"
	@echo ""
	@echo "Usage with slug:"
	@echo "  make lh SLUG=maritime     - Test http://127.0.0.1:1111/maritime"
	@echo "  make lh-remote SLUG=maritime - Test https://www.sereno.insure/maritime"