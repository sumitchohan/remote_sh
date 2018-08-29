convert '/tmp/scr.png[666x100+0+565]' /tmp/BattleTroops.png
cp /tmp/BattleTroops.png ~/Desktop/gh/remote_sh/cv/BattleTroops.png
echo "" > /tmp/troopMap.txt
createTroopMapEntry()
{
    res=$(curl http://localhost:8952/findObject/$1/BattleTroops.png -s)
    isTroop=$(echo $res| cut -d'_' -f 1)
    if [ "$isTroop" = "y" ]
    then     
        echo "$1-$res" >>/tmp/troopMap.txt
    fi
} 
createTroopMapEntry "archer"
createTroopMapEntry "barb"
createTroopMapEntry "valk"
createTroopMapEntry "giant"
createTroopMapEntry "goblin"
createTroopMapEntry "king"
createTroopMapEntry "lava"
createTroopMapEntry "loon"
createTroopMapEntry "minion"
createTroopMapEntry "queen"
createTroopMapEntry "rage"
createTroopMapEntry "wallbreaker"
createTroopMapEntry "warden"
createTroopMapEntry "cc"
