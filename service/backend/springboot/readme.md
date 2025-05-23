# Springboot

## IOC
IoC（控制反轉）是 Spring Boot 的核心設計原則，通過將物件的創建和依賴管理交給 IoC 容器（ApplicationContext），實現了鬆耦合和模組化。Spring Boot 通過自動掃描、註解（如 @Autowired、 @Component）和自動配置，簡化了 IoC 的使用。依賴注入是 IoC 的主要實現方式，推薦使用建構子注入以確保依賴的明確性和不可變性。

### IoC 的優點
* 鬆耦合：物件不直接創建依賴，依賴由容器注入，降低程式碼耦合度。
* 易於測試：通過注入模擬物件（Mock），方便單元測試。
* 靈活性：可通過配置切換依賴實現（例如切換資料庫實現）。
* 集中管理：容器統一管理 Bean 的生命週期和配置，減少重複程式碼。
* 模組化：業務邏輯與依賴分離，提高程式碼可維護性。

### IoC 的缺點
* 學習曲線：初學者可能難以理解 IoC 容器的工作原理。
* 複雜性：在大型項目中，Bean 數量多可能導致配置和調試困難。
* 效能開銷：IoC 容器在啟動時需要掃描和初始化 Bean，可能增加啟動時間。
* 隱式依賴：過度依賴自動注入可能導致依賴關係不明顯，增加維護難度。

## Dependency Injection (DI)
### Spring Boot 如何實現依賴注入
Spring Boot 的依賴注入由 Spring 的 ApplicationContext（IoC 容器）負責，具體步驟如下：

* 定義 Bean：通過 @Component、 @Service、 @Repository、 @Controller 或 @Bean 註解將類標記為 Spring 管理的 Bean。
* 掃描 Bean：Spring Boot 自動掃描 @SpringBootApplication 指定的包及其子包，發現並註冊 Bean。
* 依賴解析：Spring 根據 Bean 的依賴關係（通過建構子、Setter 或屬性）自動解析並注入所需的 Bean。
* 注入執行：在應用啟動時，Spring IoC 容器創建 Bean 實例並完成依賴注入。

### 依賴注入的三種方式
個人是推薦Construct + Lombok

#### 建構子注入
方式：通過建構子將依賴傳入，通常搭配 @Autowired 註解（Spring 4.3+ 可省略）。
優點：
* 確保依賴不可變（final），提高物件的不可變性。
* 依賴明確，物件創建時即確保所有依賴都已注入。
* 便於單元測試（易於模擬依賴）。

#### Setter 注入 (不建議)
方式：通過 Setter 方法注入依賴，搭配 @Autowired。
優點：
* 允許在運行時動態改變依賴。
* 適合非必要依賴（可選依賴）。
缺點：依賴可能未初始化，需額外檢查。

#### 屬性注入
方式：直接在屬性上使用 @Autowired 註解。
優點：程式碼簡潔，易於快速開發。
缺點：
* 依賴不可變，難以保證初始化。
* 不利於單元測試（無法輕易模擬依賴）。
* 不推薦在正式項目中使用。

### Spring Boot 依賴注入的背後原理
#### IoC 容器
Spring Boot 使用 ApplicationContext 作為 IoC 容器，負責創建、管理和注入 Bean。
在應用啟動時，Spring 掃描所有標記為 @Component（或衍生註解）的類，創建 Bean 並儲存在容器中。

#### Bean 生命週期
Spring 負責 Bean 的創建、依賴注入、初始化和銷毀。
依賴注入在 Bean 初始化階段完成。

#### 自動配對
Spring 根據類型（byType）或名稱（byName）自動匹配依賴。
如果有多個匹配的 Bean，會使用 @Qualifier 或 @Primary 解決衝突。

#### 代理模式
對於某些 Bean（例如使用 AOP 或 @Transactional），Spring 會創建代理物件，依賴注入的可能是代理而不是原始物件。

## AOP
AOP（面向切面程式設計）是一種程式設計範式，旨在將橫切關注點（Cross-Cutting Concerns）與業務邏輯分離，以提高程式碼的模組化。橫切關注點是指那些跨越多個模組的功能，例如日誌記錄（Logging）、安全檢查（Security）、事務管理（Transaction Management）、效能監控等。AOP 允許開發者在不修改核心業務邏輯的情況下，將這些共用功能集中管理。

在 Spring Boot 中，AOP 由 Spring 框架提供支持，基於 Spring AOP 和 AspectJ 實現。Spring Boot 通過自動配置簡化了 AOP 的使用。

### Spring Boot AOP 的核心概念
* Aspect（切面）：封裝橫切關注點的模組，包含 Advice 和 Pointcut。
* Advice（通知）：定義切面在特定時機執行的行為，例如方法執行前（Before）、後（After）或異常時（AfterThrowing）。常見的 Advice 類型包括：
* Before：方法執行前運行。
* After：方法執行後運行（無論成功或失敗）。
* AfterReturning：方法成功返回後運行。
* AfterThrowing：方法拋出異常後運行。
* Around：包圍方法執行，可控制方法是否執行及何時執行。
* Pointcut（切入點）：定義 Advice 應用的目標，例如特定方法或類。通過表達式（如正則表達式或 AspectJ 語法）指定匹配條件。
* Join Point（連接點）：程式執行中的某個點（如方法執行、異常拋出），AOP 可以在這些點插入邏輯。
* Weaving（織入）：將切面邏輯應用到目標物件的過程，可以在編譯時（Compile-Time）、類載入時（Load-Time）或運行時（Runtime）進行。
* Target Object（目標物件）：被切面增強的物件，通常是 Spring 管理的 Bean。
* Proxy（代理）：Spring AOP 使用代理模式（基於 JDK 動態代理或 CGLIB）來實現切面邏輯。

### Spring Boot 中 AOP 的用途
Spring Boot 中的 AOP 常用於以下場景
* 日誌記錄：自動記錄方法調用、參數、執行時間或異常。
* 安全檢查：在方法執行前檢查使用者權限或認證狀態。
* 事務管理：通過 @Transactional 自動管理資料庫事務（內部基於 AOP 實現）。
* 效能監控：計算方法執行時間，識別效能瓶頸。
* 異常處理：統一處理特定異常，減少重複的 try-catch 程式碼。
* 快取管理：自動快取方法結果或清除快取。