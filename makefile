
tfinit:
	cd terraform/cloud; terraform init

tfplan: 
	cd terraform/cloud; terraform plan

tfapply:
	cd terraform/cloud; terraform apply

tfdestroy:
	cd terraform/cloud; terraform destroy


demo:
	cd ansible; ansible-playbook -b run.yaml --limit demo --ask-become-pass

demorepl:
	cd ansible; ansible-playbook -b run.yaml --limit demo --tags replication

democomp:
	cd ansible; ansible-playbook run.yaml --limit demo --tags compose

status:
	cd ansible; ansible-playbook -b run.yaml --limit status --ask-become-pass

statuscomp:
	cd ansible; ansible-playbook run.yaml --limit status --tags compose

# ansible housekeeping

reqs:
	cd ansible; ansible-galaxy install -r requirements.yaml

forcereqs:
	cd ansible; ansible-galaxy install -r requirements.yaml --force

decrypt:
	cd ansible; ansible-vault decrypt vars/vault.yaml

encrypt:
	cd ansible; ansible-vault encrypt vars/vault.yaml