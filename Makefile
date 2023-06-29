SHELL:=bash

.PHONY: generate-values
generate-values:
	@echo "# This file was autogenerated." > charts/kubewarden-crds/values.yaml
	@echo >> charts/kubewarden-crds/values.yaml
	@cat charts/kubewarden-crds/chart-values.yaml >> charts/kubewarden-crds/values.yaml
	@echo "# This file was autogenerated." > charts/kubewarden-controller/values.yaml
	@echo >> charts/kubewarden-controller/values.yaml
	@cat common-values.yaml charts/kubewarden-controller/chart-values.yaml >> charts/kubewarden-controller/values.yaml
	@echo "# This file was autogenerated." > charts/kubewarden-defaults/values.yaml
	@echo >> charts/kubewarden-defaults/values.yaml
	@cat common-values.yaml charts/kubewarden-defaults/chart-values.yaml >> charts/kubewarden-defaults/values.yaml

.PHONY: check-generated-values
check-generated-values: generate-values
	@sh -c 'git diff --exit-code charts || (echo; echo "There are chart differences that have to be checked in"; exit 1)'

.PHONY: generate-images-file
generate-images-file:
	@./scripts/extract_images.sh ./charts

.PHONY: generate-policies-file
generate-policies-file:
	@./scripts/extract_policies.sh ./charts

.PHONY: generate-changelog-files
generate-changelog-files:
	@./scripts/generate_changelog_files.sh ./charts imagelist.txt

.PHONY: shellcheck
shellcheck:
	shellcheck scripts/*


