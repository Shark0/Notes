#鳥哥的shell script教學練習
* 參考網址：http://linux.vbird.org/linux_basic/0340bashshell-scripts.php
* 我有rename一些參數，讓可讀性高一點
* 好用的code review 或 debug技巧
```
[dmtsai@study ~]$ sh [-nvx] scripts.sh
選項與參數：
-n  ：不要執行 script，僅查詢語法的問題；
-v  ：再執行 sccript 前，先將 scripts 的內容輸出到螢幕上；
-x  ：將使用到的 script 內容顯示到螢幕上，這是很有用的參數！

範例一：測試 dir_perm.sh 有無語法的問題？
[dmtsai@study ~]$ sh -n dir_perm.sh 
# 若語法沒有問題，則不會顯示任何資訊！

範例二：將 show_animal.sh 的執行過程全部列出來～
[dmtsai@study ~]$ sh -x show_animal.sh 
+ PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/root/bin
+ export PATH
+ for animal in dog cat elephant
+ echo 'There are dogs.... '
There are dogs....
+ for animal in dog cat elephant
+ echo 'There are cats.... '
There are cats....
+ for animal in dog cat elephant
+ echo 'There are elephants.... '
There are elephants....
``` 