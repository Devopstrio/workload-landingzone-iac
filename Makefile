.PHONY: help init plan apply destroy validate lint

help:
	@echo "Workload Landing Zone IaC - Management Commands"
	@echo "---------------------------------------------"
	@echo "init      : Initialize Terraform"
	@echo "plan      : Generate Terraform plan (dev)"
	@echo "apply     : Apply Terraform changes (dev)"
	@echo "validate  : Validate Terraform configuration"
	@echo "lint      : Run tflint"

init:
	cd environments/dev && terraform init

plan:
	cd environments/dev && terraform plan

apply:
	cd environments/dev && terraform apply -auto-approve

validate:
	terraform fmt -recursive
	terraform validate

lint:
	tflint --recursive
