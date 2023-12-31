.DEFAULT: help
.PHONY: help
help:
	@grep -E -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: container
container: ## Run the ubuntu container for testing locally
container:
	docker run --rm -it --mount "type=bind,source=$(PWD),target=/ppa" ubuntu

.PHONY: run_workflow
run_workflow: ## Run the github actions workflow
run_workflow:
	gh workflow run  update_ppa.yml && sleep 5 && gh run list