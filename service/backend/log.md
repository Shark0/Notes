# Log
## Level 
* Debug: 開發用的Log，方便用來debug，像是去db query的sql
* Info: 一般追查用的Log，像是什麼時間、誰、做了甚麼事、帶了那些參數，應付PM提問
* Warn: 警告追查用的Log，像是什麼時間、誰、做了甚麼不應該做的事、帶了那些參數
* Error: 非預期系統錯誤Log

## Setting Trace Id
方便追查一個api在該thread運行的全部流程

## Parser Log
### Command
Print lines within a particular time range and keyword
```
awk '/${start_time}/,/${end_time}/ { if (/${keyword}/) print }' '${log_file}}'
```
example
```
awk '/2022-02-28 16:49:/,/2022-02-28 16:51:/ { if (/StartWcfServer/) print }' '5 error.log'
```
上方指令在範例有個問題，就是如果沒有2022-02-28 16:49或2022-02-28 16:51 這些Log，會找不到Log，
所以建議先找某天某個小時的時間區段開始，像是
```
awk '/2022-02-28 16:/,/2022-02-28 16:/' '5 error.log'
```