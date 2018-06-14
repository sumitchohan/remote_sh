cd /sdcard/coc
 screenWidth="$(wm size | cut -d'x' -f 1 | cut -d':' -f 2 |sed -e 's/^[[:space:]]*//')"
Dump()
{
	screenWidth="$(wm size | cut -d'x' -f 1 | cut -d':' -f 2 |sed -e 's/^[[:space:]]*//')"
	echo "$screenWidth">/sdcard/coc/screenwidth.dat
	screencap /sdcard/coc/scr.dump
}
SendMessage()
{
echo $(echo "$1" | tr '\n' ' ')  | nc "192.168.0.106" "8901"
}

Restore()
{
pm clear com.supercell.clashofclans
sleep 1
am start -n com.bluestacks.settings/.SettingsActivity
sleep 1
adb restore /sdcard/coc/coc.$1.bak & PIDRESTORE=$!
sleep 5
WaitFor "RestoreData" "" 20
input tap 1200 860
wait $PIDRESTORE
sleep 1
am start -n com.supercell.clashofclans/.GameApp
}



Log()
{
	 echo "$(date) $1" >>/sdcard/coc/logs_$(date +%Y%m%d).txt
	 #echo "$(date) $1"
}
Tap()
{
	#input tap $1 $2
	Tapf $1 $2
}
Swipe()
{

}
Pixel()
{
	#IFS=" "
	#let offset=$screenWidth*$2+$1+3
	#stringZ=$(dd if='/sdcard/coc/scr.dump' bs=4 count=1 skip=$offset 2>/dev/null | hd)
	#echo "$(echo $stringZ | grep ":" | cut -d' ' -f 2)$(echo $stringZ | grep ":" | cut -d' ' -f 3)$(echo $stringZ | grep ":" | cut -d' ' -f 4)"


	IFS=" "
	let offset=$screenWidth*$2+$1+3
	stringZ=$(dd if='/sdcard/coc/scr.dump' bs=4 count=1 skip=$offset 2>/sdcard/result.txt| od | grep " ");
	pixelParts[1]=""
	pixelParts[2]=""
	pixelPartsIndex=0
	for word in $stringZ
	do
		pixelParts[pixelPartsIndex]=$word
		pixelPartsIndex=$pixelPartsIndex+1
	done
	part1d=$((8#${pixelParts[1]}))
	typeset -i16 part1h=part1d
	part2d=$((8#${pixelParts[2]}))
	typeset -i16 part2h=part2d
	red=$(echo $part1h | cut -c6-7)
	green=$(echo $part1h | cut -c4-5)
	blue=$(echo $part2h | cut -c6-7)
	if [ "${#red}" = "1" ]
	then
		red="0$red"
	fi
	if [ "${#green}" = "1" ]
	then
		green="0$green"
	fi
	if [ "${#blue}" = "1" ]
	then
		blue="0$blue"
	fi
	rgb="$red$green$blue";
	echo $rgb;
}
ProcessStateActionInternal()
{
	name="#$1|"
	IFS="|"
	data=$(cat scr.conf | grep $name)
	set -A parts $data
	name=${parts[0]}
	pointsData=${parts[1]}
	actions=${parts[2]}
	if [ "$2" = "match" ]
	then
		result="n"
		IFS=";"
		set -A points $pointsData
		for pixelData in "${points[@]}"
		do
			IFS=","
			set -A pixelDetails $pixelData
			pix=$(Pixel ${pixelDetails[1]} ${pixelDetails[2]})
			rh=$(echo $pix | cut -c1-2)
			gh=$(echo $pix | cut -c3-4)
			bh=$(echo $pix | cut -c5-6)
			r=$((16#$rh))
			g=$((16#$gh))
			b=$((16#$bh))
			s=$((($r - ${pixelDetails[3]})*($r - ${pixelDetails[3]}) + ($g - ${pixelDetails[4]})*($g - ${pixelDetails[4]}) + ($b - ${pixelDetails[5]})*($b - ${pixelDetails[5]})))
			tolerance=0
			if [ ${pixelDetails[0]} = "a"  ]
			then
				tolerance=300
			fi

			if [ $s -le $tolerance ]
			then
				result="y"
			else
				result="n"
				break
			fi
		done
		echo "$result"
	else
		if [ "$2" = "act" ]
		then
			IFS=";"
			set -A actions $actions
			for action in "${actions[@]}"
			do
				IFS=","
				set -A actionDetails $action
				if [ "${actionDetails[0]}" = "$3" ]
				then
					#command=""
					#commandPartIndex=0
					#for commandPart in "${actionDetails[@]}"
					#do
					#	if [ "$commandPartIndex" -eq "1" ]
					#	then
					#		command="$commandPart"
					#	fi
					#	if [ "$commandPartIndex" -gt "1" ]
					#	then
					#		command="$command $commandPart"
					#	fi
					#	(( commandPartIndex++ ))
					#done
					##$command
					#echo "command-$command--"
					#"$command"

					if [ ${actionDetails[1]} = "Tap" ]
					then
						Tap ${actionDetails[2]} ${actionDetails[3]}
					else
						if [ ${actionDetails[1]} = "Swipe" ]
						then
							Swipe ${actionDetails[2]} ${actionDetails[3]}  ${actionDetails[4]}  ${actionDetails[5]}  ${actionDetails[6]}
						else
							Tap ${actionDetails[1]} ${actionDetails[2]}
						fi
					fi
				fi
			done
		fi
	fi
}

MatchState()
{
	ProcessStateActionInternal $1 "match"
}

Act()
{
	Log "Act $1 $2"
	ProcessStateActionInternal $1 "act"	$2
}

WaitFor()
{
	#WaitFor stateName "skipState1,skipState2"
	result="n"
	retryIndex=1
	retryCount=$3
	retryDelay=1
	error="y"
	while [ $retryIndex -le $retryCount ]
	do
	Dump
	isbreak="n";
	Log "waiting for $1"
	matched=$(MatchState $1)
	if [ "$matched" = "y" ]
	then
		Log "Matched $1"
		error="n"
		result="y"
		break
	else
		Log "No match $1"
		ILS=","
		set -A skipScreens $2
		for skipScreen in "${skipScreens[@]}"
		do
			Log "skip check $skipScreen"
			skipMatched=$(MatchState $skipScreen)
			if [ "$skipMatched" = "y" ]
			then
				Log "skipping $skipScreen"
				if [ "$skipScreen" = "BuilderHome" ]
				then
					Zoom
					sleep 4
				fi
				Act $skipScreen "Skip"
			fi
		done
		sleep $retryDelay
	fi
	(( retryIndex++ ))
	done
	if [ "$result" = "n" ]
	then
		screencap -p "error_$1.png"
	fi
	echo "$result"
}
RepeatAct()
{
	retryIndex=1
	retryCount=$3
	while [ $retryIndex -le $retryCount ]
	do
		Act $1 $2
		sleep $4
		(( retryIndex++ ))
	done
}
Hello()
{
	echo "Hello $1"
}
Repeat()
{
	retryIndex=1
	retryCount=$1
	while [ $retryIndex -le $retryCount ]
	do
		Log "Repeat index $retryIndex $2 $3 $4"
		$3 $4 $5 $6 $7 $8 $9 $10 $11 $12 $13 $14 $15 $16 $17
		sleep $2
		(( retryIndex++ ))
	done
}

Loose()
{
	WaitFor "Home" "Attacked,ConnectionLost,VersusHome,ReturnHome" 20
	Act "Home" "Attack"
	sleep .2
	#WaitFor "FindAMatch" "" 20
	Act "FindAMatch" "Find"
	WaitFor "Battle" "" 120
	Zoom
	#Read "Battle"
	Act "Battle" "Choose1"
	Act "Battle" "Deploy{1:-0}"
	Act "Battle" "End"
	WaitFor "Surrender" "" 10
	Act "Surrender" "Okay"
	WaitFor "Results" "" 20
	Act "Results" "Skip"
}
Read()
{
	if [ -e "ocr_coca_$1.request" ]
	then
		rm "ocr_coca_$1.request"
	fi
	echo "request">"ocr_coca_$1.request"
	wc=1
	while [ $wc -le 30 ]
	do
		if [ -e "ocr_coca_$1.request" ]
		then
			sleep 1
		else
			break
		fi
		(( wc++ ))
	done
}
SkipVersusHome()
{
	Act "Home" "Zoom"
	Sleep 4
	Tap $1 $2
}
Zoom1()
{
	Dump
	matchedZ=$(MatchState "FrepZ")
	matchedR=$(MatchState "FrepR")
	matchedA=$(MatchState "FrepA")
	echo "matchedA  - $matchedA matchedZ - $matchedZ matchedR - $matchedR"
	if [ "$matchedR" = "n" ] &&  [ "$matchedZ" = "n" ] &&  [ "$matchedA" = "n" ]
	then
		StartCOC
		sleep3
		Dump
		matchedZ=$(MatchState "FrepZ")
		matchedR=$(MatchState "FrepR")
		matchedA=$(MatchState "FrepA")
		echo "matchedA  - $matchedA matchedZ - $matchedZ matchedR - $matchedR"
	fi
	if [ "$matchedR" = "y" ]
	then
		Act "FrepZ" "Top"
	fi

	if [ "$matchedA" = "y" ]
	then
		Act "FrepZ" "Top"
		Act "FrepZ" "Top"
	fi
	Act "FrepZ" "Bottom"
	 sleep 3;
}


Attack1()
{
	Dump
	matchedZ=$(MatchState "FrepZ")
	matchedR=$(MatchState "FrepR")
	matchedA=$(MatchState "FrepA")
	echo "matchedA  - $matchedA matchedZ - $matchedZ matchedR - $matchedR"
	if [ "$matchedR" = "n" ] &&  [ "$matchedZ" = "n" ] &&  [ "$matchedA" = "n" ]
	then
		StartCOC
		sleep3
		Dump
		matchedZ=$(MatchState "FrepZ")
		matchedR=$(MatchState "FrepR")
		matchedA=$(MatchState "FrepA")
		echo "matchedA  - $matchedA matchedZ - $matchedZ matchedR - $matchedR"
	else
		if [ "$matchedR" = "y" ]
		then
			Act "FrepZ" "Top"
			Act "FrepZ" "Top"
		fi

		if [ "$matchedZ" = "y" ]
		then
			Act "FrepZ" "Top"
		fi
		Act "FrepZ" "Bottom"
	fi
	sleep 20;
}

GetFrep()
{
	found=$(WaitFor "Frep" "" 10)
	if [ "$found" = "n" ]
	then
		StartCOC
	fi
}
VersusAttack()
{
	Tap 13 65
	sleep 3
	Tap 13 39
	Tap 13 65
	sleep 60
	Tap 13 39
	Tap 13 39
}

Zoom()
{
	Act "FRep" "Zoom"
	#found=$(WaitFor "Frep" "" 10)
	#if [ "$found" = "n" ]
	#then
	#	Log "Frep not found. Activating it..."
	#	am start -n com.x0.strai.frep/.FingerActivity
	#	sleep 3
	#fi
	#Act "Frep" "Play"
	#sleep 1
	#found=$(WaitFor "Frep" "" 10)
	#if [ "$found" = "n" ]
	#then
	#	Log "Frep not found. Activating it..."
	#	am start -n com.x0.strai.frep/.FingerActivity
	#	sleep 3
	#	am start -n com.supercell.clashofclans/.GameApp
	#	sleep 3
	#fi
}
StartCOC()
{
	isCOC=$(dumpsys window windows | grep -E 'mCurrentFocus' | grep 'supercell.clashofclans')
	if [ "$isCOC" = "" ]
	then
		Log "no coc"
		am start -n com.supercell.clashofclans/.GameApp
		sleep 10
	else
		Log "coc"
	fi
	Dump
	isGooglePlay=$(MatchState "GooglePlay")
	if [ "$isGooglePlay" = "y" ]
	then
		Act "GooglePlay" "Skip"
		sleep 10
	fi
	Dump
	isFrep=$(MatchState "FRep")
	if [ "$isFrep" = "n" ]
	then
		Log "No Frep"
		am start -n com.x0.strai.frep/.FingerActivity
		sleep 10
		am start -n com.supercell.clashofclans/.GameApp
		sleep 10
	else
		Log "Frep"
	fi

	# am force-stop com.supercell.clashofclans
	# sleep 2
	# am start -n com.x0.strai.frep/.FingerActivity
	# sleep 2
	# am start -n com.supercell.clashofclans/.GameApp
}
StopCOC()
{
	am force-stop com.supercell.clashofclans
	sleep 1
}

LooseTrophies()
{
	trophy=$1
	if [ "$trophy" -ge "700" ]
	then
		Log "trophy $trophy ; loosing.."
		Loose
		WaitFor "Home" "Attacked,ConnectionLost,VersusHome,ReturnHome" 60
		Read "Home"
		trophy=$(cat ocred_Trophy.txt)
		de=$(cat ocred_DE.txt)
		elixir=$(cat ocred_Elixir.txt)
		gems=$(cat ocred_Gems.txt)
		LooseTrophies $trophy
	fi
}
Home()
{
	StartCOC
	WaitFor "Home" "Inactive,Attacked,BuilderHome,AnotherDevice" 60
}
Versus()
{
	StopCOC
	Home
	Zoom
	Tap 170 470 #go to Versus
	Tap 55 600
	Tap 622 422 #okay after battle
	Tap 550 300
	WaitFor "VersusBattle" "" 100
	VersusAttack
	sleep 1
	StopCOC
}

Versus20()
{
	sleep 300
	Versus
	sleep 300
	Versus
	sleep 300
	Versus
	sleep 300
	Versus
	sleep 300
	Versus
	sleep 300
	Versus
	sleep 300
	Versus
	sleep 300
	Versus
	sleep 300
	Versus
	sleep 300
	Versus
	sleep 300
	Versus
	sleep 300
	Versus
	sleep 300
	Versus
	sleep 300
	Versus
	sleep 300
	Versus
	sleep 300
	Versus
	sleep 300
	Versus
	sleep 300
	Versus
	sleep 300
	Versus
	sleep 300
	Versus
	sleep 300
}
Run()
{
	StartCOC
	found=$(WaitFor "Home" "Attacked,ConnectionLost,VersusHome,VersusHome,ReturnHome|" 60)
	if [ "$found" = "n" ]
	then
		StartCOC
	fi
	Read "Home"
	trophy=$(cat ocred_Trophy.txt)
	de=$(cat ocred_DE.txt)
	elixir=$(cat ocred_Elixir.txt)
	gems=$(cat ocred_Gems.txt)
	gold=$(cat ocred_Gold.txt)
	Log "home - de $de elixir $elixir gold $gold gems $gems trophy $trophy"
	Act "Home" "Train"
	WaitFor "Army" "" 10
	Read "Army"
	army=$(cat ocred_Troops.txt)
	Log "army $army"
	Act "Army" "TrainTroops"
	WaitFor "TrainTroops" "" 10
	Read "TrainTroops"
	trainingQueue=$(cat ocred_Troops.txt)
	Log "trainingQueue - $trainingQueue"
	Act "Army" "QuickTrain"
	WaitFor "QuickTrain" "" 10
	Act "QuickTrain" "QuickTrain1"
	Act "QuickTrain" "QuickTrain1"
	Act "QuickTrain" "QuickTrain1"
	Act "QuickTrain" "QuickTrain1"
	Act "QuickTrain" "QuickTrain1"
	Act "QuickTrain" "QuickTrain1"
	Act "QuickTrain" "QuickTrain1"
	Act "QuickTrain" "QuickTrain1"
	Act "QuickTrain" "QuickTrain1"
	Act "QuickTrain" "QuickTrain2"
	Act "QuickTrain" "QuickTrain2"
	Act "QuickTrain" "QuickTrain2"
	Act "QuickTrain" "QuickTrain2"
	Act "QuickTrain" "QuickTrain2"
	Act "QuickTrain" "QuickTrain2"
	Act "QuickTrain" "QuickTrain2"
	Act "QuickTrain" "QuickTrain2"
	Act "QuickTrain" "QuickTrain2"
	Act "QuickTrain" "QuickTrain2"
	Act "QuickTrain" "QuickTrain2"
	Act "QuickTrain" "Skip"
	sleep .1
	LooseTrophies $trophy
	enoughArmyToAttack="n"
	if [ "$army" -ge "190" ]
	then
		enoughArmyToAttack="y"
	fi
	if [ "$enoughArmyToAttack" = "y" ]
	then
		Attack
	else
		Log "not enough army - $army"
	fi
}
Attack()
{
	Act "Home" "Attack"
	sleep .5
	#WaitFor "FindAMatch" "" 20
	Act "FindAMatch" "Find"
	WaitFor "Battle" "" 120
	#Zoom
	Read "Battle"
	de=$(cat ocred_DE.txt)
	elixir=$(cat ocred_Elixir.txt)
	gold=$(cat ocred_Gold.txt)
	attacked="n"
	eg=0
	((eg=gold+elixir))
	Log "loot - de $de elixir $elixir gold $gold eg $eg"
	while [ "$attacked" = "n" ]
	do
		if [ "$de" -ge "1000" ] || [ "$gold" -ge "200000" ] || [ "$elixir" -ge "200000" ] || [ "$eg" -ge "300000" ]
		then
			Log "attacking"
			Zoom1
			attacked="y"
			Attack1
			#WaitFor "Results" "" 400
			#Act "Results" "Skip"
			#WaitFor "Home" "" 20
		else
			Log "not attacking"
			Act "Battle" "Next"
			WaitFor "Battle" "" 120
			#Zoom
			Read "Battle"
			de=$(cat ocred_DE.txt)
			elixir=$(cat ocred_Elixir.txt)
			gold=$(cat ocred_Gold.txt)
			((eg=gold+elixir))
			Log "loot - de $de elixir $elixir gold $gold eg $eg"
		fi
	done
}
CaptureTrainData()
{
	WaitFor "Home" "Attacked,ConnectionLost,VersusHome,ReturnHome" 60
	Act "Home" "Train"
	WaitFor "Army" "" 10
	Dump
	Read "Army"
	Act "Army" "TrainTroops"
	sleep .1
	Dump
	Read "TrainTroops"
	Act "TrainTroops" "Archer"
	Act "TrainTroops" "Skip"
}

TrainTroops()
{
	Act "TrainTroops" "Giant"
	Act "TrainTroops" "Archer"
	Act "TrainTroops" "Archer"
	Act "TrainTroops" "Archer"
	Act "TrainTroops" "Archer"
	Act "TrainTroops" "Archer"
}

AddTs()
{
while read data; do
	printf "$EPOCHREALTIME $data\n"
done
}

CaptureZoomEvents()
{
	getevent | AddTs > events.log & PID1=$!
	input tap 43 158
	sleep 4
	kill $PID1
}
touchDevice=$(getevent -pl 2>&1 | sed -n '/^add/{h}/nox /{x;s/[^/]*//p}')
Tapf()
{
	 input tap $1 $2
	# # # #approximate tap for bluestack
	# # # # x=$(($1*1000/49))
	# # # # y=$(($2*2000/55))
	# # # #echo "$x $y"
	 # sendevent $touchDevice 0 0 0
	 # sendevent $touchDevice 3 53 $1
	 # sendevent $touchDevice 3 54 $2
	 # sendevent $touchDevice 0 2 0
	 # sendevent $touchDevice 0 0 0
	 # sendevent $touchDevice 0 2 0
	 # sendevent $touchDevice 0 0 0
	 # sleep 0.001
}
DeployStart()
{
	Tapf 40 70
}
Deploy()
{
	Tapf 40 160
	sleep 20
}
DeployEnd()
{
	Tapf 40 70
	Tapf 40 70
}

RunOnEvents()
{
	#echo 172e1f84
	##set https://api.keyvalue.xyz/bb7da7f2/clientId
	#curl -X POST https://api.keyvalue.xyz/bb7da7f2/clientId/ding
	#curl -X POST https://api.keyvalue.xyz/172e1f84/myKey/ON
	##get
	#curl curl -X POST https://api.keyvalue.xyz/bb7da7f2/clientId
	#awk '{ sub("\r$", ""); print }' run.sh > run1.sh

	retryIndex=1
	retryCount=10000000
	retryDelay=30
	error="y"
	key=$(cat /sdcard/key.txt)
	while [ $retryIndex -le $retryCount ]
	do
		switch=$(curl https://api.keyvalue.xyz/$key/clientId -k -s)
		echo $switch
		curl -X POST https://api.keyvalue.xyz/$key/clientId/processing-$EPOCHREALTIME -k -s
		if [ "$switch" = "ding" ]
		then
			echo "ding$EPOCHREALTIME"
		fi
		if [ "$switch" = "ON" ]
		then
			input tap 615 462
		fi
		curl -X POST https://api.keyvalue.xyz/$key/clientId/waiting-$EPOCHREALTIME -k -s
		sleep $retryDelay
	done
}

Donate()
{
  Act "Chat" "Skip"
  Act "Home" "Chat"

}
Diff()
{
  if [ $1 -le $2 ]
  then
    echo $(($2-$1))
  else
    echo $(($1-$2))
  fi
}
MatchPixel() #x y r g b delta
{
  pix=$(Pixel $1 $2)
  rh=$(echo $pix | cut -c1-2)
  gh=$(echo $pix | cut -c3-4)
  bh=$(echo $pix | cut -c5-6)
  r=$((16#$rh))
  g=$((16#$gh))
  b=$((16#$bh))
  echo "$r $g $b"
  tolerance=$(($(Diff $3 $r)+$(Diff $4 $g)+$(Diff $5 $b)))
  echo $tolerance
  if [ $6 -le $tolerance ]
  then
    result="y"
  else
    result="n"
  fi
}
