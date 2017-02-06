# 一、前言
周末在家闲着无聊，尝试使用一下Ghost博客系统。顺手写个快速搭建脚本，仅供大家使用。  

# 二、准备材料
* SSH软件（个人使用Xshell）。
* 零摄氏度以下瓶装可口可乐（不要问我为什么是可口可乐）。
* 之前想看又来得及看的电视剧、电影、综艺一集（一期）。

# 三、安装前提
* 本脚本支持Ubuntu 16.04 x64以上操作系统（其他版本Ubuntu没有测试，讲道理应该是可以哒）。
* 本脚本本人测试环境是阿里云大陆，讲道理其他地域或者提供商也是可以哒。
* 使用前请现将自己的域名解析到对应的IP上。
* 脚本运行开始需要输入一个主机名，主机名请输入你要使用的博客域名。

# 四、使用方法

获取代码并执行安装！
```bash
apt-get install -y git
git clone https://github.com/ryanwschina/InstallGhost.git
cd InstallGhost
bash InstallGhost.sh
```

千万不要关闭SSH软件，访问自己博客域名测试一下是否能够打开，不能打开的话你就可以心里默念一句“卧槽”给我（反正我也听不到）。  
如果网页可以打开那就说明Ghost已经安装成功啦。在SSH软件界面按Ctrl + C，然后依次执行以下代码。

```bash
screen -S ghost
npm start --production
```

执行完上述代码之后就可以保证Ghost始终在线啦。