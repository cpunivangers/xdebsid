<!DOCTYPE html>
<html lang='en'>
<head>
<title>build-backport.sh - deb-bpo-builder - Debian backports builder</title>
<meta name='generator' content='cgit v1.2.3'/>
<meta name='robots' content='index, nofollow'/>
<link rel='stylesheet' type='text/css' href='/cgit.css'/>
<link rel='shortcut icon' href='/favicon.ico'/>
<link rel='alternate' title='Atom feed' href='https://git.vv221.fr/deb-bpo-builder/atom/build-backport.sh?h=master' type='application/atom+xml'/>
</head>
<body>
<div id='cgit'><table id='header'>
<tr>
<td class='logo' rowspan='2'><a href='/'><img src='/logo.png' alt='cgit logo'/></a></td>
<td class='main'><a href='/'>index</a> : <a href='/deb-bpo-builder/'>deb-bpo-builder</a></td><td class='form'><form method='get'>
<select name='h' onchange='this.form.submit();'>
<option value='master' selected='selected'>master</option>
</select> <input type='submit' value='switch'/></form></td></tr>
<tr><td class='sub'>Debian backports builder</td><td class='sub right'>vv221</td></tr></table>
<table class='tabs'><tr><td>
<a href='/deb-bpo-builder/'>summary</a><a href='/deb-bpo-builder/refs/'>refs</a><a href='/deb-bpo-builder/log/build-backport.sh'>log</a><a class='active' href='/deb-bpo-builder/tree/build-backport.sh'>tree</a><a href='/deb-bpo-builder/commit/build-backport.sh'>commit</a><a href='/deb-bpo-builder/diff/build-backport.sh'>diff</a></td><td class='form'><form class='right' method='get' action='/deb-bpo-builder/log/build-backport.sh'>
<select name='qt'>
<option value='grep'>log msg</option>
<option value='author'>author</option>
<option value='committer'>committer</option>
<option value='range'>range</option>
</select>
<input class='txt' type='search' size='10' name='q' value=''/>
<input type='submit' value='search'/>
</form>
</td></tr></table>
<div class='path'>path: <a href='/deb-bpo-builder/tree/'>root</a>/<a href='/deb-bpo-builder/tree/build-backport.sh'>build-backport.sh</a></div><div class='content'>blob: 0cfaaac43b4bf6c2bc72fbf95e67c1c6d01633d2 (<a href='/deb-bpo-builder/plain/build-backport.sh'>plain</a>)
<table summary='blob content' class='blob'>
<tr><td class='linenumbers'><pre><a id='n1' href='#n1'>1</a>
<a id='n2' href='#n2'>2</a>
<a id='n3' href='#n3'>3</a>
<a id='n4' href='#n4'>4</a>
<a id='n5' href='#n5'>5</a>
<a id='n6' href='#n6'>6</a>
<a id='n7' href='#n7'>7</a>
<a id='n8' href='#n8'>8</a>
<a id='n9' href='#n9'>9</a>
<a id='n10' href='#n10'>10</a>
<a id='n11' href='#n11'>11</a>
<a id='n12' href='#n12'>12</a>
<a id='n13' href='#n13'>13</a>
<a id='n14' href='#n14'>14</a>
<a id='n15' href='#n15'>15</a>
<a id='n16' href='#n16'>16</a>
<a id='n17' href='#n17'>17</a>
<a id='n18' href='#n18'>18</a>
<a id='n19' href='#n19'>19</a>
<a id='n20' href='#n20'>20</a>
<a id='n21' href='#n21'>21</a>
<a id='n22' href='#n22'>22</a>
<a id='n23' href='#n23'>23</a>
<a id='n24' href='#n24'>24</a>
<a id='n25' href='#n25'>25</a>
<a id='n26' href='#n26'>26</a>
<a id='n27' href='#n27'>27</a>
<a id='n28' href='#n28'>28</a>
<a id='n29' href='#n29'>29</a>
<a id='n30' href='#n30'>30</a>
<a id='n31' href='#n31'>31</a>
<a id='n32' href='#n32'>32</a>
<a id='n33' href='#n33'>33</a>
<a id='n34' href='#n34'>34</a>
<a id='n35' href='#n35'>35</a>
<a id='n36' href='#n36'>36</a>
<a id='n37' href='#n37'>37</a>
<a id='n38' href='#n38'>38</a>
<a id='n39' href='#n39'>39</a>
<a id='n40' href='#n40'>40</a>
<a id='n41' href='#n41'>41</a>
<a id='n42' href='#n42'>42</a>
<a id='n43' href='#n43'>43</a>
<a id='n44' href='#n44'>44</a>
<a id='n45' href='#n45'>45</a>
<a id='n46' href='#n46'>46</a>
<a id='n47' href='#n47'>47</a>
<a id='n48' href='#n48'>48</a>
<a id='n49' href='#n49'>49</a>
<a id='n50' href='#n50'>50</a>
<a id='n51' href='#n51'>51</a>
<a id='n52' href='#n52'>52</a>
<a id='n53' href='#n53'>53</a>
<a id='n54' href='#n54'>54</a>
<a id='n55' href='#n55'>55</a>
<a id='n56' href='#n56'>56</a>
<a id='n57' href='#n57'>57</a>
<a id='n58' href='#n58'>58</a>
<a id='n59' href='#n59'>59</a>
<a id='n60' href='#n60'>60</a>
<a id='n61' href='#n61'>61</a>
<a id='n62' href='#n62'>62</a>
<a id='n63' href='#n63'>63</a>
<a id='n64' href='#n64'>64</a>
<a id='n65' href='#n65'>65</a>
<a id='n66' href='#n66'>66</a>
<a id='n67' href='#n67'>67</a>
</pre></td>
<td class='lines'><pre><code>#!/bin/sh
set -o errexit

print_usage() {
	printf 'USAGE: %s buster|bullseye|bookworm package[…]\n' "$(basename "$0")"
}

if [ $# -lt 2 ]; then
	print_usage
	exit 1
fi

# Target release codename
TARGET_RELEASE="$1"
shift 1
case "$TARGET_RELEASE" in
	('buster')
		DCH_DISTRIBUTION='buster-backports'
		DCH_LOCAL='~bpo10+'
		SOURCE_DISTRIBUTION='bullseye'
	;;
	('bullseye')
		DCH_DISTRIBUTION='bullseye-backports'
		DCH_LOCAL='~bpo11+'
		SOURCE_DISTRIBUTION='bookworm'
	;;
	('bookworm')
		DCH_DISTRIBUTION='bookworm-backports'
		DCH_LOCAL='~bpo12+'
		SOURCE_DISTRIBUTION='trixie'
	;;
	(*)
		printf 'Unsupported codename: "%s"\n' "$TARGET_RELEASE"
		print_usage
		exit 1
	;;
esac
SOURCES_FILE="./sources_${TARGET_RELEASE}.list"

# List of architectures to build binary packages for,
# separated by spaces.
ARCHITECTURES='amd64 i386'

# List of extra packages to include in the chroot,
# separated by commas.
EXTRA_PACKAGES='devscripts,findutils'

for architecture in $ARCHITECTURES; do
	MMDEBSTRAP_OPTIONS=" \
	--architectures=$architecture \
	--variant=buildd \
	--include='$EXTRA_PACKAGES' \
	--customize-hook='install -D build-package.sh \$1/build/build-package.sh' \
	--customize-hook='chroot \$1 useradd builder' \
	--customize-hook='chroot \$1 chown builder /build'"
	for PACKAGE in "$@"; do
		MMDEBSTRAP_OPTIONS="$MMDEBSTRAP_OPTIONS \
		--customize-hook='chroot \$1 apt build-dep $PACKAGE/$SOURCE_DISTRIBUTION -y' \
		--customize-hook='chroot \$1 su builder -c \"/build/build-package.sh $PACKAGE $DCH_DISTRIBUTION $DCH_LOCAL\"' \
		--customize-hook='chroot \$1 find /build -mindepth 1 -maxdepth 1 -name \"*.deb\" -exec apt install -y {} +'"
	done
	MMDEBSTRAP_CMD="mmdebstrap $MMDEBSTRAP_OPTIONS"
	eval "$MMDEBSTRAP_CMD" &lt; "$SOURCES_FILE" | \
		tar --extract --strip-components=2 --wildcards './build/*.deb'
done

exit 0
</code></pre></td></tr></table>
</div> <!-- class=content -->
<div class='footer'>generated by <a href='https://git.zx2c4.com/cgit/about/'>cgit v1.2.3</a> (<a href='https://git-scm.com/'>git 2.39.1</a>) at 2024-05-16 07:22:28 +0000</div>
</div> <!-- id=cgit -->
</body>
</html>
