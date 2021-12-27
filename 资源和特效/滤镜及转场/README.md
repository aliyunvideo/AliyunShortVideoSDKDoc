  
# 特效自定义对外文档

短视频SDK提供了自定义特效能力，您可以基于我们的通用特效配置文件，通过自定义OpenGL ES Shader（OpenGL ES 3.0语法），实现想要的滤镜与转场效果。有关OpenGL ES的知识点和解释并不属于本篇文档的范畴，我们默认您已经对OpenGL ES及其Shader Language有所了解。

# 通用特效配置文件

一个特效资源包文件夹，包含了一个名为`config.json`的通用特效配置文件以及一些图片素材。您可以通过sdk提供的接口，传入特效资源包文件夹目录，应用一个特效效果。

通用特效配置文件采用JSON格式，描述了完整的渲染过程。
整体结构上分为两个层级，第一层级描述了特效基本信息，第二层用节点树描述了特效实现细节。

## 一、特效基本信息

特效基本信息包含以下字段：

| 字段 | 说明 |
| -------- | --------|
| name | 特效名称 |
| module | 模块标识，该字段必须是`ALIVC_GECF` |
| version | 版本号，当前版本为1 |
| type | 特效类型，目前支持滤镜为1，转场为2 |
| nodeTree | 节点树，用于描述特效实现细节，下文详细说明 |

### 示例1

一个典型的配置文件格式如下所示：

**Intense滤镜**

```JSON
{
    "name": "Intense",
    "module": "ALIVC_GECF",
    "version": 1,
    "type": 1,
    "nodeTree": [
        {
            "nodeId": 0,
            "name": "Intense",
            "fragment": "/** ...... */",
            "textures": [
                {
                    "name": "inputImageTexture",
                    "srcType": "INPUT_NODE",
                    "nodeId": 0
                },
                {
                    "name": "inputImageTexture2",
                    "srcType": "IMAGE",
                    "path": "color.png"
                }
            ]
        }
    ]
}
```

## 二、节点树

节点树`nodeTree`用于描述一个渲染流程，包含了一个或多个节点。在短视频SDK中，渲染流程如图所示：
![1579421044372-c4926531-f4d4-4b8a-8a4c-c0df48080100.png](https://intranetproxy.alipay.com/skylark/lark/0/2020/png/37085/1581408810463-f2653f96-dccc-42f2-adb9-ebc974738b4b.png)


从上图可以看到，渲染过程被抽象为一些列节点组成的树状结构。
输入节点INPUT_NODE代表原始输入源。在录制场景下，输入节点是摄像头采集的图像数据流。在编辑场景下，输入节点是是当前播放视频流。在设计上，输入节点可以是多个。例如转场过程中，需要对前后两个视频做效果变换。此时，前一个视频是INPUT_NODE0，后一个是INPUT_NODE1。
输出节点OUTPUT_NODE代表渲染后的视频流。在预览模式下，输出节点输出到屏幕，在合成模式下，输出节点输出到编码器编码。
中间的节点树部分即对应配置文件中的`nodeTree`字段。一个节点树可以包含一个或多个渲染节点。可以看到，整个渲染配置文件的关键就是有关节点的配置。
 
### 节点

节点字段描述了整个渲染流程中，某一次绘制过程中的相关配置。这里的配置包含了自定义特效所必须的着色器代码以及相关参数描述。
节点包含有以下字段：

| 字段 | 说明 |
| -------- | --------|
| nodeId | 节点id，用于标识当前节点 |
| name | 节点名 |
| vertex | 顶点着色器代码 |
| vertexPath |顶点着色器代码所在文件路径 |
| attributes | attributes列表 |
| fragment | 片段着色器代码 |
| fragmentPath | 片段着色器代码所在文件路径 |
| textures | 纹理列表 |
| params | 参数列表 |

#### 示例2

**Translate转场**

```JSON
{
    "name": "Translate",
    "module": "ALIVC_GECF",
    "version": 1,
    "type": 2,
    "nodeTree": [
        {
            "nodeId": 0,
            "name": "Translate",
            "vertex": "/** ...... */",
            "attributes": [
                {
                    "name": "a_position",
                    "type": "POSITION"
                },
                {
                    "name": "a_texcoord",
                    "type": "TEXTURECOORD"
                }
            ],
            "fragment": "/** ...... */",
            "textures": [
                {
                    "name": "RACE_Tex0",
                    "srcType": "INPUT_NODE",
                    "nodeId": 0
                },
                {
                    "name": "RACE_Tex1",
                    "srcType": "INPUT_NODE",
                    "nodeId": 1
                }
            ],
            "params": [
                {
                    "name": "direction",
                    "type": "INT",
                    "value": [
                        0
                    ],
                    "maxValue": [
                        3
                    ],
                    "minValue": [
                        0
                    ]
                }
            ]
        }
    ]
}
```

下面详细解释各个字段的含义：

#### vertex字段

顶点着色器代码。该字段作用与vertexPath字段相同，声明其中任意一个即可。
- 该字段可以不写，如果不填写，SDK会提供默认实现：

```JSON
attribute vec4 position;
attribute vec4 inputTextureCoordinate;
varying vec2 textureCoordinate;
void main()
{
    gl_Position = position;
    textureCoordinate = inputTextureCoordinate.xy;
}
```

#### vertexPath字段
顶点着色器代码文件所在路径。该字段作用与vertex字段相同，声明其中任意一个即可。

#### attributes字段

attributes列表，该字段用于声明顶点着色中attribute参数名`name`和类型`type`。
所有`type`类型如下：
| 类型 | 说明 |
| -------- | --------|
| POSITION | 顶点坐标 |
| TEXTURECOORD | 纹理坐标 |

- 该字段可以不写，如果不填写，SDK会提供默认实现：

```JSON
[
    {
        "name": "position",
        "type": "POSITION"
    },
    {
        "name": "inputTextureCoordinate",
        "type": "TEXTURECOORD"
    }
]
 ```

#### fragment字段

片段着色器代码。该字段作用与fragmentPath字段相同，声明其中任意一个即可。

#### fragmentPath字段

片段着色器代码文件所在路径。该字段作用与fragment字段相同，声明其中任意一个即可。

#### textures字段

用于描述片段着色器中`sampler2D`纹理参数的相关属性：
| 字段 | 说明 |
| -------- | --------|
| name | 纹理名 |
| srcType | 纹理数据源类型 |
| nodeId | 节点id，纹理数据源为CUSTOM_NODE和INPUT_NODES时需要填写 |
| path | 资源文件路径，纹理数据源为IMAGE时需要填写 |

 纹理数据源类型(srcType)
`srcType`纹理数据源代表待绘制的纹理数据从哪里获取，支持以下类型：

| 类型 | 说明 |
| -------- | --------|
| IMAGE | 当前纹理来自资源图片，该类型需要同时声明`path`字段，并且把图片文件放到资源包中 |
| INPUT_NODE | 当前纹理来自输入节点传入的图像数据，该类型需要同时声明`nodeId`字段 |
| CUSTOM_NODE | 当前纹理来自自定义节点处理后的图像数据，该类型需要同时声明`nodeId`字段 |

- 当`srcType`声明为`INPUT_NODE`时，`nodeId`字段不能随意填写。滤镜场景下为`0`。转场场景下前一个视频流`nodeId`为`0`，后一个视频流`nodeId`为`1`。

上述示例1(Intense滤镜)中声明了两个纹理`inputImageTexture`和`inputImageTexture2`，他们的输入源来自输入节点`INPUT_NODE0`和图片文件`color.png`。因此，其描述如下所示：

```JSON
"textures": [
    {
        "name": "inputImageTexture",
        "srcType": "INPUT_NODE",
        "nodeId": 0
    },
    {
        "name": "inputImageTexture2",
        "srcType": "IMAGE",
        "path": "color.png"
    }
]
```

上述转场示例2(Translate转场)中声明了两个纹理`RACE_Tex0`和`RACE_Tex1`，他们的输入源来自输入节点`INPUT_NODE0`和`INPUT_NOD1`。因此，其描述如下所示：

```JSON
"textures": [
    {
        "name": "RACE_Tex0",
        "srcType": "INPUT_NODE",
        "nodeId": 0
    },
    {
        "name": "RACE_Tex1",
        "srcType": "INPUT_NODE",
        "nodeId": 1
    }
]
```

#### params字段

用于描述片段着色器中`uniform`参数的相关属性：

| 字段 | 说明 |
| -------- | --------|
| name | 参数名 |
| type | 参数类型 |
| value | 参数值 |
| maxValue | 参数最大值 |
| minValue | 参数最小值 |


参数类型(type)
支持以下参数类型：

| 类型 | 参数值举例 |
| -------- | --------|
| INT | [1] |
| FLOAT | [-2.0] |
| VEC2I | [3, 2] |
| VEC3I | [1, 2, 3] |
| VEC4I | [4, 3, 2, 1] |
| VEC2F | [-1.0, 1.0] |
| VEC3F | [0.5, 0.5, 0.5] |
| VEC4F | [1.0, -1.0, 1.0, -1.0] |
| MAT3F | [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0] |
| MAT4F | [1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0] |

上述转场示例2(Translate转场)中声明了一个名为`direction`的`uniform`变量，其类型为`INT`，最大值为3，最小值为0，其描述如下所示：

```JSON
"params": [
    {
        "name": "direction",
        "type": "INT",
        "value": [
            0
        ],
        "maxValue": [
            3
        ],
        "minValue": [
            0
        ]
    }
]
```

## 内建变量

我们在SDK中内置了一些变量，您可以在shader中直接声明，目前暴露以下内建变量：
```
uniform highp float BUILTIN_PROGRESS;	// 转场进度：0~1
uniform highp float BUILTIN_WIDTH;			// 图像宽
uniform highp float BUILTIN_HEIGHT;			// 图像高

```


# 在SDK中使用特效

## 一、创建特效对象

### 滤镜
**iOS**
通过`AliyunEffectFilter`的`- (instancetype)initWithFile:(NSString *)path;`方法创建对象，`path`参数为特效文件夹路径。
**Android**
通过`EffectFilter(String path)`创建对象，`path`参数为特效文件夹路径。

### 转场
**iOS**
通过`AliyunTransitionEffect`的`-(instancetype)initWithPath:(NSString *)path;`方法创建对象，`path`参数为特效文件夹路径。
**Android**
通过`TransitionBase(String path)`创建对象，`path`参数为特效文件夹路径。

## 二、应用特效

### 滤镜

**iOS**
调用`- (int)applyAnimationFilter:(AliyunEffectFilter *)filter;`方法应用特效。

**Android**
调用`int addAnimationFilter(EffectFilter filter);`方法应用特效。

### 转场

**iOS**
调用`- (int)applyTransition:(AliyunTransitionEffect *)transition atIndex:(int)clipIdx;`方法应用转场。

**Android**
调用`int setTransition(int index, TransitionBase transition);`方法应用转场。

## 三、更新特效参数

初始化后的特效对象内可以获取到描述特效配置的`AliyunEffectConfig`对象，该对象内部结构与特效配置文件的结构相对应。
如果某一个自定义特效配置文件里包含有`params字段`，对应在代码中可以通过`AliyunEffectConfig`-> `nodeTree` -> `params`获取到`AliyunParam`对象。`AliyunParam`对象中的`value`字段就是当前参数的值。

更新参数需要以下两步：

1. 通过`AliyunValue`对象提供的update设值方法更新参数值。
2. 调用特效更新方法更新参数，具体特效更新方法如下：

### 滤镜

**iOS**
调用`- (int)updateAnimationFilter:(AliyunEffectFilter *)filter;`方法更新特效。

**Android**
调用`int updateAnimationFilter(EffectFilter filter);`方法更新特效。

### 转场

**iOS**
调用`-(int)updateTransition:(AliyunTransitionEffect *)transition atIndex:(int)clipIdx;`方法更新特效。

**Android**
调用`int updateTransition(int clipIndex, TransitionBase transitionBase);`方法更新特效。


>[返回上一级](../README.md)