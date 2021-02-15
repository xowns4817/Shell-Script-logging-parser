#!/bin/bash

result=""
sessionKey=""
findFlag=0
closeFlag="CLOSE"
rowNum=0
totalNum=$(cat dialog.data | wc -l) # 뽑을 로그데이터 전체 행 갯수
tailIdx=0

echo "===================="
echo "Start Script...."
echo "===================="

while read line
	do
	sessionKey=$line
	echo "sessionKey : " $sessionKey
	rowNum=$(grep -n $sessionKey dialog.data | cut -d: -f1 | head -1) # 해당 키워드가 몇번째 row에 있는지 확인
	tailIdx=`expr ${totalNum} - ${rowNum} + 1` # tail을 어디서 부터 잡아야 할지 설정
	while read line2
	do
	if [ "$closeFlag" == "$line2" ] # CLOSE를 발견할때까지 loop 탐색
	then
		result=$result'"'
		result=$result'\n'
		break
	else
		result=$result$line2'\n'
	fi
	done < <(tail -n -$tailIdx dialog.data) # 찾은 sessionKey부터 아래로 탐색
done < sessionKeyList.data

echo -e "$result" > test.txt

echo "===================="
echo "End Script..."
echo "===================="

