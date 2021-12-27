# FAQ - Android

## 工程问题

### Q ： 安卓指令集的兼容情况如何？

A ： 目前SDK提供的指令集：armeabi-v7a和arm64-v8。

建议：其他第三方包全部使用armeabi-v7a和arm64-v8的包。如果其他第三方的包没有提供armeabi-v7a或者arm64-v8的包，可以将SDK的so拷贝到armeabi里面。然后使用gradle命令行加入：

```Groovy
defaultConfig {
    …　　　　
    ndk {　　　　
        abiFilters “armeabi”//如果需要保证armeabi-v7a这里改成armeabi-v7a就可以了.　　　　
    }
}
```

### Q : 集成SDK后，Debug版本可以正常运行，但是Release版本启动就崩溃，该怎么解决？

A : 先检查崩溃的log是否是报JNI找不到对应的Java类，如果是的话，一般来说就是混淆导致的，因为JNI调用Java类用的是反射，所以如果混淆把SDK内部与JNI有关的类混淆掉了，则JNI加载时将无法找到对应的Java类，就会加载失败，解决办法就是把Demo的混淆配置拷贝到开发者工程的混淆配置中。

### Q : 如何添加硬编黑名单，硬解白名单？

A :

添加硬编码黑名单

```Java
/**
* 添加硬编码黑名单，model和versions的顺序必须对应起来
* 黑名单内的机型将使用软编，黑名单外的机型都使用硬编
* @param models 机型Model信息列表{@link Build#MODEL}
* @param versions 系统版本号列表{@link Build.VERSION#SDK_INT}，如果不需要适配版本号，填写0即可
*/NativeAdaptiveUtil.encoderAdaptiveList(String[] models,int[] versions);
```

添加硬解码白名单

```Java
/**
* 添加硬解码器白名单，model和versions的顺序必须对应起来
* 如果开启硬解码了，则白名单中的机型将使用硬解码，白名单外的机型将使用软解码
* @param models 机型Model信息列表{@link Build#MODEL}
* @param versions 系统版本号列表{@link Build.VERSION#SDK_INT}，如果不需要适配版本号，填写0即可
* @see #setHWDecoderEnable(boolean)
*/
NativeAdaptiveUtil.decoderAdaptiveList(String[] models, int[] versions);
```



### Q ： Android基础版本提示`java.lang.NoSuchFieldError: No field height of type I in class Lcom/aliyun/snap/snap_core/R$id; or its superclasses (declaration of ‘com.aliyun.snap.snap_core.R$id’ appears in /data/app/com.rablive.jwrablive-2/base.apk:classes2.dex)`，该如何解决？

A ： 出现这个错误是因为在开发者的工程中存在和AAR（SDK）一样的xml，于是导致冲突。

解决方法：找到出现冲突的xml，开发者自行加前缀。目前发现容易冲突的xml包括：`activity_setting.xml`和`activity_video_play.xml`。

### Q : Android基础版提示`java.lang.NoSuchFieldError: No static field notification_template_lines of type I in class Lcom/aliyun/snap/snap_core/R$layout; or its superclasses (declaration of ‘com.aliyun.snap.snap_core.R$layout’ appears/data/app/com.Aliyun.AliyunVideoSDK.VodSaaSDemo_android-1/base.apk)` ，该如何解决？

A : 目前基本原因是基础版SDK的UI不开源， 所以内部是引用了support包的，但是打成AAR时是没有support包打入的，这就导致ID不对应的情况。目前需要您将support版本包对应，如下：

```Groovy
//重要如果工程中引入第三方库也引入了support包，也必须要保证第三方的包版本对应，建议以源码引入第三方库
compile 'com.android.support:appcompat-v7:24.2.1'
compile 'com.android.support:design:24.2.1'
```

但是有时候第三方库带support包修改起来比较麻烦可能有些第三方包并不是源码引入的，这样建议在Application里面的gradle配置中。

```Groovy
configurations.all {
    resolutionStrategy {
        force 'com.android.support:appcompat-v7:24.2.1'
        force 'com.android.support:design:24.2.1'
    }
}
```

### Q : Demo使用时提示Please invoke the FileDownloader#init in Application#onCreate first，该怎么解决？

A : 需要在Application OnCreate中调用DownloaderManager.getInstance().init(Context context);。



### Q : SDK内部是否有获取视频封面的接口？

A ： 安卓目前专业版提供了接口：AliyunIThumbnailFetcher，可以获取非关键帧的图片，其他版本建议使用系统函数取帧。

## 视频录制

### Q : 录制如何添加普通动图？

A : 添加普通动图需要使用`AliyunIRecorder#addPaster(EffectPaster effectPaster,float sx,float sy,float sw,float sh,float rotation,boolean flip)`接口，并且在`EffectPaster`对象中填入信息，`EffectPaster`的isTrack一定要设置为false，否则贴图将作为人脸贴图处理，跟随人脸变化，如果没有人脸，贴图会不显示。另外该接口必须在`RecordCallback#OnInitReady()`回调之后调用，否则将不会显示贴图。

### Q : 如何设置录制角度？

A : 目前设置录制角度有setRotation 和 setRecordRotation两个接口，setRotation接口是一个自适应接口，只要nin把手机角度传感器返回的角度值传给这个接口，就可以得到正确的录制角度和人脸角度。setRecordRotation接口是自定义的视频角度接口，可以根据您的需求定制任意角度值。

### Q ： 如何实现横屏录制？

A : 您如果需要默认横屏只需要将界面UI元素旋转引导横屏拍摄视频，不需要设置界面横屏，让界面固定竖屏即可。
> android:screenOrientation="portrait"

横屏拍摄的视频录制完成合成的视频是会带旋转角度的，旋转角度以录制的第一段为准。

如果是专业版，在编辑之后调用合成接口合成的视频将会输出一个不带角度的视频。比如原始视频为360/640，角度：270变为640 /*360，由于基础版和标准版只有录制功能，如果横屏拍摄会得到一个带旋转角度的视频，这个视频是以拍摄时第一段的角度为准的。专业版录制时的行为同基础版和标准版，合成完成后视频不带角度，转换为一个角度为0，宽高变换的视频。

关键接口函数：

```Java
/**
* 设置视频旋转角度值
* @param rotation
*/
void setRotation(int rotation);

```

接口调用条件：

设置旋转角度需要在初始化完成之后设置，且需要保证录制第一段之前调用。

调用步骤：

让界面固定竖屏，然后设置旋转角度即可。

- 设置界面竖屏，让界面的UI元素旋转，引导您拍摄横屏的视频。
- 同普通录制的初始化
- 在调用开始录制前调用，注意旋转角度需要您自己获取，可以参考demo使用OrientationDetector来获取方向。

> mRecorder.setRotation(int rotation);

- 继续录制步骤，注意每次调用startRecording前都需要设置旋转角度以此来确定每段视频的旋转角度。


### Q : 拍摄添加背景音乐，完成后调用finishRecordForEditor，音乐没有合成进去，是什么原因？

A : 添加背景音乐后，必须调用`finishRecording`接口，才会把音乐合成进去，否则不会合成进去，造成进到编辑界面无音乐的结果。

`finishRecording`和`finishRecordForEditor`有什么区别呢？`finishRecording`有两个作用，一是录制多段的时候，调用该接口可以将多段拼接成一个mp4，也就是录制指定的输出文件，二是添加了背景音乐后，调用该接口会把背景音乐合成进这个输出mp4中，无论是多段还是单段都可以。`finishRecordForEditor`不会拼接多段视频，也不会将背景音乐合成到输出mp4文件中，而是仅仅将录制的片段（startRecording——>stopRecording之后就生成一个片段），按照指定的格式配置到project.json文件中（创建Editor时传入的Uri就是该文件的Uri）。

如果添加了背景音乐的录制多段，该如何进到编辑界面呢？先调用`finishRecording`将视频拼接成输出地址的mp4，然后将该mp4用AliyunIImport接口导入到编辑界面。

### Q ： 录制界面添加普通动图显示效果不完整，该怎么解决？

A ： 需要获取普通动图素材的宽和高。
> AliyunIRecorder#addPaster(EffectPaster effectPaster,float sx,float sy,float sw,float sh,float rotation,boolean flip) 

其中sw和sh参数需要符合素材宽高/屏幕宽高的比列。

比如： 素材的宽高为200、300，屏幕的宽高为540、720。则sw = (float)200/540, sh = (float)300/720。sx、sy是归一化的屏幕比例参数，坐标是以资源的中心点作为锚点的。




## 视频编辑

### Q : 编辑时添加特效，使用AliyunICompose.compose合成出来的视频不带特效，是什么原因？

A : V3.5.0及以前的版本，要把编辑预览的特效持久化到本地的配置文件中，需要调用AliyunIEditor.onPause接口，如果没有调用，则特效配置不会持久化到本地文件中，那么通过AliyunICompose接口反序列化生成的Project就不带特效，也就导致合成出来的视频不带特效。


### Q ：编辑时，调用applyMusic。添加音乐后，设置了startTime，为什么每次音乐流都从0开始播，而不是从startTime开始？

A ： 查看接口文档EffectBean类里对startTime的解释，startTime指的是特效在主流上的作用时间，并不是指素材流的起始时间，在V3.6.0版本之后增加了一个streamStartTime，这个参数是表示素材流的起始时间，即有这种需求的开发者，在V3.6.0及以后的版本中可以通过接口参数配置实现，但是之前的版本，只能开发者先对素材流做裁剪，然后用裁剪的音乐去做背景音乐。
![faq_android_edit_music](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/0972076061/p179087.png)

如果上图所示：在播放到10s的时候，背景音乐开始播，从音乐流的3s处播放，播到10s处，重新从3s处开始播，当第二遍播放到音乐流的6s时，刚好对应主流的20s位置，停止播放背景音乐。

### Q : 如何添加gif作为主体流？

A : V3.7.0以下版本gif格式的文件是作为图片类型导入，V3.7.0以上版本，gif格式的文件如果作为视频类型导入，则当做视频播放gif所有帧，如果作为图片导入，则作为图片播放第一帧。

### Q ： 为什么设置完转场或者applySourceChange之后，视频卡住不动了？

A ： 需要您在进行这些操作之后调用一下play接口。


>[返回上一级](README.md)