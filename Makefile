BUNDLER_VERSION ?= 2.4.22
BUNDLER_LIB := vendor/bundle-tools/gems/bundler-$(BUNDLER_VERSION)/lib
BUNDLER_EXE := vendor/bundle-tools/gems/bundler-$(BUNDLER_VERSION)/exe/bundle
BUNDLE ?= ruby -I$(BUNDLER_LIB) $(BUNDLER_EXE)
JEKYLL ?= $(BUNDLE) exec jekyll

.PHONY: setup build check serve

setup:
	test -f $(BUNDLER_EXE) || gem install bundler --version $(BUNDLER_VERSION) --install-dir vendor/bundle-tools --no-document
	$(BUNDLE) config set --local path vendor/bundle
	$(BUNDLE) config set --local force_ruby_platform true
	$(BUNDLE) install

build:
	$(JEKYLL) build

check: build
	ruby scripts/check_site_content.rb

serve:
	$(JEKYLL) serve --config _config.yml,_config.local.yml -H 127.0.0.1 --port 4000
