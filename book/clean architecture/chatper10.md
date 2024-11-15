# 應用程式組裝
## 組裝是有什麼好談的
雖然很然完全顧到SOILD，但還是盡量做到SRP跟OCP。

## 透過純程式碼組裝
看著書上的範例，我發現是我誤會了，他的Config是指六角Adapter的Config，而非我以為的Database、Security、Swagger類的Config。

若是六角Adapter的Config，那就最好別都在Application.class，很髒。

## 透過Spring的類別路徑掃描功能組裝
就是Springboot Compoment的介紹

## 透過Spring的Java Config來組裝
就是Springboot Configuration的介紹