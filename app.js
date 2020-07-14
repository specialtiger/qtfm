const {execSync} = require ('child_process')
const fs = require ('fs')
const sleep = (waitTimeInMs) => new Promise(resolve => setTimeout(resolve, waitTimeInMs))

let logs = []
let ui_content = ''

let docmd = cmd=>{
	let log = execSync(cmd)
	logs.push(log.toString())
}

let get_pos2 = (content,name)=>{
	content = content.toString()
	let re1 = new RegExp(`${name}[^>]*clickable="true"[^>]*bounds="\\[([^0]\\d+),(\\d+)\\]\\[(\\d+),(\\d+)\\]" />`, 'gm')
	let re2 = new RegExp(`${name}[^>]*enabled="true"[^>]*bounds="\\[([^0]\\d+),(\\d+)\\]\\[(\\d+),(\\d+)\\]" />`, 'gm')
	let bounds = re1.exec(content) || re2.exec(content)
	if (!bounds){
		return
	}
	let x = (parseInt(bounds[1])+parseInt(bounds[3]))/2
	let y = (parseInt(bounds[2])+parseInt(bounds[4]))/2
	return {x,y}
}

let tap = (name)=>{
	let pos = get_pos2(ui_content, name)
	if (!pos){
		logs.push(`Error: ${name} pos not found!`)
		return
	}
	console.log(name, pos)
	docmd(`adb -s 127.0.0.1:7555 shell input tap ${pos.x} ${pos.y}`)
}

let dump_ui = ()=>{
	docmd('adb -s 127.0.0.1:7555 shell uiautomator dump /data/local/tmp/uidump.xml')
	docmd('adb -s 127.0.0.1:7555 pull /data/local/tmp/uidump.xml')
	ui_content = fs.readFileSync('uidump.xml')
}

let test = ()=>{
	let s = 'text="CNR经典音乐广播" resource-id="fm.qingting.qtradio:id/name_TextView" class="android.widget.TextView" package="fm.qingting.qtradio" content-desc="" checkable="false" checked="false" clickable="false" enabled="true" focusable="false" focused="false" scrollable="false" long-clickable="false" password="false" selected="false" bounds="[161,459][285,520]" />'
	s += 'text="CNR经典音乐广播" resource-id="fm.qingting.qtradio:id/name_TextView" class="android.widget.TextView" package="fm.qingting.qtradio" content-desc="" checkable="false" checked="false" clickable="false" enabled="true" focusable="false" focused="false" scrollable="false" long-clickable="false" password="false" selected="false" bounds="[0,0][0,0]" />'
	console.log(get_pos2(s, 'CNR经典音乐广播'))
}

let main = async()=>{
	// 结束应用
	docmd('adb -s 127.0.0.1:7555 shell am force-stop fm.qingting.qtradio')
	docmd('adb -s 127.0.0.1:7555 shell am start -n fm.qingting.qtradio/.QTRadioActivity')
	await sleep(5000)
	// 点击我听2次，其中第1次点掉广告
	docmd('adb -s 127.0.0.1:7555 shell input tap 550 1420')
	await sleep(500)
	docmd('adb -s 127.0.0.1:7555 shell input tap 550 1420')
	dump_ui()
	// await sleep(1000)
	tap('CNR经典音乐广播')
	dump_ui()
	tap('批量下载')
	// dump_ui()
	// tap('昨天')
	docmd('adb -s 127.0.0.1:7555 shell input tap 608 173')
	// 下往上滑动
	docmd('adb -s 127.0.0.1:7555 shell input swipe 100 400 100 100  300')
	// 点击不眠经典
	docmd('adb -s 127.0.0.1:7555 shell input tap 326 1142')
	// // dump当前窗体所有元素,输出到手机的绝对路径
	// docmd('adb -s 127.0.0.1:7555 shell uiautomator dump /data/local/tmp/uidump.xml')
	// docmd('adb -s 127.0.0.1:7555 pull /data/local/tmp/uidump.xml')
	// let content = fs.readFileSync('uidump.xml')
	// let idx = content.indexOf('地球寻声')
	// if (idx != -1){
	// 	// 点击地球寻声
	// 	docmd('adb -s 127.0.0.1:7555 shell input tap 100 560')
	// }
	// else{

	// }

	
	// 点击下载
	docmd('adb -s 127.0.0.1:7555 shell input tap 500 1400')
	await sleep(30000)
	// 复制文件（adb-sync另行下载）
	docmd('./adb-sync -s 127.0.0.1:7555 --reverse /sdcard/QTDownloadRadio ./')
	await sleep(30000)
	// 结束应用
	docmd('adb -s 127.0.0.1:7555 shell am force-stop fm.qingting.qtradio')

	console.log(logs)
}
// test()

main()