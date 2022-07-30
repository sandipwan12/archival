# commands
ANSIBLE=ansible
PLAYBOOK=ansible-playbook
 
check-env:
ifndef ENV_NAME
    $(error ENV_NAME is undefined)
endif
 
# playbooks
S3UPLOAD_PLAYBOOK=upload-jar.yml
