# Shell-Script-logging-parser
로그데이터 추출용 shell script

[ 파일 인코딩 확인 ]
```
  file -bi 파일명
```

[ 인코딩 변환 ]
```
  iconv -f utf-8 -t euc-kr input 파일명 > output 파일명
```
[ 인코딩 변환시 error skip ]
-  -c 옵션을 주면 인코딩 변환시 해당 라인을 무시
```
 iconv -c -f utf-8 -t euc-kr input 파일명 > output 파일명
```
