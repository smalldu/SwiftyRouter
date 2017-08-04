# SwiftyRouter


项目讲解地址:http://www.jianshu.com/p/4ba2db91030b

## Usage

直接将Router.swift 拖进项目即可。建议下载demo看下

```
Router.open(RouterPath.avc)
```

```
let demo = Demo(name: "RVC title", id: 1)
Router.open(RouterPath.rvc(demo))
```

或者present

```
Router.open(RouterPath.bvc("BVC title"), present: true)
```


