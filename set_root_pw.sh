#!/bin/bash

if [ -f /.root_pw_set ]; then
	echo "root password already set!"
	exit 0
fi

RPASS=${ROOT_PASS:-$(pwgen -s 12 1)}
_word=$( [ ${ROOT_PASS} ] && echo "preset" || echo "random" )
echo "=> Setting a ${_word} password for root"
echo "root:$RPASS" | chpasswd

adduser --disabled-password --gecos "" dockerx 
adduser dockerx sudo
DPASS=${DOCKERX_PASS:-$(pwgen -s 12 1)}
_word=$( [ ${DOCKERX_PASS} ] && echo "preset" || echo "random" )
echo "=> Setting a ${_word} password for dockerx"
echo "dockerx:$DPASS" | chpasswd

echo "=> Done!"
touch /.root_pw_set

echo "============================================"
echo "SSH, X2GO are ready on Ubuntu container"
echo ""
echo " root password : '$RPASS' "
echo " dockerx password : '$DPASS' "
echo "============================================"
