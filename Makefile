# No default value for COMPONENT anymore

# Check if COMPONENT is defined
check_component:
ifndef COMPONENT
	$(error COMPONENT is not defined. Please specify a component, e.g., make apply COMPONENT=lb_nginx)
endif

init: check_component
	cd environments/$(COMPONENT) && terraform init

plan: check_component
	cd environments/$(COMPONENT) && terraform plan

apply: check_component
	cd environments/$(COMPONENT) && terraform apply -auto-approve

destroy: check_component
	cd environments/$(COMPONENT) && terraform destroy -auto-approve