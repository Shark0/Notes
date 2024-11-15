# 後記
## 對書的看法
這本書如果是專門介紹六角我是沒意見，甚至會覺得這是一本好書。但是對於Clean Architecture = 六角的定義我就不認同，世界上Design Patterm如此多，沒用六角就是Dirty Architecture? 一個李氏替換原則就可以否定那些用到Override的情境?

有人說我看了這本書對六角沒感覺是因為我是很爛的工程師，我是沒有生氣，因為我是什麼樣的人我自己知道就好，但還是先把我覺得我認同的地方列一下。
* 要在意專案的維護性
* 為Domain開發
* SRP跟OCP是好觀念，但是LSP、ISP、DIP看情境
* 元件之間不要有循環依賴

## 我的框架
### 架構
還是以三層式為架構，三層最大的好處就是直覺適合新手，後續會講解好處與壞處，先列架構，後續拿User來舉例，順便融入一些管理職學。

```
* Config
* Controller
    * Domain1Controller
* Service
    * Domain1
        * Pojo
            * Domain1UseCase1Dto
            * Domain1UseCase2Dto
        * Domain1UseCase1ApiService - 一個API一個Service，彼此不互Call
        * Domain1UseCase2ApiService
        * Domain1SubUseCaseService - 共用邏輯，像是權限檢查之類，SubUseCaseService絕不依賴UseCaseApiService，
          Input最好是Table Do，避免出現不同Function重複去Datasource抓相同資料行為
* Datasource
    * DB
        * Source
            * Pojo
                * Table1Do
            * Table1JpaRepository
    * API
        * Source
            * Pojo
                * Api1Do
            * Api1Request
```
### User Domain
為何會拿User Domain來舉例，因為我其實一開始開發生涯是做前端，職涯已經做了9個APP，每個APP第一步都是做User Domain相關的事物，像是登入、個人資料修改，所以我拿User當範例。

* 現在App做User註冊，大多會為了讓註冊簡單而讓User將App的帳號跟Google與Facebook等社群平台做綁定，在前端OAuth 取得platformUserId後，會打User Login API。
* 登入成功拿到JWT後，有可能會做更新其他User資訊的Update User API
* 另外一個APP通常都有Admin角色，他是透過帳密登入，他能管理一般Usre帳號

### Controller
有四個Use Case，那已SRP的概念就有以下API，只是這API Controller你要怎麼切分，或是用微服務的概念，是否要將Admin跟User切成兩個微服務? 此範例先用一個Backend Service舉例。
```
* controller.user
    * UserController
        * post /user/login - userLogin(PlatformUserLoginData) - 因為有建立User行為
        * put /user - updateUser(UserJwtDto, UpdateUserData)
* controller.admin
    * AdminController
        * post admin/login - adminLogin(AdminLoginDto)
        * get admin/user - getUserInfo(AdminJwtDto, userId)
        * put admin/user - updateUser(AdminJwtDto, userId)
```
切成兩個Controller，先把User自己跟Admin管理User的Domain切出來，兩個Controller分別SRP修改理由就是User或Admin對User的需求有新增或變動。

### Service
分成UseCaseApiService跟SubUseCaseService

#### UseCaseApiService
UseCaseApiService基本上就是完成該API需要執行的業務邏輯，最好一個API一個UseCaseApiService，某種程度上符合SRP跟OCP精神。UserCaseApiService的入口Function要好維護，開發要規劃好完成一個Domain需要做到那些Step，把那些Step Function化達到Clean Code，讓之後維護人員可以看Step可以快速對應到Domain Spec。

用UserLoginApiService來舉例，他的入口Domain Function因該包含以下Step
```
public ResponseDto<UserLoginDto> start(UserLoginInputDto input) {
    FacebookUserDto facebookUserDto = findFacebookUser(input.getFacebookUserId());
    UserDo userDo = saveUser(facebookUserDto);
    UserLoginDto userLoginDto = generateResponseData(userDo);
    return ResponseDto.<UserLoginDto>builder.data(userLoginDto).status(success).build();
}
```
#### SubUseCaseService
當UseCaseApiService彼此之間有共有邏輯，彼方Admin還有分對於User CRUD的Permission，那就API代表不同Admin API都要根據Domain去判斷權限，檢查權限的SubUserCaseService就如下。

```
@RequiredArgsConstructor
Public Class CheckAdminUpdateUserPermissionService {
    private final PermissionRepository permissionRepository;
    public void check(String adminRoleCode) {
        int count = permissionRepository.countPermission(adminRoleCode, "UPDATE_USER");
        if(count == 0) {
            throw new NoPermissionException();
        }
    }
}
```
若一個SubUseCase需要用到一個Table Do多個部分資料，我個人是建議Table Do是可以在UserCaseApiService先抓出來再傳進去，而非傳入Table Do的ID讓每個SubUseCaseService自己去抓，避免多個SubUseCase重複抓資料的行為。另外要不要為了Clean Code將每個Table Do轉成每個SubUseCaseService的Input Dto，我個人因曾經看過無數個參數一樣的不同DTO + 滿滿的DTO，所以我個人是覺得不用到絕對乾淨。

再來如果SubUseCase的結果不只一種，是可以考慮用觀察模式來滿足ISP、DIP，範例如下

```
Public Class SubUseService {
    public void start(TableDo do, SubUseCaseEventListener listener) {
    //use do to do somthing domain logic
        if(condition1) {
            listner.event1();
            return;
        }
        if(condition2) {
            listner.event2();
            return;
        }
        ...
        listner.eventN();
    }
}
```
### Data Source
#### Database
題外話一下，我個人不喜歡向Mybatis的那種動態組Sql，我個人希望Sql像Do的貧血模型一樣盡量不要扯上邏輯，一但扯上邏輯就很難直覺的做出相關測試，但不喜歡不代表我沒有能力維護。

Jpa的Repository已經算是符合ISP、DIP，我覺得沒必要多做一個Adapter。若是Do跟Response Dto相差沒多少，我也覺得沒必要Map成Dto。

#### API
一個API的情境會有很多種，請求成功、連線失敗、驗證失敗、權限不足，之前我做前端時，一個API不會只給一個頁面用，所以也會用觀察者模式，將一個API的事件定義完再透過一個Linstener Interface將事件回傳給呼叫者，讓每個呼叫者決定要怎麼對事件處裡。

```
Public Class RequestApiWorker {
    public void request(RequestInputDto, ApiEventListener listener) {
    //use rest template to call api and get response
        if(response.httpStatus() = 404) {
            listner.onErrorEvent(tag, response.errorMessage());
            return;
        }
        if(response.httpStatus() = 401) {
            listner.onAuthErrorEvent();
            return;
        }
        if(response.httpStatus() = 403) {
            listner.onNoPermissionEvent();
            return;
        }
        ...
        listner.onSuccessEvent(response.data());
    }
}
```
抓取檔案的Data Source也可以透過同樣邏輯處裡

#### Queue
通常一個Queue的串接都已經決定由哪個DomainUseCaseService處裡，Queue的Data Listener這就就只是一個Adapter的腳色，只看要不要將資料Map成DomainUseCaseService的Input Dto

```
@RequiredArgsConstructor
Public Class QueueAdapter {
    private ComsumeQueueService comsumeQueueService;
    @Listener
    public void consume(QueueDo queueDo){
        //filter data
        //map data
        comsumeQueueService.start(consumeQueueDto)
    }
}
```