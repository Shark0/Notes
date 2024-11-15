# 程式結構

# 已架構層為結構
覺得這篇的舉例有些偷吃步，基本上Domain的${Domain}Service可以訂的在細一點，其他的像是DO、Repository可以放到其他Package，個人覺得這樣也可以看得很細，如下

* buckpal 
  * repository 
    * account 
      * AccountRepositoryImpl
  * domain 
    * account 
      * repository 
        * AccountRepository 
      * pojo 
        * AccountDo 
      * CreateAccountService 
      * ReadAccountService 
      * UpdateAccountService 
      * DeleteAccountService
  * web 
    * AccountController

# 以功能為結構
同上篇想法

# 可呈現出架構的套件結構
架構沒問題，但是用port真的很容易讓人誤會成是url connection的port，因此要根據專案結構以及命名習慣做轉換。

# 依賴注入
沒想法，Springboot已經這樣做了