Ansible Playbook erstellen in /home/joel


.venv erstellen (python3 -m venv .venv) nur einmalig
requirements.txt erstellen einmalig
pip install -r requirements.txt einmalig
source .venv/bin/activate jedes mal wenn neu starten


Inventory File erstellen unter inventory/hosts
Inventory Server erfassen
ansible.cfg File erstellen


VM im MAAS erstellen und Name + IP ins hosts eintragen

#cloud-config
#2023-11-22
#Versuch mit ansible

packages_update: true
package_upgrade: false

packages:
  - ansible

users:
  - default
  - name: ansible
    sudo: ALL=(ALL) NOPASSWD:ALL
    ssh_authorized_keys:
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDMrZFkqg2ABZeCNzuaAsQ/35UQLvW2Tnc7/VUXRCgUP1dntEgfakXAJ4hRHme53UL+QezYtaAb886lynMhbpLxE2IF2hgYtnifvejbFqY8GwCHy03Zbw57oS1/EslWabR0uRArfuEWhksQwrbrxEjggchwzRhc82GqpPggUTz0VAGUqAOLApTM/eP286uCoBmBSllnP6NTOIAg4suMikO9e3DV2OtWIo9QkyuCsaYy3YovxZ6QvmkKQ+ki+DAnRmH6Y38ZjoNEiiQ+Y353ge448vz0gK7F7cT2fEKIC8cI50SLti09jt1c3qX9Vk0VsROrK96slc+URkHUCsfJPfZnvBfzc/YR/abzcHvzvr3CHz+eyDDTf87ld+HlFIiepxD42usUhi01EVBZXV4/6gTQHZI7qYNiQoHWdnfjrLxQ4kryTafMzL9I2dVdBl1YMhznZmZti9sYHasLx0O6fpwc7qL8Oy3kIyIPORxaudMfHy8DpmI2NfyCCl54n9pOy3k= joel@DESKTOP-IQHMN51


ansible-galaxy role init appserver
ansible-galaxy role init dbserver



VM erstellt Befehle aus README.md von Git Bbw kopieren und auf VM ausführen + Java installieren --> später im Playbook
git clone https://gitlab.com/bbwrl/m346-ref-card-03.git
cd m346-ref-card-03
sudo apt-get install openjdk-18-jdk openjdk-18-demo openjdk-18-doc openjdk-18-jre-headless openjdk-18-source 
sudo apt install maven
MariaDB installieren sudo apt install mariadb-server
mvn package


CREATE DATABASE jokedb;
CREATE USER 'jokedbuser'@localhost IDENTIFIED BY '123456';
GRANT ALL PRIVILEGES ON 'jokedb'.* TO 'jokedbuser'@localhost;

mysql -u jokedbuser -p jokedb < schema.sql
mysql -u jokedbuser -p jokedb < data.sql

java -DDB_USERNAME="jokedbuser" -DDB_PASSWORD="123456" -jar target/architecture-refcard-03-0.0.1-SNAPSHOT.jar



datasource: "44.222.65.246"
sed -i '2 r ds_ip.txt' vars.txt



curl -LsS https://r.mariadb.com/downloads/mariadb_repo_setup | sudo  bash









#
# These groups are read by MariaDB server.
# Use it for options that only the server (but not clients) should see

# this is read by the standalone daemon and embedded servers
[server]

# this is only for the mysqld standalone daemon
[mysqld]

#
# * Basic Settings
#

#user                    = mysql
pid-file                = /run/mysqld/mysqld.pid
basedir                 = /usr
#datadir                 = /var/lib/mysql
#tmpdir                  = /tmp

# Broken reverse DNS slows down connections considerably and name resolve is
# safe to skip if there are no "host by domain name" access grants
#skip-name-resolve

# Instead of skip-networking the default is now to listen only on
# localhost which is more compatible and is not less secure.
#bind-address            = 127.0.0.1
bind-address            = 0.0.0.0

#
# * Fine Tuning
#

#key_buffer_size        = 128M
#max_allowed_packet     = 1G
#thread_stack           = 192K
#thread_cache_size      = 8
# This replaces the startup script and checks MyISAM tables if needed
# the first time they are touched
#myisam_recover_options = BACKUP
#max_connections        = 100
#table_cache            = 64

#
# * Logging and Replication
#

# Both location gets rotated by the cronjob.
# Be aware that this log type is a performance killer.
# Recommend only changing this at runtime for short testing periods if needed!
#general_log_file       = /var/log/mysql/mysql.log
#general_log            = 1

# When running under systemd, error logging goes via stdout/stderr to journald
# and when running legacy init error logging goes to syslog due to
# /etc/mysql/conf.d/mariadb.conf.d/50-mysqld_safe.cnf
# Enable this if you want to have error logging into a separate file
#log_error = /var/log/mysql/error.log
# Enable the slow query log to see queries with especially long duration
#slow_query_log_file    = /var/log/mysql/mariadb-slow.log
#long_query_time        = 10
#log_slow_verbosity     = query_plan,explain
#log-queries-not-using-indexes
#min_examined_row_limit = 1000

# The following can be used as easy to replay backup logs or for replication.
# note: if you are setting up a replication slave, see README.Debian about
#       other settings you may need to change.
#server-id              = 1
#log_bin                = /var/log/mysql/mysql-bin.log
expire_logs_days        = 10
#max_binlog_size        = 100M

#
# * SSL/TLS
#

# For documentation, please read
# https://mariadb.com/kb/en/securing-connections-for-client-and-server/
#ssl-ca = /etc/mysql/cacert.pem
#ssl-cert = /etc/mysql/server-cert.pem
#ssl-key = /etc/mysql/server-key.pem
#require-secure-transport = on

#
# * Character sets
#

# MySQL/MariaDB default is Latin1, but in Debian we rather default to the full
# utf8 4-byte character set. See also client.cnf
character-set-server  = utf8mb4
collation-server      = utf8mb4_general_ci

#
# * InnoDB
#

# InnoDB is enabled by default with a 10MB datafile in /var/lib/mysql/.
# Read the manual for more InnoDB related options. There are many!
# Most important is to give InnoDB 80 % of the system RAM for buffer use:
# https://mariadb.com/kb/en/innodb-system-variables/#innodb_buffer_pool_size
#innodb_buffer_pool_size = 8G

# this is only for embedded server
[embedded]

# This group is only read by MariaDB servers, not by MySQL.
# If you use the same .cnf file for MySQL and MariaDB,
# you can put MariaDB-only options here
[mariadb]

# This group is only read by MariaDB-10.6 servers.
# If you use the same .cnf file for MariaDB of different versions,
# use this group for options that older servers don't understand
[mariadb-10.6]
    