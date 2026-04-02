base-temp := ./template.json
bl-temp := ./template-borderless.json
extension := ./extension.json
out-dir := ./stylesheets/

build: bordered
	echo "Package files into importable flex archive"
	zip -r rosepine-$(GITHUB_REF_NAME).flex $(out-dir) $(extension)

bordered: borderless
	echo "Buidling bordered variant..."
	bloom.exe build $(base-temp) --format rgb --plain -o $(out-dir)

borderless:
	echo "Buidling borderless variant..."
	$(MAKE) clean
	bloom.exe build $(bl-temp) --format rgb --plain -o $(out-dir)
	@for f in $(out-dir)/*.json; do mv "$$f" "$${f%.json}-borderless.json"; done

clean:
	echo "Cleaning up..."
	rm $(out-dir)/*
