cd /sdcard/coc
screenWidth="$(wm size | cut -d'x' -f 1 | cut -d':' -f 2 |sed -e 's/^[[:space:]]*//')"
port=8901
source /sdcard/cocconfig/config.sh
echo "port - $port"
Dump()
{
	screenWidth="$(wm size | cut -d'x' -f 1 | cut -d':' -f 2 |sed -e 's/^[[:space:]]*//')"
	echo "$screenWidth">/sdcard/coc/screenwidth.dat
	screencap /sdcard/coc/scr.dump
	split -b 640000b scr.dump

}
SendMessage()
{
echo $(echo "$1" | tr '\n' ' ')  | nc "192.168.0.106" "$port"
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
	input tap $1 $2
	#Tapf $1 $2
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
	#offset=$screenWidth*$2+$1+3
	#dumpFile='/sdcard/coc/scr.dump'
	offset1=$(($screenWidth*$2+$1+3))
	offset=$(($offset1%160000))	
	offsetNew=$((($offset1-$offset)/160000))
	dumpFile="xaa"
	if [ "$offsetNew" = "1" ]
	then
		dumpFile="xab"
	fi
	if [ "$offsetNew" = "2" ]
	then
		dumpFile="xac"
	fi
	if [ "$offsetNew" = "3" ]
	then
		dumpFile="xad"
	fi
	if [ "$offsetNew" = "4" ]
	then
		dumpFile="xae"
	fi
	if [ "$offsetNew" = "5" ]
	then
		dumpFile="xaf"
	fi
	if [ "$offsetNew" = "6" ]
	then
		dumpFile="xag"
	fi
	if [ "$offsetNew" = "7" ]
	then
		dumpFile="xah"
	fi
	if [ "$offsetNew" = "8" ]
	then
		dumpFile="xai"
	fi
	if [ "$offsetNew" = "9" ]
	then
		dumpFile="xaj"
	fi
	if [ "$offsetNew" = "10" ]
	then
		dumpFile="xak"
	fi
	if [ "$offsetNew" = "11" ]
	then
		dumpFile="xal"
	fi
	if [ "$offsetNew" = "12" ]
	then
		dumpFile="xam"
	fi
	if [ "$offsetNew" = "13" ]
	then
		dumpFile="xan"
	fi
	if [ "$offsetNew" = "14" ]
	then
		dumpFile="xao"
	fi
	if [ "$offsetNew" = "15" ]
	then
		dumpFile="xap"
	fi
	if [ "$offsetNew" = "16" ]
	then
		dumpFile="xaq"
	fi
	if [ "$offsetNew" = "17" ]
	then
		dumpFile="xar"
	fi
	if [ "$offsetNew" = "18" ]
	then
		dumpFile="xas"
	fi
	if [ "$offsetNew" = "19" ]
	then
		dumpFile="xat"
	fi
	if [ "$offsetNew" = "20" ]
	then
		dumpFile="xau"
	fi
	if [ "$offsetNew" = "21" ]
	then
		dumpFile="xav"
	fi
	if [ "$offsetNew" = "22" ]
	then
		dumpFile="xaw"
	fi
	if [ "$offsetNew" = "23" ]
	then
		dumpFile="xax"
	fi
	if [ "$offsetNew" = "24" ]
	then
		dumpFile="xay"
	fi
	if [ "$offsetNew" = "25" ]
	then
		dumpFile="xaz"
	fi
	

	stringZ=$(dd if=$dumpFile bs=4 count=1 skip=$offset 2>/sdcard/result.txt| od | grep " ");
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
	#Log "action - $actions"
	#Log "name - $name"
	#Log "pointsData - $pointsData"
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
			s=$(($(Diff $r ${pixelDetails[3]}) + $(Diff $g ${pixelDetails[4]}) + $(Diff $b ${pixelDetails[5]}) ))
			#s=$((($r - ${pixelDetails[3]})*($r - ${pixelDetails[3]}) + ($g - ${pixelDetails[4]})*($g - ${pixelDetails[4]}) + ($b - ${pixelDetails[5]})*($b - ${pixelDetails[5]})))
			tolerance=0
			if [ ${pixelDetails[0]} = "a"  ]
			then
				tolerance=20
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
		IFS=","
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
		if [ "$1" = "Home" ] 
		then
			Tap 5 400
		fi
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
	Home	
	Zoom
	Read "Home"
	trophy=$(cat ocred_Trophy.txt)
	maxTrophyCount=4300
	if [ "$1" = "1" ]
	then
		maxTrophyCount=2100
	else
		maxTrophyCount=4300
	fi
	echo "trophy -$trophy maxTrophyCount -  $maxTrophyCount"
	if [ "$trophy" -ge "$maxTrophyCount" ] 
	then
		echo "Loosing.."
		Tap 40 520
		sleep 0.1
		#ready=$(MatchPixel 551 296 64 117 09 100)
		ready="y"
		Tap 768 92
		sleep .5
		if [ "$ready" = "y" ]
		then		
			Act "Home" "Attack"
			sleep .5
			Tap 230 460 
			WaitFor "Battle" "" 120	
			SendMessage "loose"
			sleep .5
			Tap 66 530
			sleep 1
			Tap 494 416
			sleep 1
			Tap 396 540
			Loose $1
		else
			echo "not ready"
		fi
	fi
}
Read()
{
	SendMessage "read $1"
# 	if [ -e "ocr_coca_$1.request" ]
# 	then
# 		rm "ocr_coca_$1.request"
# 	fi
# 	echo "request">"ocr_coca_$1.request"
# 	wc=1
# 	while [ $wc -le 30 ]
# 	do
# 		if [ -e "ocr_coca_$1.request" ]
# 		then
# 			sleep 1
# 		else
# 			break
# 		fi
# 		(( wc++ ))
	# done
}
SkipVersusHome()
{
	Act "Home" "Zoom"
	Sleep 4
	Tap $1 $2
}
FRep()
{
	# Dump
	# isFirst=$(MatchPixel 16 95 14 194 129 1)
	# isSecond=$(MatchPixel 10 95 14 194 129 1)
	# currNumber=1
	# if [ "$isSecond" = "y" ]; then 
	# 	currNumber=1
	# elif [ "$isFirst" = "y" ]; then
	# 	currNumber=2
	# else
	# 	currNumber=3
	# fi
	# loopCnt=0;
	# if [ "$1" -ge "$currNumber" ]
	# then
	# 	loopCnt=$(($1-$currNumber))
	# else		
	# 	loopCnt=$((3+$1-$currNumber))
	# fi
	# retryIndex=0  
	# # while [ $retryIndex -lt $loopCnt ]
	# # do
	# 	# Tap 17 57
	# 	# sleep 1
	# 	# (( retryIndex++ )
	# # done
	Tap 15 93		
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
	
	FRep
	sleep 3
	# X:16;Y:95 ;R:14 ;G:194;B:129;A:255
# X:10;Y:95 ;R:14 ;G:194;B:129;A:255
# X:10;Y:95 ;R:252 ;G:0;B:11;A:255
 
 # 13 92
 
 
	#Act "FRep" "Zoom"
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
	sleep 3
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
	WaitFor "Home" "BuilderHome" 60
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
Run_old()
{
	Home
	Zoom
		# Read "Home"
		# trophy=$(cat ocred_Trophy.txt)
		# de=$(cat ocred_DE.txt)
		# elixir=$(cat ocred_Elixir.txt)
		# gems=$(cat ocred_Gems.txt)
		# gold=$(cat ocred_Gold.txt)
		# Log "home - de $de elixir $elixir gold $gold gems $gems trophy $trophy"
	Tap 40 520
	sleep 0.1
	Tap 520 95
	sleep 0.1
	Tap 730 448
	Tap 85 95
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
ShouldAttack()
{
	result="n"
	if [ "$1" = "1" ]
	then
		if  [ "$elixir" -ge "550000" ] || [ "$eg" -ge "1000000" ]
		then
			if [ "$isth10" = "y" ]
			then	
				result="y"
			fi
		fi 
		if  [ "$elixir" -ge "700000" ] || [ "$eg" -ge "1400000" ]
		then 
			result="y"
		fi
	else
		if  [ "$elixir" -ge "200000" ] || [ "$eg" -ge "600000" ]
		then
			if [ "$isth10" = "y" ]
			then	
				result="y"
			fi
		fi 
		if  [ "$elixir" -ge "800000" ] || [ "$eg" -ge "1600000" ]
		then 
			result="y"
		fi 
	fi 
	Log "Should Attack - $1 $elixir $eg $isth10 $result"
	echo $result
}
Attack()
{
	Act "Home" "Attack"
	sleep .5
	#WaitFor "FindAMatch" "" 20
	#Act "FindAMatch" "Find"
	Tap 230 460

	battleFound=$(WaitFor "Battle" "" 100)
	if [ "$battleFound" = "y" ]
	then
		#Zoom
		Read "Battle"
		de=$(cat ocred_DE.txt)
		elixir=$(cat ocred_Elixir.txt)
		gold=$(cat ocred_Gold.txt) 
		win=$(cat ocred_Win.txt)
		loose=$(cat ocred_Loose.txt) 
		th10=$(cat ocred_Th10.txt) 
		isth10=$(echo $th10| cut -d'_' -f 1)
		#th9=$(cat ocred_Th9.txt) 
		#isth9=$(echo $th9| cut -d'_' -f 1)
		# th9=$(cat ocred_Th9.txt) 
		# isth9=$(echo $th9| cut -d'_' -f 1)
		attacked="n"
		eg=0
		((eg=gold+elixir))
		Log "loot - de $de elixir $elixir gold $gold eg $eg"
		echo "loot - de $de elixir $elixir gold $gold eg $eg win $win loose $loose th9 - $th9 th10 - $th10"
		while [ "$attacked" = "n" ]
		do
			SendMessage "snapshot.sh"
			shouldAttack=$(ShouldAttack $1)
			echo "ShouldAttack $shouldAttack $1 $th10 $elixir $gold"
			if [ "$shouldAttack" = "y" ] 
			then
				Log "attacking on th10"
				echo "ready to attack"
				QuickAttack 
				break
			fi 
			Log "not attacking"
			echo "not attacking"
			Act "Battle" "Next"
			battleFound=$(WaitFor "Battle" "" 100)
			if [ "$battleFound" = "n" ]
			then
				break
			fi
			#Zoom
			Read "Battle"
			de=$(cat ocred_DE.txt)
			elixir=$(cat ocred_Elixir.txt)
			gold=$(cat ocred_Gold.txt)
			win=$(cat ocred_Win.txt)
			loose=$(cat ocred_Loose.txt) 
			ea=$(cat ocred_ea.txt)
			isea=$(echo $ea| cut -d'_' -f 1)
			((eg=gold+elixir))
			th10=$(cat ocred_Th10.txt) 
			isth10=$(echo $th10| cut -d'_' -f 1)
			#th9=$(cat ocred_Th9.txt) 
			#isth9=$(echo $th9| cut -d'_' -f 1)
			Log "loot - de $de elixir $elixir gold $gold eg $eg"
			echo "loot - de $de elixir $elixir gold $gold eg $eg win $win loose $loose th10 - $th10"			
		done
	fi
}

CaptureBased()
{
	Zoom
	Act "Home" "Attack"
	sleep .5
	#WaitFor "FindAMatch" "" 20
	#Act "FindAMatch" "Find"
	Tap 524 932
	WaitFor "Battle" "" 120 
	SendMessage "snapshot.sh"
	Tap 1444 1069
	WaitFor "Battle" "" 120 
	SendMessage "snapshot.sh"
	Tap 1444 1069
	WaitFor "Battle" "" 120 
	SendMessage "snapshot.sh"
	Tap 1444 1069
	WaitFor "Battle" "" 120 
	SendMessage "snapshot.sh"
	Tap 1444 1069
	WaitFor "Battle" "" 120 
	SendMessage "snapshot.sh"
	Tap 1444 1069
	WaitFor "Battle" "" 120 
	SendMessage "snapshot.sh"
	Tap 1444 1069
	WaitFor "Battle" "" 120 
	SendMessage "snapshot.sh"
	Tap 1444 1069
	WaitFor "Battle" "" 120 
	SendMessage "snapshot.sh"
	Tap 1444 1069
	WaitFor "Battle" "" 120 
	SendMessage "snapshot.sh"
	Tap 1444 1069
	WaitFor "Battle" "" 120 
	SendMessage "snapshot.sh"
	Tap 1444 1069
	WaitFor "Battle" "" 120 
	SendMessage "snapshot.sh"
	Tap 1444 1069
	WaitFor "Battle" "" 120 
	SendMessage "snapshot.sh"
	Tap 1444 1069
	WaitFor "Battle" "" 120 
	SendMessage "snapshot.sh"
	Tap 1444 1069
	WaitFor "Battle" "" 120 
	SendMessage "snapshot.sh" 
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
touchDevice=$(getevent -pl 2>&1 | sed -n '/^add/{h}/ABS_MT_TOUCH/{x;s/[^/]*//p}')
Tapf()
{
	SendMessage "tap.sh $1 $2"
	# # # #approximate tap for bluestack
	# # # # x=$(($1*1000/49))
	# # # # y=$(($2*2000/55)) /dev/input/event1

	# # # #echo "$x $y"
	# sendevent /dev/input/event1 0 0 0
	# sendevent /dev/input/event1 3 53 $1
	# sendevent /dev/input/event1 3 54 $2
	# sendevent /dev/input/event1 0 2 0
	# sendevent /dev/input/event1 0 0 0
	# sendevent /dev/input/event1 0 2 0
	# sendevent /dev/input/event1 0 0 0
	# sleep 0.001
}
LogRemote()
{	
	SendMessage "logremote.sh $1"
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
  #echo "$r $g $b"
  delta=$(($(Diff $3 $r)+$(Diff $4 $g)+$(Diff $5 $b)))
  #echo $tolerance
  if [ $6 -le $delta ]
  then
    result="n"
  else
    result="y"
  fi
  echo $result
}
IsReadyForAttack()
{
	Dump	
    if [ $(MatchPixel 27 150 64 119 10 100) = "y" ] #&& [ $(MatchPixel 551 296 64 117 09 100) = "y" ]
    then		
		echo "y"
	else 
		echo "n"
	fi
}
Donate()
{
  y=90
  x=342
  while [ $y -le 600 ]
  do
    #Pixel $x $y
    isGreen=$(MatchPixel x y 171 191 79 100)
    if [ "$isGreen" = "y" ]
    then
      echo "match $x $y"
      y1=$y
      while [ $y1 -ge 1 ]
      do
        isGray=$(MatchPixel x y1 68 68 64 1)
        if [ "$isGray" = "y" ]
        then
          ReadDonation $x $y1
          #input swipe $x $((y1+5)) $x 572 1000
          #input tap $x 572
          #sleep 10
          break
        fi
        y1=$((y1-1))
      done
      y=$((y+60))
    fi
    y=$((y+10))
  done
}

ReadDonation()
{
  echo "read donation here x y - $1 $2"
  echo "Requester,48,$(($2-53)),200,20">donationRequest.config
  echo "Request,48,$(($2-19)),200,20">>donationRequest.config
  echo "Troops,80,$(($2+6)),70,27">>donationRequest.config
  echo "Spell,211,$(($2+6)),32,24">>donationRequest.config
  #curl http://localhost:8951/drag/200/100/200/520/10
}

GetDonationWindowBorderPoints()
{
  y=2
  x=302
  while [ $y -le 600 ]
  do
    isWhite=$(MatchPixel x y 255 255 255 1)
    if [ "$isWhite" = "y" ]
    then
      break;
    fi
    y=$((y+10))
  done

  while [ $y -ge 0 ]
  do
    isWhite=$(MatchPixel x y 255 255 255 1)
    if [ "$isWhite" = "n" ]
    then
      echo "top $x $y"
      break;
    fi
    y=$((y-1))
  done
}

QuickAttack()
{
	SendMessage 'quick_attack'
}
SwitchID()
{
	Tap 760 520
	WaitFor "Settings" "" 10
	Act Settings Connected
	WaitFor "SCID" "" 15
	Act SCID Logout
	WaitFor "SCIDLO" "" 15
	Act SCIDLO Confirm
	sleep 3
	Tap 220 620
	WaitFor "SCIDCFS" "" 5
	if [ "$1" = "1" ]
	then
		Tap 300 390 #ID1
	else
		Tap 300 295 #ID2
	fi
	WaitFor "Home" "" 10
	Zoom
}
Run()
{
	SendMessage "abcd"
	SendMessage "abcd"
	SendMessage "abcd"
	LogRemote "$1_Starting"
	StopCOC
	Home
	SwitchID $1 
	Loose $1
	quickTrainXPos=520
	if [ "$1" = "2" ]
	then
		quickTrainXPos=730
	fi
	Tap 40 520
	sleep 0.1
	Tap $quickTrainXPos 95
	sleep 0.1
	Tap 730 448
	sleep 0.1
	Tap 85 95
	sleep 0.1
	ready=$(IsReadyForAttack)
	if [ "$ready" = "y" ]
	then
		Tap 768 92
		Attack $1
		sleep 60
		StopCOC
		Home
		Zoom
		Tap 40 520
		sleep 0.1
		Tap $quickTrainXPos 95
		sleep 0.1
		Tap 730 448
		sleep 0.1
	else
		Tap 768 92
		echo "not ready"		
	fi
	LogRemote "$1_Done"
}
