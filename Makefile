# commands
ANSIBLE=ansible
PLAYBOOK=ansible-playbook

## set debug var
PLAYBOOK_DEBUG ?= 
## set ansible debug mode on if the DEBUG var is passed in
ifdef DEBUG
PLAYBOOK_DEBUG = -vvvv
endif

check-env:
ifndef ENV_NAME
    $(error ENV_NAME is undefined)
endif
 
# playbooks
S3UPLOAD_PLAYBOOK=upload-jar.yml
 
# setup-environment: check-env
#                 rm -rf wis-archive-env-config-$(ENV_NAME)
#                 git clone git@github.aus.thenational.com:wis-ansible/wis-archive-env-config-$(ENV_NAME).git
 
upload-jar: setup-environment
    $(PLAYBOOK) $(PLAYBOOK_DEBUG) -i /inventory $(S3UPLOAD_PLAYBOOK)