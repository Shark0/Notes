# Check Process Memory

## Get Application Process
```
ps -aux | grep $application_name
```

## 透過pid跟top指令列出系統資源狀況
```
top -Hp $pid
```

## 用jstack觀看Pid的Memory Stack
```
jstack -l $pid
```

## 匯出Memory Analyze File
```
jps
jmap -dump:live,format=b,file=dump.hprof $pid
```

## 用UI分析Memory集中在哪個Class
將dump.hprof丟進IntelliJ的Profiler