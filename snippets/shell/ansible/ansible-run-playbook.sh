# ansible: run playbook on production
ansible-playbook -i ./production --vault-password-file .vault-password site.yml
