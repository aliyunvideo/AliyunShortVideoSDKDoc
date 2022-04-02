# SDK使用
## 头文件引入
* 专业版
``` OBJC
#import <AliyunVideoSDKPro/AliyunVideoSDKPro.h>
```
* 基础版
``` OBJC
#import <AliyunVideoSDKBasic/AliyunVideoSDKBasic.h>
```
## 初始化
短视频SDK服务需要开通License，开通方式请参见[License](../License使用指南/README.md)使用指南。
开通License后,请确保提交的bundle id和XCode中对应配置保持一致，开通成功后会获得`LicenseKey`和`LicenseFile`。
> 注意：请先参考 [集成SDK](./工程配置.md) 中的 **License配置** 进行配置。

### 初始化接口
```Objective-c
NSError *error = [AliyunVideoSDKInfo registerSDK]; // 返回error为nil表示注册成功
// 因为注册失败基本属于接入错误，所以建议直接加上Assert就可以在接入调试时显示错误和修复建议
NSAssert2(error == nil, @"注册SDK失败！%@；%@", error.localizedDescription, error.localizedRecoverySuggestion);
```
## License管理
您可以通过代码查询当前License状态信息，如果你续费了或者购买了增值服务也可以主动及时去更新License（默认15分钟检查更新）。
### 获取当前状态
是否已经初始化成功（License已经注入到SDK内部）：`AliyunVideoLicenseManager.HasInitialized`
### 获取当前License信息
`AliyunVideoLicense *license = AliyunVideoLicenseManager.CurrentLicense;`
### 主动更新License（默认每隔15分钟检查更新）
```Objective-c
/**
 证书更新结果
 
 - AliyunVideoLicenseRefreshCodeUninitialized:  未初始化
 - AliyunVideoLicenseRefreshCodeSuccess: 更新成功
 - AliyunVideoLicenseRefreshCodeInvalid: 没找有效证书
 - AliyunVideoLicenseRefreshCodeServerError: 服务端错误
 - AliyunVideoLicenseRefreshCodeNetworkError: 网络错误
 - AliyunVideoLicenseRefreshCodeUnknownError: 未知错误
 */
[AliyunVideoLicenseManager Refresh:^(AliyunVideoLicenseRefreshCode code){
    // 更新结果: code
}];
```
### 监听鉴权结果
在您使用具体功能或增值服务时，SDK内部会发生鉴权，如果鉴权失败会在对应的接口返回结果。您也可以在统一的地方监听鉴权结果：
```Objective-c
AliyunVideoLicenseManager.EventDelegate = self; // 具体参考AliyunVideoLicenseEventDelegate协议说明
```
### 主动查询鉴权结果
```Objective-c
/**
 证书验证结果
 
 - AliyunVideoLicenseResultCodeUninitialized: 未初始化
 - AliyunVideoLicenseResultCodeSuccess: 验证成功
 - AliyunVideoLicenseResultCodeExpired: 已经过期
 - AliyunVideoLicenseResultCodeInvalid: 证书无效
 - AliyunVideoLicenseResultCodeUnknownError: 未知错误
 */
AliyunVideoLicenseResultCode code = [AliyunVideoLicenseManager check];
```

### 鉴权失败
* License一旦到期，使用接口有API报错

    接口返回值为`ALIVC_FRAMEWORK_LICENSE_FAILED(-10011001)`。参考[错误码](错误码.md#License)。

* 日志显示以下任一信息表示鉴权失败：
    * License已过期，请联系商务进行续费。
    * License未初始化，请参考文档进行接入。
    * License非法（包名和签名/BundleID没有在短视频SDK官网注册），请联系商务进行授权。
    * 使用增值服务：xxx 已过期，请联系商务进行续费。
    * 使用增值服务：xxx 非法，请联系商务进行授权。

## 日志输出
默认情况下，仅输出警告和出错日志(AlivcLogWarn)，很多时候可以设置日志输出级别，打印更多日志，帮助我们发现更多问题
``` OBJC
// 日志级别定义如下：
typedef NS_ENUM(NSInteger, AlivcLogLevel)
{
    AlivcLogClose = 1,
    AlivcLogVerbose,
    AlivcLogDebug,
    AlivcLogInfo,
    AlivcLogWarn,
    AlivcLogError,
    AlivcLogFatal
};
// 设置日志输出级别
[AliyunVideoSDKInfo setLogLevel:AlivcLogDebug];
```
## 版本信息
在需要的情况下，可以打印版本信息，确保引入的SDK的版本正确，有助于问题的排查
``` OBJC
[AliyunVideoSDKInfo printSDKInfo];
```
或者打印需要的信息
``` OBJC
NSString *version = [AliyunVideoSDKInfo version]; // 版本号
NSString *module = [AliyunVideoSDKInfo module];   // 版本类型
int moduleCode =[AliyunVideoSDKInfo versionCode]; // 版本类型代码
NSString *buildId =[AliyunVideoSDKInfo videoSDKBuildId]; // 版本打包id
NSLog(@"\n==============\nVERSION：%@\nBUILD_ID：%@\nMODULE：%@\nMODULE_CODE：%d\n==============", version, buildId, module, moduleCode);
```
>[返回上一级](README.md)