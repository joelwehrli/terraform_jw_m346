terraform init
sleep 20
terraform fmt
sleep 10
terraform plan -out=job2do
sleep 20
terraform apply job2do
sleep 60

paste inventory/group_vars/all/name.txt inventory/group_vars/all/ip.txt > inventory/group_vars/all/ds_ip.txt
sleep 10
cat inventory/group_vars/all/ds_ip.txt >> inventory/group_vars/all/vars.yml
sleep 15
ansible-playbook -i inventory/hosts site.yml --ask-vault-pass