#!/bin/bash

log_file=dialog.data
find_list=test.data

result=""
input=""
findFlag=false
closeFlag="CLOSE"
rowNumArr=0
totalNum=$(cat $log_file | wc -l) # 뽑을 로그데이터 전체 행 갯수
tailIdx=0
end_str="\""

echo "===================="
echo "Start Script....from input"
echo "log_file : " $log_file
echo "find_list : " $find_list
echo "===================="

	while read line
	do
		input=$line
		echo "input : " $input
		rowNumArr=(`grep -n $input $log_file | cut -d: -f1`) # log_file에 input으로 들어온 키워드가 위치한 rows들 출력
		for(( i=0; i<${#rowNumArr[@]}; i++ )); do
			tailIdx=`expr ${totalNum} - ${rowNumArr[i]} + 2` # tail을 어디서 부터 잡아야 할지 설정
			while read line2
			do
				if [ "$findFlag" = true ]; then
					if [[ "$line2" =~ "$end_str" ]]; then # CLOSE가 없을 경우를 대비해 "일때도 break
					result=$result$closeFlag
					result=$result'\n'
					result=$result'"'
					findFlag=false
					break
					fi
				fi
				if [[ "$line2" =~ "$closeFlag" ]] # CLOSE를 발견할때까지 loop 탐색
				then
					result=$result$closeFlag
					result=$result'\n'
					result=$result'"'
					findFlag=false
					break
				else
					result=$result$line2'\n'
				fi
				if [[ "$line2" =~ "$end_str" ]]; then #line2에 "가 포함되면 findFlag값 변경
					findFlag=true
				fi	
			done < <(tail -n -$tailIdx $log_file) # 찾은 sessionKey부터 아래로 탐색
		done	
	done < $find_list

echo -e "$result" > test.txt

echo "===================="
echo "End Script..."
echo "===================="

