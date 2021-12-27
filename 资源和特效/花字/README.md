
# 花字协议制作规范

- [花字协议制作规范](#花字协议制作规范)
  - [前言](#前言)
  - [花字协议](#花字协议)
    - [config.json配置说明](#configjson配置说明)
      - [outline属性说明](#outline属性说明)
  - [示例](#示例)
  - [SDK中使用花字](#sdk中使用花字)
    - [iOS](#ios)
    - [Android](#android)

## 前言

阿⾥云短视频SDK是集视频录制，导⼊裁剪，视频编辑，上传为⼀体的技术解决⽅案。依托
于阿⾥云，打造了端+端+云的视频解决⽅案。SDK提供了丰富的功能接⼝，产品级的交互，丰富的
视频素材库（MV、贴纸、⽓泡、花字）。并推出了特效⾃定义能⼒来不同场景和⾏业下的素材需求，本⽂
档将重点介绍花字的制作规范和输出。

## 花字协议

一个完整的花字配置包含以下几个部分

├── config.json  	【必选】花字的配置文件

├── icon.png	     【可选】花字缩略图

└── lieheng.png    【可选】花字文字贴图，当配置文件有配置时使用

### config.json配置说明

config.json配置分成几个部分

| 字段     | 类型       | 是否必选 | 说明                                                                                                                                               |
| -------- | ---------- | -------- | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| version  | String     | 是       | 配置版本号，默认为1                                                                                                                                |
| color    | String     | 是       | 字体颜色，**格式: #AARRGGBB 或 #RRGGBB**                                                                                                           |
| texture  | String     | 否       | 文字贴图，**贴图只支持jpg和png，并且贴图需和config.json放置在同一文件夹下**,目前贴图规则是每个文字的贴图是完全一样，取贴图覆盖到字体颜色区域部分。 |
| outline1 | JSONObject | 是       | 描边-第一层                                                                                                                                        |
| outline2 | JSONObject | 否       | 描边-第二层，和outline1数据结构相同                                                                                                                |

#### outline属性说明

outline包含outline1和outline2

| 字段 | 类型      | 是否必选 | 说明                                                                                                     |
| ---- | --------- | -------- | -------------------------------------------------------------------------------------------------------- |
| type | String    | 是       | 默认为normal                                                                                             |
| data | JSONArray | 是       | 定义了描边的一系列颜色及宽度。**type = normal时，data最多允许有3个颜色配置，超过3个颜色配置只会取前3个** |

data子节点属性说明
| 字段  | 类型   | 是否必选 | 说明                                                                               |
| ----- | ------ | -------- | ---------------------------------------------------------------------------------- |
| color | String | 是       | 描边颜色，格式: #AARRGGBB 或 #RRGGBB                                               |
| width | float  | 是       | 描边宽度，**取值范围: [0~64]，且下一个同类型节点的width值，必须大于当前width值**。 |


> 注意，每一个outline的data子节点的width属性值，必须大于上一个data子节点的width属性值

举个例子

以下配置中data5.width > data4.width > data3.width > data2.width > data1.width

```Json
{    
  "outline1": {
    "type": "normal",
    "data":[   // data1
      {
        "color": "#5350DD",
        "width": 2    
      },
      {				// data2
        "color": "#B5FAA7",
        "width": 4  
      }
    ]
  },
  "outline2": {
    "type": "normal",
    "data":[	
      {				// data3
        "color": "#6E58F8",
        "width": 8
      },
      {				// data4
        "color": "#69F88C",
        "width": 10
      },
      {				// data5
        "color": "#FA55D8",
        "width": 12
      }
    ]
  }
}
```



## 示例

以如下花字效果为例

![icon.png|center|200x150](https://mts-sh-in.oss-cn-shanghai.aliyuncs.com/aliyun/1623237598027-958dda44-c407-4598-aacc-d8d85771c14d.png)

配置资源包下载地址：
[demo.zip](https://mts-sh-in.oss-cn-shanghai.aliyuncs.com/aliyun/effect2.zip)

该文件夹结构如下：

├── config.json

├── icon.png

└── lieheng.png


config.json

```Json
{
  "version": 1,
  "color":"#000000",
  "texture": "lieheng.png",
  "outline1": {
    "type": "normal",
    "data":[
      {
        "color": "#ffffff",
        "width": 8
      }
    ]
  },
  "outline2": {
    "type": "normal",
    "data":[
      {
        "color": "#000000",
        "width": 15
      }
    ]
  }
}

```


## SDK中使用花字

### iOS

调用`AliyunCaptionStickerController.setFontEffectTemplate`方法应用花字效果


### Android

调用`AliyunPasterControllerCompoundCaption.setFontEffectTemplate`方法应用花字效果


>[返回上一级](../README.md)
