# File
## 查詢檔案大小
```
du -sh *
```

## Dir
### 建立資料加
```
mkdir
```
### 刪除資料夾
```
rm -rf ${dir_name} 
```
### 移動資料夾
```
mv ${dir_name} ${path/dirname] #移動資料夾
```

## Tar
### 壓縮
```
tar -cv ${file}.tar ${file}  
```
## 解壓縮
```
tar -xv ${file}.tar ${file}
```

## Txt File
### Read Txt File 
一次印出txt file的內容
```
$ cat ${file_name}
```
從上到下一頁一頁印出txt file的內容
```
more ${file_name}
```
從下到上一頁一頁印出txt file的內容
```
less ${file_name}
```
列印txt file最尾端內容
```
tail ${file_name}
```
持續列印txt file最新的尾端內容，通常看log用
```
tail -f ${file_name}
```
### Edit Txt File
```
vi ${file_name}
```