# commands
ANSIBLE=ansible
PLAYBOOK=ansible-playbook
 
check-env:
ifndef ENV_NAME
    $(error ENV_NAME is undefined)
endif
 
# playbooks
S3UPLOAD_PLAYBOOK=upload-jar.yml

setup-environment: check-envrm -rf hello-env-config-$(ENV_NAME)
    git clone https://github.com/sandipwan12/hello-env-config-nonprod.git
 
upload-jar: setup-environment
    $(PLAYBOOK) $(PLAYBOOK_DEBUG) -i hello-env-config-$(ENV_NAME)/inventory $(S3UPLOAD_PLAYBOOK)