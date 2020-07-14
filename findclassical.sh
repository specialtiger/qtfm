# am start -n fm.qingting.qtradio/.QTRadioActivity t35

adb shell dumpsys activity activities

dumpsys activity top | grep ACTIVITY

adb -s 127.0.0.1:7555 shell am start -n fm.qingting.qtradio/.QTRadioActivity
adb -s 127.0.0.1:7555 exec-out screencap -p > sc.png
# dump当前窗体所有元素,输出到手机的绝对路径
adb -s 127.0.0.1:7555 shell uiautomator dump /data/local/tmp/uidump.xml
adb -s 127.0.0.1:7555 pull /data/local/tmp/uidump.xml
# 点击地球寻声
adb -s 127.0.0.1:7555 shell input tap 100 560
# 点击下载
adb -s 127.0.0.1:7555 shell input tap 500 1400
# 结束应用
adb -s 127.0.0.1:7555 shell am force-stop fm.qingting.qtradio

# 点击(540, 1900)位置，启动录音
os.system('adb shell input tap 540 1900')

time.sleep(1000)

# 再次点击(540, 1900)位置，停止录音
os.system('adb shell input tap 540 1900')

# 获取录音
os.system('adb pull /storage/sdcard0/Sounds/新录音\ 001.m4a')

1.模拟点击

adb shell input tap 100 100
2.滑动

adb shell input swipe x1 y1 x2 y2 
adb input touchscreen swipe x1 y1 x2 y2 100

adb shell input swipe 100 100 400 100  300 #左往右
adb shell input swipe 400 100 100 100  300 #右往左
adb shell input swipe 100 100 100 400  300 #上往下
adb shell input swipe 100 400 100 100  300 #下往上
adb shell input swipe 100 100 400 400  300 #上往下斜
adb shell input swipe 400 400 100 100  300 #下往上斜


1、微信主界面Activity和朋友圈Activity：
com.tencent.mm/.ui.LauncherUI
com.tencent.mm/.plugin.sns.ui.SnsTimeLineUI

2、UC浏览器主界面Activity：
com.UCMobile/com.uc.browser.InnerUCMobile

3、QQ聊天主界面和QQ空间Activity：
com.tencent.mobileqq/.activity.SplashActivity
com.tencent.mobileqq/cooperation.qzone.QzoneFeedsPluginProxyActivity

4、支付宝首页Activity：
com.eg.android.AlipayGphone/.AlipayLogin

5、淘宝底部菜单对应的首页、微淘、消息、购物车、我的淘宝不是同一个Activity，它们依次是：
首页com.taobao.taobao/com.taobao.tao.homepage.MainActivity3
微淘com.taobao.taobao/com.taobao.wetao.home.WeTaoMainActivity
消息com.taobao.taobao/com.taobao.message.category.MsgCenterCategoryTabActivity
购物车com.taobao.taobao/com.taobao.android.trade.cart.CartTabActivity
我的淘宝com.taobao.taobao/com.taobao.tao.mytaobao.MyTaoBaoActivity
