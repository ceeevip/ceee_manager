# ceee_manager

# 国际化
https://www.jianshu.com/p/d35db955e331

# 创建创建支持其他平台

```
flutter create --platforms=windows,macos,linux .
```

# Feature
[ ] 放开 album image url
[ ] auth 管理，这个token 或者用户名密码需要更新
[ ] 对alist 和 local 和百度盘进行可修改。

# web 两种打包方式
```
# 如果单独部署，那么直接使用 
flutter build web --release
# 如果需要在CeeeSource工程中集成那么执行
flutter build web --release   --base-href "/admin/"
```
