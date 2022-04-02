# License使用指南
从3.29.0版本开始，提供一体化License服务，通过一个License可为同一个账号下的所有APP提供视频云SDK的接入服务。服务升级的同时，短视频SDK的集成方式也有所变化

| 接入类型 | 说明
| --- | --- |
| 新接入 |  按照官网文档对接使用最新版本即可。集成说明：[iOS](../iOS%20SDK/SDK使用.md)、[Android](../Android%20SDK/SDK使用.md)
|  SDK版本升级 | 对于已接入<3.29.0版本的客户，在 License 有效期内，您可以继续使用老版本 SDK。如果您想升级到3.29.0及以后版本，集成时需要调用注册接口把LicenseKey和LicenseFile注入到SDK内。集成说明：[iOS](../iOS%20SDK/SDK使用.md)、[Android](../Android%20SDK/SDK使用.md)

> LicenseKey和LicenseFile 会通过授权邮件发送。如需补发，请通过开通License授权（锚点到开通License授权）的步骤申请。

您可以阅读本文，快速了解短视频SDK License购买以及使用方式。

## 申请试用License授权
请发送以下信息至指定邮箱`videosdk@service.aliyun.com`。收到申请邮件后，我们将于2个工作日之内处理完开通申请。
* 公司名称
* 应用名称
* 申请试用的SDK版本（基础、标准、专业）
* 联系人
* 联系电话
* 应用bundleID
* 包名和签名信息

    要求：MD5格式、小写、无冒号

* 阿里云账号或UID

    如没有阿里云账号，请提前注册。注册步骤请参见注册阿里云账号。

> 注意
> * License免费试用期为一个月。
> * 请确保申请信息齐全、格式规范，后续若有需要更换包名、签名文件、BundleID任意一项，请重新申请。
> * 短视频专业版SDK的试用版支持高级美颜、智能抠图和手势识别等功能，这些功能由阿里云[美颜特效SDK](https://help.aliyun.com/document_detail/211047.html)或[第三方SDK](https://market.aliyun.com/products/57124001/cmfw014258.html?spm=a2c4g.11186623.0.0.17a7468bOWu5IH#sku=yuncode825800002)提供。如需试用，需要在申请邮件中额外注明，美颜特效SDK或第三方SDK的授权证书会通过邮件的形式送达。


## 购买License授权
短视频SDK由License进行授权控制，不同的License版本价格不一样，支持的功能也不一样。
不同版本的License所支持的功能差异请参见[功能列表](https://help.aliyun.com/document_detail/53407.htm?spm=a2c4g.11186623.0.0.17a7468b5ibeNq#section-5km-tsc-ob6)，短视频SDK各版本的购买及说明请参见下表：

* 基础版
  * 购买地址：[流量包、存储包、转码包、智能审核包](https://common-buy.aliyun.com/?spm=a2c4g.11186623.0.0.17a7468bOWu5IH&commodityCode=vodflowbag#/buy)
  * 说明：每个订单可授权一个APP（包括iOS和Android）。
    * 购买点播流量包、存储包、转码包、智能审核包，**单日内订单总金额超过1900元时**，将赠送短视频SDK基础版1年License授权。
    * 满足条件的客户，如需获取短视频SDK License，请参见[开通License授权](#开通License授权)，通过邮件提供相应信息，以便为您开通短视频SDK License。
  
* 标准版
  * 购买地址：[流量包、存储包、转码包、智能审核包](https://common-buy.aliyun.com/?spm=a2c4g.11186623.0.0.17a7468bOWu5IH&commodityCode=vodflowbag#/buy)
  * 说明：每个订单可授权一个APP（包括iOS和Android）。
    * 购买点播流量包、存储包、转码包、智能审核包，**单日内订单总金额超过3万元时**，将赠送短视频SDK标准版1年License授权。
    * 满足条件的客户，请参见[开通License授权](#开通License授权)，通过邮件提供相应信息，以便为您开通短视频SDK License。

* 专业版
  * 购买地址：[短视频SDK专业版](https://common-buy.aliyun.com/?spm=a2c4g.11186623.0.0.17a7468b5ibeNq&commodityCode=vodsdk)
  * 说明：1次购买最多支持3个App（最多支持10个马甲包），超出限制需额外购买。
    * 计费方式为按功能模块组合计费。
    * 购买后，请参见[开通License授权](#开通License授权)，通过邮件提供相应信息，以便为您开通短视频SDK License。
    * 短视频专业版SDK具备高级美颜、智能抠图和手势识别等功能，这些功能由阿里云[美颜特效SDK](https://help.aliyun.com/document_detail/211047.htm?spm=a2c4g.11186623.0.0.17a7468b5ibeNq#concept-2066390)或第[三方SDK](https://market.aliyun.com/products/57124001/cmfw014258.html?spm=a2c4g.11186623.0.0.17a7f844zN7Mo1#sku=yuncode825800002)提供，需单独收费。美颜特效SDK的购买请参见[美颜特效SDK](https://help.aliyun.com/document_detail/211047.htm?spm=a2c4g.11186623.0.0.17a7f844zN7Mo1#concept-2066390)；第三方SDK，可联系第三方商务人员获得折扣及其他优惠。


## 开通License授权
购买或获赠短视频SDK后，请提供订单号、应用名称、应用bundleID、包名和签名信息（MD5格式、小写、无冒号）、阿里云账号或UID，并发送至邮箱[videosdk@service.aliyun.com](videosdk@service.aliyun.com)，以便为您开通短视频SDK License。收到邮件后，我们将于2个工作日之内为您开通License授权，如有紧急需求请联系商务人员。

> 注意
> * License不需要集成到SDK里面，只需确保提交申请的bundleID、包名、签名信息和自己工程中的完全一致。
> * 测试时可以直接使用Demo提供的bundleID、包名、签名来体验。

## License失效
在短视频SDK的使用过程中，当调用部分功能接口，出现以下任一情况时，则表明License无效或已到期。

* 3.29.0以前版本：
  * 接口返回值为ALIVC_FRAMEWORK_LICENSE_FAILED(-10011001)。
  * 日志显示以下任一信息：
    * 30天无网络，License已禁用，请联系商务进行授权。
    * License已禁用，请联系商务进行授权。
    * License非法（包名和签名/BundleID没有在短视频SDK官网注册），超过7天试用，已经禁用。

* 3.29.0及以后版本：
  * 接口返回值为ALIVC_FRAMEWORK_LICENSE_FAILED(-10011001)。
  * 日志显示以下任一信息：
    * License已过期，请联系商务进行续费。
    * License未初始化，请参考文档进行接入。
    * License非法（包名和签名/BundleID没有在短视频SDK官网注册），请联系商务进行授权。
    * 使用增值服务：xxx 已过期，请联系商务进行续费。
    * 使用增值服务：xxx 非法，请联系商务进行授权。

License失效后，请参见[申请试用License授权](#申请试用License授权)、[购买License授权](#购买License授权)或联系商务人员重新获得License授权。

>[返回上一级](../README.md)