# minieap的Openwrt Makefile
**需配合SDK使用，具备一定的Linux操作能力与交叉编译知识**  
~~_LUCI界面在做了在做了_~~

## 这个Makefile干了什么？
1. 拉取[minieap][1]的源码
2. 切换到PKG_VERSION指定的Tag
3. 用sed替换ICONV为GBCONV
4. make

## 配合SDK使用方法
1. 下载路由器对应OpenWRT版本的SDK
2. 进入SDK目录，执行命令获取Makefile
```shell
git clone https://github.com/BoringCat/minieap-openwrt.git package/minieap
```
3. 执行make命令
```shell
# 多线程编译
make defconfig
make package/minieap/compile -j$(grep processor /proc/cpuinfo | wc -l)
```
（上下二选一）
```shell
# 显示详情
make defconfig
make package/minieap/compile V=s
```
4. 找到ipk文件
```shell
find -name '*minieap*.ipk' -type f
```
5. 将ipk文件拷贝到路由器中，执行opkg安装

## 配合 toolchain 使用方法（需要交叉编译基础）
1. 找到toolchain的bin目录，设好PATH变量
2. 执行 `git clone https://github.com/updateing/minieap.git` 下载minieap源码
3. 进入minieap目录，根据项目[README文件][2]配置config.mk文件  
   - 注意！需配置CC := $(toolchain的gcc)
4. 将编译出来的minieap可执行文件拷贝到路由器上

## 认证方法
请参考[官方文档][2]和程序帮助`minieap -h`

### (附件) 广东技术师范大学6.84版本锐捷认证方法(2019-10-11)
1. 由于服务器设定的“用户服务”为中文，需要将配置文件文件编码转换为GBK
```shell
$ file /etc/minieap.conf
/etc/minieap.conf.gpk: ISO-8859 text
```
2. dhcp-type选项需为1(二次认证)，否则无法通过动态IP验证
3. 服务名需要使用客户端查看，Linux客户端查看比较方便 :)
4. **！！若不正确使用路由器影响到校园网，将按照学生手册处理！！**
5. **！！若下联设备触犯网络安全法以及被检测到危险的网络行为，认证账号人需付相应的民事/刑事责任。！！**

[1]: https://github.com/updateing/minieap
[2]: https://github.com/updateing/minieap/blob/master/README.md