## plugin panel (tableau de bord)

/etc/xdg/xfce4/panel/default.xml

	# Dernier id plugin
	PLUGIN_ID=$(xfconf-query -n -c xfce4-panel -p "/panels/panel-1/plugin-ids" -a | sort -rn | head -1)
	# incremente
	((PLUGIN_ID++))
	# ajout plugin
	xfconf-query -c xfce4-panel -pn "/plugins/plugin-$PLUGIN_ID" -t string -s 'power-manager-plugin'
	# redemarrage tableau de bord
	xfce4-panel --restart
	

Essai non concluant !  A suivre

Liste les valeurs

	xfconf-query -c xfce4-panel -lv

Process

	pgrep -u bonjour xfconfd

Tue le process

	pkill -u bonjour xfconfd
	rm -rd ~/.cache/sessions

Simul graphique

	xvfb-run -a xfconf-query
	
Session graphique en-cours

USERDISPLAY=$(who | grep "(:0)" | cut -d" " -f1)

DISPLAY=:0 sudo -u $USERDISPLAY cmd

## default
cp /etc/xdg/xfce4/panel/default.xml ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml