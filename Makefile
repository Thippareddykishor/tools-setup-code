infra:
	git pull
	terraform init -backend-config=state.tf
	terraform apply -auto-approve