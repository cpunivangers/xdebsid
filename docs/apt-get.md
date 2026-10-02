Apt-get : les principales commandes

    apt-get update : mettra à jour la liste des paquets disponibles dans les dépôts.
    apt-get upgrade : mettra à jour les paquets installés dont une version plus récente existe.
    apt-get dist-upgrade : idem à la commande précédente mais est plus approprié par sa gestion plus intelligente des dépendances, surtout pour une mise à niveau de votre distribution, par exemple pour passer de testing à unstable.
    apt-get dist-upgrade -s : permet de simuler l'upgrade, ce qui permettra de vérifier sans casser votre système si une mise à jour implique une désinstallation d'éventuelles autres paquets déjà dans votre système.
    apt-get check : permet de mettre à jour le cache des paquets et cherche des dépendances défectueuses.

    apt-get install lepaquet : pour installer un paquet.
    apt-get install -s lepaquet : simulera l'installation d'un paquet.

    apt-get remove lepaquet : désinstallera le paquet.
    apt-get remove –purge lepaquet : incluera les fichiers de configuration.
    apt-get autoremove :permet de supprimer les dépendances restantes de paquets désinstallés.

    apt-cache search lepaquet : permet la recherche d'un paquet.
    apt-file search lepaquet :permet une recherche des paquets contenant tel fichier, si apt-file n'est pas installé il suffit de le faire et exécuter cette commande apt-file update pour mettre à jour la liste du contenu des paquets.
    apt-file list lepaquet : listera les fichiers contenus dans un paquet (installé ou non).
    apt-cache pkgnames : permet une recherche à partir d'un préfixe.
    apt-cache policy lepaquet : affichera la disponibilité d'un paquet,sa version et dans quels dépôts.
    apt-cache madison lepaquet : donne la version d'un paquet installé ou disponible.

    apt-cache show lepaquet : affiche les propriétés d'un paquet qu'il soit installé ou pas.
    apt-show-versions : liste les paquets installés,leurs noms,distribution,la version installé, et indique si une version plus récente et disponible, si apt-show-versions n'est pas installé, installé le puis saisissez la commande.
    apt-show-versions -i : pour mettre à jour le cache.
    apt-show-versions -u : permet de lister les paquets dont une version plus récente est disponible dans les dépôts.

    apt-cache depends lepaquet : affiche les dépendances d'un paquet en incluant les conflits et paquets suggérés.

    dpkg-deb --info lepaquet : affiche les infos et les dépendances

    apt-cache show pkg | grep 'Depends' : affiche les dépendances d'un paquet (changer pkg par le nom du paquet concerné).
    apt-rdepends lepaquet : donne les dépendances d'un paquet ainsi que les dépendances des dépendances.
    apt-rdepends -r lepaquet : donne la liste des paquets ayant comme dépendance le paquet donné en argument.

    apt-get clean : nettoie le cache des paquets installés, à faire assez souvent pour éviter de remplir trop les répertoires concernés (/var/cache/apt/archives/ et /var/cache/apt/archives/partial/).
    apt-get autoclean : supprime uniquement les paquets qui ne peuvent plus être téléchargés et qui sont grandement inutiles.

Voir les paquets non libre
	$ vrms

Dates installation des paquets :
	zgrep -h " installed " /var/log/dpkg.log* | sort

Voir les paquets avec version dans les backports
	aptitude search -t $(lsb_release -sc)-backports -F '%p %v -> %V' '~U ~Abackports'
Simule la mise à jour avec les backports
	sudo apt-get upgrade -s -t $(lsb_release -sc)-backports
List les paquets installés depuis les backports
	aptitude search '~S ~i ~O"Debian Backports"'
List les paquets installés non Debian
	sudo aptitude search "?installed?not(?origin(Debian))"
List les paquets installés d'un depot
	sudo aptitude search "?installed?origin($(grep -i 'origin:' /var/lib/apt/lists/www.deb-multimedia.org_dists_jessie_InRelease | cut -d" " -f2-))"




La gestion des paquets (installation, suppression, mise à jour, ...) sous Debian peut se faire avec différents outils. On connaît généralement apt-get et aptitude qui sont incontournables. Il existe également des interfaces graphiques comme synaptic, gnome-software et d'autres qui pourront rassurer certains (mais que je ne recommanderai pas). Face à ces outils, APT est la solution à utiliser pour la gestion des paquets au quotidien sous Debian. APT est facile à utiliser et dispose de toutes les fonctions de bases qui vous seront utiles.

Comme définit dans le man, APT est conçu comme une interface utilisateur et permet certaines options plus adaptées à une utilisation interactive. Toutes les opérations essentielles sont donc disponibles, de l'installation, à la mise à jour jusqu'à la suppression de paquets. Certaines fonctionnalités ont été ajoutés comme l'édition des sources ou la fonction list.

J'avais déjà présenté APT pour Jessie mais depuis Stretch on a le droit à quelques nouveautés.
La documentation n'étant pas exhaustive, c'est l'occasion de faire le point sur cet outil.
Sommaire

    Mettre à jour la liste des paquets
    Installer les mises à jours
    Mettre à jour le système
    Installer un paquet
    Supprimer un paquet
    Supprimer les paquets inutilisés
    Supprimer les fichiers de configuration d'un paquet
    Éditer le fichier sources.list
    Trouver des informations sur un paquet
    Rechercher un paquet
    Lister les paquets installés
    Lister les paquets prêts à être mis à jour
    Lister toutes les versions d'un paquet
    Simuler l'installation ou la mise à jour de paquets
    Ressources

Mettre à jour la liste des paquets

La commande update permet simplement d'actualiser la liste des paquets disponibles pour votre système.

#root

apt update

Cette commande ne modifie pas le système, elle se contente de demander s'il existe de nouveaux paquets ou des nouvelles versions disponibles pour votre distribution.

L'utilisation de apt update est généralement le préalable avant toute opération effectuée avec APT.
Installer les mises à jours

Il est nécessaire de garder son système à jour et d'installer les dernières versions des paquets disponibles. Cela permet de corriger les bugs existants et d'installer les correctifs de sécurité.

#root

apt upgrade

De nouveaux paquets peuvent être installés si c'est nécessaire, mais les paquets installés ne seront jamais supprimés.
Cette commande est "sans risque".
Mettre à jour le système

La commande full-upgrade remplit sensiblement la même fonction que upgrade à la différence qu'elle peut aussi supprimer des paquets installés si cela est nécessaire pour résoudre un conflit entre des paquets. On utilise généralement cette commande lors du basculement d'une version majeure de Debian à la suivante (Jessie > Stretch).

#root

apt full-upgrade

Prenez le temps de lire les modifications qui seront effectuées sur votre système avant de valider l’exécution de la commande.
Installer un paquet

L'ajout d'un/plusieurs paquet(s) se fait avec la commande install qui gérera automatiquement l'installation de toutes les dépendances nécessaires au fonctionnement du logiciel.

#root

apt install 

correspondant au nom exact du logiciel que l'on veut installer. Par exemple, pour installer le jeu SuperTux, la commande sera: apt install supertux.
Pour trouver le nom exact du paquet, il est possible d'utiliser la commande search ou depuis la page https://www.debian.org/distrib/packages#search_packages qui recense tous les paquets.
Installer plusieurs paquets

On peut installer plusieurs paquets en même temps en séparant le nom des paquets par un espace.

#root

apt install    

Installer un paquet .deb

Si vous avez besoin d'installer un paquet hors des dépôts mais que vous avez à disposition un paquet .deb, il suffit de lancer la commande:

#root

apt install /tmp/gnome-theme-gilouche_11.1.2-2_all.deb

Installer un paquet en modifiant les priorités

Si vous utilisez les dépôts de rétroportage (backports) ou si vous utilisez plusieurs branches de Debian (pinning) ou des dépôts tiers, il est possible de forcer l'installation d'un paquet (et ses dépendances) d'une branche spécifique:

#root

apt install -t stretch-backports  

Cette commande permet d'installer la version plus récente d'un paquet présent dans les dépôts backports de Stretch.

L'utilisation des dépôts backports ne présente généralement pas de risque, mais dans les autres cas (pinning ou dépôt tiers), vérifier les modifications qui seront effectuées avant de valider les opérations.
Supprimer un paquet

Il arrive que certains paquets ne vous soient plus utiles, dans ce cas il est préférable de les désinstaller. La commande remove permet de supprimer un paquet présent sur votre système.

#root

apt remove   

La commande supprimera également les dépendances qui ne sont plus nécessaires. Encore une fois, vérifiez la liste des paquets qui seront supprimés avant de valider les opérations.
Supprimer les paquets inutilisés

La commande autoremove supprime les paquets installés automatiquement dans le but de satisfaire les dépendances d'autres paquets et qui ne sont plus nécessaires.

#root

apt autoremove

Supprimer les fichiers de configuration d'un paquet

La suppression d'un paquet conserve habituellement les fichiers de configuration. La commande purge permet de supprimer ces fichiers néanmoins cela n'affecte aucune donnée ou configuration stockées dans votre répertoire personnel.

#root

apt purge 

La commande peut s'effectuer sur des paquets déjà supprimés.
Éditer le fichier sources.list

Il est parfois nécessaire d'éditer les sources de son système en modifiant le fichier /etc/apt/sources.list. Généralement pour l'ajout des sections non libres et des dépôts tiers.
La commande edit-sources permet de bénéficier de la coloration syntaxique et fournit des vérifications de sécurité de base.

#root

apt edit-sources

Il est nécessaire de lancer la commande update pour que les modifications soient prises en compte.
Éditer les fichiers dans sources.list.d

Pour éditer un fichier présent dans le répertoire /etc/apt/sources.list.d/, il faut spécifier son nom.

#root

apt edit-sources deb-multimedia.list

Exemple pour éditer le fichier /etc/apt/sources.list.d/deb-multimedia.list
Premier lancement et choix de l'éditeur de texte

Lors du premier lancement de la commande edit-sources, vous devrez choisir l'éditeur de texte à utiliser.

#root

Select an editor.  To change later, run 'select-editor'.
  1. /bin/nano        <---- easiest
  2. /usr/bin/vim.tiny
Choose 1-2 [1]:

Si vous ne savez pas lequel choisir, je vous recommande l'utilisation de nano en tapant 1.

Pour se déplacer dans le document avec nano, il faut utiliser les ← ↑ → ↓ du clavier. Pour coller le texte, il faut utiliser les raccourcis clavier Maj+Ctrl+V. Pour enregistrer les modifications, utilisez Ctrl+O et fermez l'éditeur de texte avec Ctrl+X.
Trouver des informations sur un paquet

La commande show affiche toutes les informations détaillées sur le paquet. Parmi les informations disponibles, on retrouve les dépendances, la taille installée et au téléchargement, la version et la description du paquet.

$user

apt show  

Rechercher un paquet

La commande search permet la recherche sur le terme donné et affiche les paquets correspondants.

$user

apt search 

Utile quand veut installer un paquet dont on ne connaît pas le nom exact. On pourra lancer la commande show pour obtenir plus d'informations.
Lister les paquets installés

Pour lister tous les paquets installés sur le système:

$user

apt list --installed

Lister les paquets prêts à être mis à jour

Pour lister tous les paquets prêts qui seront installés lors de la prochaine mise à jour (apt upgrade).

$user

apt list --upgradeable

Lister toutes les versions d'un paquet

Pour lister toutes les versions disponibles d'un paquet:

$user

apt list --all-versions 

Cette commande est utile si vous utilisez des dépôts tiers ou si vous utilisez plusieurs branches de Debian.
Simuler l'installation ou la mise à jour de paquets

Pour simuler l'installation ou la mise à jour de paquets sans risquer de casser son système:

#root

apt -s install 
apt -s full-upgrade

