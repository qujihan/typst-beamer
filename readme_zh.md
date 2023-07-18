# 用[Typst](https://typst.app/)写的Beamer
[中文](https://github.com/qujihan/typst-beamer/blob/main/readme_zh.md) | [English](github.com/qujihan/typst-beamer)

todo:[Bilibili]()

## 它是这个样子滴
![pic_1](./example/example_pic_1.png)
![pic_2](./example/example_pic_2.png)

也可以下载 [PDF](https://github.com/qujihan/typst-beamer/blob/main/example/example.pdf)看

## 如何编译example代码
**注意:** 如果是使用VSCode于Typst LSP插件的话可能会报错,这个是因为插件没更新,等插件更新就好了!
Linux/Macos
```
typst --root . c ./example/example.typ
```

Windows
```
typst --root . c .\example\example.typ
```

## 快速开始
```
#import "beamer.typ": beamer

#show: beamer.with(
  title: "Write a Beamer Template in Typst",
  author: "qujihan@github",
  date: "2023-07-17",
)

= First

== Second
...

```
` = ` 创建一个新分割页, ` == ` 创建一个新的页面, 每一个页上面的标题都是由它所在 ` = ` 决定的

## Thanks
[diapo](https://github.com/lvignoli/diapo) 
