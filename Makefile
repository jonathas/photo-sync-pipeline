SHELL := /usr/bin/env bash
BIN_DIR := $(CURDIR)/bin
TARGET_BIN := $(HOME)/.local/bin
CONFIG_DIR := $(HOME)/.photo-sync-pipeline
CONFIG_FILE := $(CONFIG_DIR)/config.sh

.PHONY: help digital-frame export-since backups install uninstall deps doctor

help:
	@echo "Targets:"
	@echo "  make deps        Install/check dependencies"
	@echo "  make install     Install commands into ~/.local/bin"
	@echo "  make uninstall   Remove installed commands"
	@echo "  make doctor      Verify environment"
	@echo "  make digital-frame"
	@echo "  make export-since DATE=YYYY-MM-DD"

deps:
	@echo "▶ Checking dependencies"

	@command -v brew >/dev/null || { \
		echo "❌ Homebrew not found."; \
		echo "Install from https://brew.sh"; \
		exit 1; \
	}

	@command -v adb >/dev/null || { \
		echo "▶ Installing adb"; \
		brew install android-platform-tools; \
	}

	@command -v pipx >/dev/null || { \
		echo "▶ Installing pipx"; \
		brew install pipx; \
		pipx ensurepath; \
	}

	@command -v osxphotos >/dev/null || { \
		echo "▶ Installing osxphotos via pipx"; \
		pipx install osxphotos; \
	}

	@echo "✅ Dependencies installed (or already present)"

doctor:
	@echo "▶ Running environment checks"
	@echo ""

	@command -v osxphotos >/dev/null \
		&& echo "✅ osxphotos" \
		|| echo "❌ osxphotos missing"

	@command -v adb >/dev/null \
		&& echo "✅ adb" \
		|| echo "❌ adb missing"

	@command -v sips >/dev/null \
		&& echo "✅ sips" \
		|| echo "❌ sips missing"

	@command -v rsync >/dev/null \
		&& echo "✅ rsync" \
		|| echo "❌ rsync missing"

	@echo ""
	@echo "▶ ADB devices:"
	@adb devices || true

install:
	@echo "▶ Installing symlinks to $(TARGET_BIN)"
	@mkdir -p "$(TARGET_BIN)"
	@for f in $(BIN_DIR)/*; do \
		[ -x "$$f" ] || continue; \
		name=$$(basename $$f); \
		echo "  → $$name"; \
		ln -sf "$$f" "$(TARGET_BIN)/$$name"; \
	done
	@echo "✅ Commands installed"

	@mkdir -p "$(CONFIG_DIR)"
	@if [[ ! -f "$(CONFIG_FILE)" ]]; then \
		cp "$(CURDIR)/config.sh" "$(CONFIG_FILE)"; \
		echo "✅ Created config at $(CONFIG_FILE)"; \
	else \
		echo "✅ Config already exists at $(CONFIG_FILE)"; \
	fi
	@mkdir -p "$(CONFIG_DIR)/helpers"
	@cp -f "$(CURDIR)/helpers/"* "$(CONFIG_DIR)/helpers/"
	@echo "✅ Installed helpers to $(CONFIG_DIR)/helpers"

	@if ! echo "$$PATH" | tr ':' '\n' | grep -qx "$(TARGET_BIN)"; then \
		echo ""; \
		echo "⚠️  $(TARGET_BIN) is not in your PATH."; \
		echo "Add this line to your shell config (e.g. ~/.zshrc):"; \
		echo ""; \
		echo "    export PATH=\"$(TARGET_BIN):\$$PATH\""; \
		echo ""; \
	else \
		echo "✅ $(TARGET_BIN) is already in PATH"; \
	fi

uninstall:
	@echo "▶ Removing symlinks from $(TARGET_BIN)"
	@for f in $(BIN_DIR)/*; do \
		[ -x "$$f" ] || continue; \
		name=$$(basename $$f); \
		rm -f "$(TARGET_BIN)/$$name"; \
	done
	@rm -rf "$(CONFIG_DIR)"
	@echo "✅ Symlinks removed"

digital-frame:
	@./bin/export-digital-frame

export-since:
	@if [[ -z "$(DATE)" ]]; then echo "❌ Missing DATE. Example: make export-since DATE=2026-01-25"; exit 1; fi
	@./bin/export-photos-since "$(DATE)"

backups:
	@./bin/sync-external-drive
	@./bin/sync-backup-drives
