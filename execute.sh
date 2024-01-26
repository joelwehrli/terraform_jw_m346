terraform init
sleep 20
terraform fmt
sleep 10
terraform plan -out=job2do
sleep 20
terraform apply job2do
sleep 60


ipaddress=$(cat inventory/group_vars/all/ip.txt)
sleep 5
sed -i 's/datasource\:/datasource: '"$ipaddress"'/' inventory/group_vars/all/vars.yml
sleep 15
ansible-playbook -i inventory/hosts site.yml --ask-vault-pass