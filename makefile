VAULTPASSWORD = ~/.private/ansible/vault_password.txt


# Terraform

tfinit:
	cd terraform/cloud; terraform init

tfplan: 
	cd terraform/cloud; terraform plan

tfapply:
	cd terraform/cloud; terraform apply

tfdestroy:
	cd terraform/cloud; terraform destroy

# Ansible

feedserver: private
	cd ansible; ansible-playbook -b run.yaml --limit demo

# demorepl:
# 	cd ansible; ansible-playbook -b run.yaml --limit demo --tags replication

# democomp:
# 	cd ansible; ansible-playbook run.yaml --limit demo --tags compose

# status:
# 	cd ansible; ansible-playbook -b run.yaml --limit status --ask-become-pass

# statuscomp:
# 	cd ansible; ansible-playbook run.yaml --limit status --tags compose

# ansible housekeeping

reqs:
	cd ansible; ansible-galaxy role install -r requirements.yml
	cd ansible; ansible-galaxy collection install -r requirements.yml

forcereqs:
	cd ansible; ansible-galaxy role install -r requirements.yml --force
	cd ansible; ansible-galaxy collection install -r requirements.yml --force

private: $(VAULTPASSWORD)

$(VAULTPASSWORD):
	@echo "ERROR: PRIVATE not mounted"
	@false

# decrypt:
# 	cd ansible; ansible-vault decrypt vars/vault.yaml

# encrypt:
# 	cd ansible; ansible-vault encrypt vars/vault.yaml



# Some private housekeeping

