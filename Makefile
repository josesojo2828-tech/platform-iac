.PHONY: fmt validate plan apply destroy ansible-syntax ansible-lint ansible-run

fmt:
	terraform -chdir=terraform fmt -recursive

validate:
	terraform -chdir=terraform init -backend=false -input=false
	terraform -chdir=terraform validate

plan:
	terraform -chdir=terraform plan -out=tfplan

apply:
	terraform -chdir=terraform apply tfplan

destroy:
	terraform -chdir=terraform destroy

ansible-syntax:
	cd ansible && ansible-playbook -i inventory/example/hosts.yml --syntax-check site.yml

ansible-lint:
	cd ansible && ansible-lint

ansible-run:
	cd ansible && ansible-playbook site.yml
