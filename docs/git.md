# Tuto git

## Création du compte git

	https://github.com/cpunivangers

## Ajout du dépot

	https://github.com/cpunivangers/Chromebook
	
## Cloner le dépot en local avec accès ssh

### Clé SSH
- Ajouter la clé publique de votre poste (~/.ssh/id_rsa.pub) sur le dépot
- Dans le dépot <>Code > Clone > **SSH**
- Récupérer l'adresse : git@github.com:cpunivangers/Chromebook.git

### Cloner le dépot dans votre répertoire de travail (.../ansible)

    sudo apt install git
    cd .../ansible
	git clone git@github.com:cpunivangers/Chromebook.git

### Si vous avez cloné le dépot en https, vous devrez changer url pour passer en ssh

	cd Chromebook
	git clone https://github.com/cpunivangers/Chromebook
	git remote set-url origin git@github.com:cpunivangers/Chromebook.git
	
## Configuration

	git config user.email "christian.pottier@univ-angers.fr"
	git config user.name "cpunivangers"

## Utilisation
	
	git status
	
- Mettre vos fichiers
- Ajouter au suivi
	git add --all
- Enregister le commit
	git commit -m "init"
- Publier et vérifier
	git push
	git status
	
- Ajouter les fichier modifiés

		git add -A

- Liste des branches

	git branch -v
	
### Mise à zéro du git

	rm -rf .git
	git init
	git config user.email "christian.pottier@univ-angers.fr"
	git config user.name "cpunivangers"
	git remote add origin git@github.com:cpunivangers/Chromebook.git
	git add -A
	git commit -m "raz"
	git push -f origin main

### Release

    sudo apt install git-extras
    


    OWNER=
    REPOSITORY=
    ACCESS_TOKEN=
    VERSION=
    curl --data '{"tag_name": "$VERSION",
                "target_commitish": "master",
                "name": "$VERSION",
                "body": "Release of version $VERSION",
                "draft": false,
                "prerelease": false}' \
    https://api.github.com/repos/$OWNER/$REPOSITORY/releases?access_token=$ACCESS_TOKEN

### tags

- tag local

    git tag

- tags distants
 
    git ls-remote --tags
    git ls-remote --tags --refs origin | cut -f2

- Suppression tags distants

    git ls-remote --tags --refs origin | cut -f2 | grep "11.2302" | xargs git push origin --delete
