# 尋找執行豬
指令
```
ps aux | grep ${application}
```

# 透過pid跟top指令列出系統資源狀況
* 指令
```
top -Hp ${pid}
```

# jstack
```
jstack -l ${pid}
```

# Memory Analyze
```
jps
jmap -dump:live,format=b,file=dump.hprof ${pid}
```
