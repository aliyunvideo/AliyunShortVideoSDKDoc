# FAQ - AlivcFFmpeg版本依赖

如果APP共同引入短视频SDK和播放器SDK（不包含FFmpeg版本），并确保引入正确的AlivcFFmpeg版本
## Android
| AlivcFFmpeg版本 | 短视频SDK版本 | 播放器SDK版本 | 备注  |
| -------- | -------- | -------- | ----- |
| com.aliyun.video.android:AlivcFFmpeg:4.3.1.1-part | >= v3.27.0   |   不适用  | 短视频专用(较小)  |
| com.aliyun.video.android:AlivcFFmpeg:4.3.1-part | >= v3.26.0   |   不适用  | 短视频专用(较小)  |
| com.aliyun.video.android:AlivcFFmpeg:4.3.0-part | >= v3.25.0   |   不适用  | 短视频专用(较小)  |
| com.aliyun.video.android:AlivcFFmpeg:4.3.0 |  >= v3.24.0   |  >= v5.4.2.0    |   共用  |
| com.aliyun.video.android:AlivcFFmpeg:2.0.1  |   v3.22.0、v3.23.0  |  >= 5.1.2 && < v5.4.2.0  |  共用   |
| com.aliyun.video.android:AlivcFFmpeg:2.0.0  |   <= v3.21.0  |   <= 4.7.4  |  共用   |

## iOS

| AlivcFFmpeg版本 | 短视频SDK版本 | 播放器SDK版本 | 备注  |
| -------- | -------- | -------- | ----- |
| pod 'QuCore-ThirdParty', '4.3.0 |  >= v3.24.0   |  >= v5.4.2.0    |   共用  |
| pod 'QuCore-ThirdParty', '3.15.0  |   < v3.24.0  |  < v5.4.2.0  |  共用   |

>[返回上一级](README.md)