# Modifications fichiers Ansible

## Ansible pip dans un environnement virtuel python

https://www.redhat.com/sysadmin/python-venv-ansible

### Environnement virtuel python

- Création environnement virtuel python :

      sudo apt install python3-venv
      python3 -m venv /opt/ansible/vansible

- Activation environnement :

      source /opt/ansible/vansible/bin/activate

- Mettre à jour pip sous l'environnement python (ansible_pip)$

      python3 -m pip install --upgrade pip

### Installation ansible

    python3 -m pip install ansible

Vérification :

    ansible --version

### Ajout pour machine windows
    python3 -m pip install --upgrade pywinrm
    ansible-galaxy collection install ansible.windows -p /usr/share/ansible/collections/

### Quitter environnement python

    deactivate
    

## Ansible 2.14.2

### Dans le dossier tasks :

- warn:  

      grep -ir "  warn:"

Supprimer ou commenter manuellement :

      args:  
        warn: false 

- remplacer include:

      find . -type f -iname '*.yml' | xargs sed -i -e "s/- include:/- import_tasks:/g"
      

### Dans le dossier playbooks :

- warn:  

      grep -ir "  warn:"

Supprimer ou commenter manuellement :

      args:  
        warn: false 

- remplacer include:

      find . -type f -iname '*.yml' | xargs sed -i -e "s/- include: tasks/- import_tasks: tasks/g"

      find . -type f -iname '*.yml' | xargs sed -i -e "s/- include: repo/- import_tasks: repo/g"
      


## tasks_gen (11/04/2023) :

- dans le dossiers tasks

      find . -type f -iname '*.yml' | xargs sed -i -e "s;- import_tasks: repo_install_exe.yml;- import_tasks: tasks_gen/repo_install_exe.yml;g"
      
      find . -type f -iname '*.yml' | xargs sed -i -e "s;- import_tasks: repo_install_bat.yml;- import_tasks: tasks_gen/repo_install_bat.yml;g"
       
      find . -type f -iname '*.yml' | xargs sed -i -e "s;- import_tasks: get_install.yml;- import_tasks: tasks_gen/get_install_exe.yml;g"
      
      find . -type f -iname '*.yml' | xargs sed -i -e "s;- import_tasks: pkg_vers.yml;- import_tasks: tasks_gen/pkg_vers.yml;g"

      find . -type f -iname '*.yml' | xargs sed -i -e "s;- include_tasks: pkg_vers.yml;- include_tasks: tasks_gen/pkg_vers.yml;g"


