adb shell am start -n fm.qingting.qtradio/fm.qingting.qtradio.QTRadioActivity

am start -n fm.qingting.qtradio/.QTRadioActivity t35

adb shell dumpsys activity activities

dumpsys activity top | grep ACTIVITY

# 点击(540, 1900)位置，启动录音
os.system('adb shell input tap 540 1900')

time.sleep(1000)

# 再次点击(540, 1900)位置，停止录音
os.system('adb shell input tap 540 1900')

# 获取录音
os.system('adb pull /storage/sdcard0/Sounds/新录音\ 001.m4a')


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
