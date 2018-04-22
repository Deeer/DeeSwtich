# 简单实现类系统UISwitch 控件


## 控件分为四个层次 

- UIControl 层： 接收处理点击事件
- backLayer  ：背景层，随开关按钮改变背景层和边框颜色
- fillLayer  ：填充层，随开关按钮改变scall从而起到过渡作用
- thumbLayer ：按钮层，实际也是也layer属性的层，用于添加形变和位移

![](https://ws1.sinaimg.cn/large/006tNc79gy1fqly3hnyy3j319a0tiwhw.jpg)

效果图：
![](https://ws4.sinaimg.cn/large/006tNc79gy1fqly5ib33jg306w0cnjuk.gif)

