date
#~ echo 'time (smbclient -A ~/.auth //ad.univ-angers.fr/espace_des_personnels/IUT -c "ls")'
#~ time (smbclient -A ~/.auth //ad.univ-angers.fr/espace_des_personnels/IUT -c "ls")
#~ date
echo 'time (smbclient -A ~/.auth //postes.stoc.univ-angers.fr/sp_iut -c "ls")'
time (smbclient -A ~/.auth //postes.stoc.univ-angers.fr/sp_iut -c "ls")
date
