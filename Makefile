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
	terraform plan -var namespace=kafka-logs -out plan.out

.PHONY: apply
apply: plan.out ## Apply the plan
	terraform apply ./plan.out
	rm -f plan.out
