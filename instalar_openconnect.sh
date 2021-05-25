#!/bin/bash

#Variáveis
versaoOpenconnect="openconnect-8.10"
nomeVpn="vpn"

echo "####### Instalar dependências do OpenConnect ########"
sudo apt-get -y install build-essential gettext autoconf automake libproxy-dev libxml2-dev libtool vpnc-scripts pkg-config zlib1g-dev libgnutls28-dev

echo "####### Baixar e Instalar o OpenConnect ########"
wget -nc ftp://ftp.infradead.org/pub/openconnect/$versaoOpenconnect.tar.gz
tar -zxvf $versaoOpenconnect.tar.gz -C .
cd $versaoOpenconnect
./configure
make
sudo make install && sudo ldconfig
cd ..
rm -Rf $versaoOpenconnect
rm -f $versaoOpenconnect.tar.gz

echo "####### Criando Link simbólico vpn ########"
touch $nomeVpn.sh
echo "#!/bin/bash" >> $nomeVpn.sh
echo "clear" >> $nomeVpn.sh
echo "echo '####### VPN Credenciais ########'" >> $nomeVpn.sh
echo "echo ''" >> $nomeVpn.sh
echo "read -p 'Login: ' login" >> $nomeVpn.sh
echo "read -sp 'Password: ' password" >> $nomeVpn.sh
echo "echo ''" >> $nomeVpn.sh
echo "set -e" >> $nomeVpn.sh
echo "echo -e \$password'\n' | sudo openconnect -vvv -u \${login} --protocol=gp acessoremoto.tjdft.jus.br" >> $nomeVpn.sh
sudo chmod +x $nomeVpn.sh
sudo mv $nomeVpn.sh /opt
sudo ln -sf /opt/$nomeVpn.sh /usr/bin/$nomeVpn
echo ""
echo ""
echo "###########################################"
echo "############### Concluído #################"
echo "###             DIGITE $nomeVpn         ###"
echo "###########################################"
