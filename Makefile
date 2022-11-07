.PHONY: help
help: ## This help message
	@awk -F: \
		'/^([a-z]+.*): .*## (.+)$$/ {gsub(/: .*?\s*##/, "\t");print}' \
		Makefile \
	| expand -t20 \
	| sort

.terraform:
	terraform init

.PHONY: init
init: .terraform ## Initialize the environment

plan.out: .terraform ## Create the plan
	terraform plan -var-file values.tfvars -out plan.out

.PHONY: apply
apply: plan.out ## Apply the plan
	terraform apply ./plan.out
	rm -f plan.out

.PHONY: destroy
destroy: ## Destroy the deployment
	terraform destroy -var-file values.tfvars

.PHONY: show
show: ## Prints the resources
	@terraform show

.PHONY: show-modules
show-modules: ## Prints the modules
	@terraform show | awk '/# module/ {gsub(":","");print $$2}'
