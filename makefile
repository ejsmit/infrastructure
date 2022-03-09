VAULTPASSWORD = ~/.private/ansible/vault_password.txt


help:
	@echo My Infrastructure Project

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
	cd ansible; ansible-playbook feedserver.yml

dnsserver: private
	cd ansible; ansible-playbook dnsserver.yml

dnsserver_local: private
	cd ansible; ansible-playbook dnsserver_local.yml



# Ansible bootstrap

# usage: HOSTNAME=newname make bootstrap-raspbian
bootstrap-raspbian: private
	ssh-copy-id -i ~/.ssh/id_ed25519.pub pi@raspberrypi.local
	cd ansible; ansible raspberrypi.local -m ping -u pi
	cd ansible; ansible-playbook bootstrap-raspbian.yml






# ansible housekeeping

reqs:
	cd ansible; ansible-galaxy role install -r requirements.yml
	cd ansible; ansible-galaxy collection install -r requirements.yml

forcereqs:
	cd ansible; ansible-galaxy role install -r requirements.yml --force
	cd ansible; ansible-galaxy collection install -r requirements.yml --force

decrypt: private
	cd ansible; ansible-vault decrypt vars/vault-cloud.yml

encrypt: private
	cd ansible; ansible-vault encrypt --encrypt-vault-id ejsmit vars/vault-cloud.yml


private: $(VAULTPASSWORD)

$(VAULTPASSWORD):
	@echo "ERROR: PRIVATE not mounted"
	@false



