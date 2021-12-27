
# 动态贴纸

短视频SDK中的动图资源支持自定义。自定义动图制作规范，请参见[阿里云短视频SDK动态贴纸及气泡制作规范](http://docs-aliyun.cn-hangzhou.oss.aliyun-inc.com/assets/attach/123586/cn_zh/1561623388954/%E9%98%BF%E9%87%8C%E4%BA%91%E7%9F%AD%E8%A7%86%E9%A2%91SDK%E5%8A%A8%E6%80%81%E8%B4%B4%E7%BA%B8%E5%8F%8A%E6%B0%94%E6%B3%A1%E5%88%B6%E4%BD%9C%E8%A7%84%E8%8C%83.pdf?spm=a2c4g.11186623.2.10.4831136eLMstvS&file=%E9%98%BF%E9%87%8C%E4%BA%91%E7%9F%AD%E8%A7%86%E9%A2%91SDK%E5%8A%A8%E6%80%81%E8%B4%B4%E7%BA%B8%E5%8F%8A%E6%B0%94%E6%B3%A1%E5%88%B6%E4%BD%9C%E8%A7%84%E8%8C%83.pdf)。


## 使用示例

### iOS
* 动态贴纸：使用[AliyunStickerManager的addGif:startTime:duration:](https://alivc-demo-cms.alicdn.com/versionProduct/doc/shortVideo/iOS_cn/Classes/AliyunStickerManager.html#/c:objc(cs)AliyunStickerManager(im)addGif:startTime:duration:)添加
* 气泡文字：使用[AliyunStickerManager的addCaptionText:bubblePath:startTime:duration:](https://alivc-demo-cms.alicdn.com/versionProduct/doc/shortVideo/iOS_cn/Classes/AliyunStickerManager.html#/c:objc(cs)AliyunStickerManager(im)addCaptionText:bubblePath:startTime:duration:)添加


> 具体请参考 [字幕及贴纸](../../iOS%20SDK/功能说明/视频编辑/编辑/字幕及贴纸.md)

### Android
* 动态贴纸：调用`AliyunPasterManager.addPasterWithStartTime(Source path, long startTime, long duration);`方法更新特效。
* 气泡文字：调用`AliyunPasterControllerCompoundCaption.setBubbleEffectTemplate(Source aStyleTemplate);`方法。

> 具体请参考 [字幕及贴纸](/Android%20SDK/功能说明/视频编辑/编辑/字幕及动态贴纸.md)

>[返回上一级](../README.md)