#!/bin/bash


#verb='èssere'

# model g
#verb='segare'
#verb='trucare'
#verb='cantare'
#verb='acabbare'
#verb='modificare'
#verb='comunicare'
#verb='trobogiare'

# model G  ENCARA NO REPASSAT
verb='agitare'
#verb='acapiare'
#verb='aplicare'
#verb='apogiare'

# model H
#verb='dare'

# model J
#verb='còghere'
#verb='fàghere'
#verb='pòdere'

# model I
#verb='tìmere'
#verb='tìnghere'
#verb='frìnghere'
verb='aèschere'
#verb='disagradèssere'
#verb='sètzere'
#verb='règere'
#verb='rìere'
#verb='frìere'

#verb='descrìere'
#verb='bìere'
#verb='ochìere'

# model J
#verb='fàghere'
#verb='pòdere'
#verb='còghere'

# model K
#verb='tènnere'
#verb='bàlere'
#verb='bòlere'
#verb='pònnere'
#verb='bènnere'
#verb='pàrrere'
#verb='abèrrere'
#verb='chèrrere'

# model M 3a conjugació
#verb='finire'
#verb='sighire'
#verb='ischire'
#verb='afigire'

# model L (només nàrrere)
#verb='nàrrere'

s="^$verb<vblex><inf>$"
echo "$s" | lt-proc -g srd.autogen.bin
s="^$verb<vblex><ger>$"
echo "$s" | lt-proc -g srd.autogen.bin
s="^$verb<vblex><pp><m><sg>$"
echo "$s" | lt-proc -g srd.autogen.bin
s="^$verb<vblex><pp><f><sg>$"
echo "$s" | lt-proc -g srd.autogen.bin
s="^$verb<vblex><pp><m><pl>$"
echo "$s" | lt-proc -g srd.autogen.bin
s="^$verb<vblex><pp><f><pl>$"
echo "$s" | lt-proc -g srd.autogen.bin
echo ""

for temps in pri pii prs pis imp
do
	for sg in sg pl
	do
		for pers in p1 p2 p3
		do
			s="^$verb<vblex><$temps><$pers><$sg>\$"
#			echo $s
			echo "$s" | lt-proc -g srd.autogen.bin
		done
	done
echo ""
done
