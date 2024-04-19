# Variable
變數有分env跟shell變數，env是當下使用者的變數，shell是當下執行shell的變數。

## 印出當前用戶env變數
```
env
```
## 印出shell變數
```
set
```
## 設定shell變數
```
$key=$value
$key"${$key}"$new_value
$key_array_name[1]=$value1
$key_array_name[2]=$value2
$key_array_name[3]=$value3
```

## 印出特定shell變數
```
echo "${key}"
echo "${$key_array_name[1]}", "${$key_array_name[2]}", "${$key_array_name[3]}"
```

## 印出同時是用戶環境變數的shell變數
```
export
```

## 將變數設定成用戶環境變數與Shell變數
```
export $key=$value
```

## 將變數從用戶環境變數與shell清空
```
unset $name
```

## 將檔案裡的變數設定成環境與Shell變數
```
$ source ~/.bashrc
```

## 查詢指令別名
```
alias
```