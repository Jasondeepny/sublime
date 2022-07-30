#!/bin/bash
echo -e "温馨提示：若电视执行脚本后异常，恢复方法“关电视，拔电源，等十秒后，然后插电源，同时按住遥控器主页键和菜单键不放，开电视，然后进入recovery，清除数据后重启，就会恢复原厂设置了。\n打开设置-关于-产品型号，对着产品型号连点七次，开发模式就开启了，之后返回账号与安全，找到adb调试，并打开，接着进入网络设置，记住自己的IP地址；"
echo -e "语音搜索西游记，播放，安装云视听极光插件，腾讯视频必须，否则没法播放\n语音搜索汪汪队，播放，安装播放插件\n按回车键继续："
read x

echo "请输入电视IP地址，按回车键确认，此时电视会提示是否连接电脑，选择确认即可；"

read ip
##只到连接成功
failString="failed to connect to"
flag=0
while(($flag<1))
do
  result=$(./adb connect $ip)
  contains=$(echo $result | grep "${failString}")
  if [[ "$contains" != "" ]]
  then
    flag=0;
    echo $result
  else
    flag=1;
    echo "success"
  fi
done

intallResult="success"
echo "正在安装氧气桌面极速版"
intallResult=$(./adb install ./launcher148.apk)
echo $intallResult

contains=$(echo $intallResult | grep "success")
if [[ "$contains" != "" ]]
then
  echo "安装失败，请重新执行脚本"
else
  echo "正在精简中，耐心等待。。。"
  
  ./adb shell pm uninstall --user 0 com.xiaomi.mitv.upgrade
  ./adb shell pm uninstall --user 0 com.xiaomi.account
  ./adb shell pm uninstall --user 0 com.droidlogic
  ./adb shell pm uninstall --user 0 com.xiaomi.mitv.payment
  ./adb shell pm uninstall --user 0 com.xiaomi.upnp
  ./adb shell pm uninstall --user 0 com.xiaomi.mitv.pay
  ./adb shell pm uninstall --user 0 com.xiaomi.tv.appupgrade
  ./adb shell pm uninstall --user 0 com.android.vpndialogs
  ./adb shell pm uninstall --user 0 com.xiaomi.mitv.remotecontroller.service
  ./adb shell pm uninstall --user 0 com.xiaomi.mitv.tvpush.tvpushservice
  ./adb shell pm uninstall --user 0 com.xiaomi.account.auth
  ./adb shell pm uninstall --user 0 com.jiajia.yundonghui.mitv
  ./adb shell pm uninstall --user 0 com.xiaomi.statistic
  ./adb shell pm uninstall --user 0 com.mipay.wallet.tv
  ./adb shell pm uninstall --user 0 com.xiaomi.smarthome.tv
  ./adb shell pm uninstall --user 0 com.xiaomi.mitv.appstore
  ./adb shell pm uninstall --user 0 com.xiaomi.milink.udt
  ./adb shell pm uninstall --user 0 com.mi.miplay.mitvupnpsink
  ./adb shell pm uninstall --user 0 com.mi.umifrontend
  ./adb shell pm uninstall --user 0 com.miui.tv.analytics
  ./adb shell pm uninstall --user 0 com.xiaomi.dlnatvservice
  ./adb shell pm uninstall --user 0 com.xiaomi.mitv.assistant.manual
  ./adb shell pm uninstall --user 0 com.xiaomi.mitv.shop
  ./adb shell pm uninstall --user 0 com.xiaomi.devicereport
  ./adb shell pm uninstall --user 0 com.xiaomi.mibox.lockscreen
  ./adb shell pm uninstall --user 0 com.duokan.airkan.tvbox
  ./adb shell pm uninstall --user 0 com.mi.umi
  ./adb shell pm uninstall --user 0 com.xiaomi.gamecenter.sdk.service.mibo
  ./adb shell pm uninstall --user 0 com.android.proxyhandler
  ./adb shell pm uninstall --user 0 com.android.statementservice
  ./adb shell pm uninstall --user 0 com.xiaomi.mitv.advertis
  ./adb shell pm uninstall --user 0 com.android.location.fused
  ./adb shell pm uninstall --user 0 mitv.service
  ./adb shell pm uninstall --user 0 com.xiaomi.mitv.service
  ./adb shell pm uninstall --user 0 com.xiaomi.screenrecorder
  ./adb shell pm uninstall --user 0 com.mitv.screensaver
  ./adb shell pm uninstall --user 0 com.ktcp.tvvideo
  ./adb shell pm uninstall --user 0 com.miui.systemAdSolution
  ./adb shell pm uninstall --user 0 com.pptv.tvsports.preinstall
  ./adb shell pm uninstall --user 0 com.duokan.videodaily
  ./adb shell pm uninstall --user 0 com.pplive.atv
  ./adb shell pm uninstall --user 0 com.xiaomi.mitv.advertise
  ./adb shell pm uninstall --user 0 com.mitv.tvhome
  
  echo "精简完成，即将重启！"
  sleep 10
  ./adb reboot
fi
