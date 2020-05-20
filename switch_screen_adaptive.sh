#/bin/sh

#cd to script
cd /home/david/Scripts/ass

#remove old config files
test -f DISPLAYLIST.txt && rm DISPLAYLIST.txt
test -f DISPLAYLIST2.txt && rm DISPLAYLIST2.txt
test -f D1.txt && rm D?.txt

#write connected displays to DISPLAYLIST.txt
xrandr | grep " connected" | cat > DISPLAYLIST.txt

#set variables
DLINE=1
DLNR=$(wc -l <  DISPLAYLIST.txt)

#cut unneccessary info from DISPLAYLIST.txt and write result to DISPLAYLIST2.txt
while [ $DLINE -le $DLNR ]
do
    DSEDLINE=''"$DLINE"p'' ; cat DISPLAYLIST.txt | sed -n $DSEDLINE | awk '{print $1;}' | cat > D"$DLINE".txt
    DLINE=$(($DLINE + 1))
done
cat D?.txt > DISPLAYLIST2.txt

#define all display variables
D1=0 ; D2=0 ; D3=0 ; D4=0 ; D5=0 ; D6=0 ; D7=0 ; D8=0 ; D9=0

#define used display variables
test -f D1.txt && D1=$(cat D1.txt)
test -f D2.txt && D2=$(cat D2.txt)
test -f D3.txt && D3=$(cat D3.txt)
test -f D4.txt && D4=$(cat D4.txt)
test -f D5.txt && D5=$(cat D5.txt)
test -f D6.txt && D6=$(cat D6.txt)
test -f D7.txt && D7=$(cat D7.txt)
test -f D8.txt && D1=$(cat D8.txt)
test -f D9.txt && D9=$(cat D9.txt)

#invoke dmenu selecton
OUTPUT=$(cat DISPLAYLIST2.txt | dmenu -i -p "Switch Display")

#set exit rule
[ "$OUTPUT" == "" ] && test -f DISPLAYLIST.txt && rm DISPLAYLIST.txt ; test -f DISPLAYLIST2.txt && rm DISPLAYLIST2.txt ; test -f D1.txt && rm D?.txt
[ "$OUTPUT" == "" ] && echo "Error: no display selected" && exit 

#disable all displays that are not selected
[ $D1 == 0 ] || xrandr --output $D1 --off
[ $D2 == 0 ] || xrandr --output $D2 --off
[ $D3 == 0 ] || xrandr --output $D3 --off
[ $D4 == 0 ] || xrandr --output $D4 --off
[ $D5 == 0 ] || xrandr --output $D5 --off
[ $D6 == 0 ] || xrandr --output $D6 --off
[ $D7 == 0 ] || xrandr --output $D7 --off
[ $D8 == 0 ] || xrandr --output $D8 --off
[ $D9 == 0 ] || xrandr --output $D9 --off

#enable selected display
[ "$OUTPUT" == "$D1" ] && xrandr --output $D1 --mode 1920x1080
[ "$OUTPUT" == "$D2" ] && xrandr --output $D2 --mode 1680x1050
[ "$OUTPUT" == "$D3" ] && xrandr --output $D3 --mode 1920x1080
[ "$OUTPUT" == "$D4" ] && xrandr --output $D4 --mode 1920x1080
[ "$OUTPUT" == "$D5" ] && xrandr --output $D5 --mode 1920x1080
[ "$OUTPUT" == "$D6" ] && xrandr --output $D6 --mode 1920x1080
[ "$OUTPUT" == "$D7" ] && xrandr --output $D7 --mode 1920x1080
[ "$OUTPUT" == "$D8" ] && xrandr --output $D8 --mode 1920x1080
[ "$OUTPUT" == "$D9" ] && xrandr --output $D9 --mode 1920x1080

#reset i3 and supress bash success
exec 1>/dev/null ; i3-msg restart

#remove config files
test -f DISPLAYLIST.txt && rm DISPLAYLIST.txt
test -f DISPLAYLIST2.txt && rm DISPLAYLIST2.txt
test -f D1.txt && rm D?.txt