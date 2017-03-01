/*
 * 智能机浏览器版本信息:
 *
 */

var browser = {
	versions : function() {
		var u = navigator.userAgent, app = navigator.appVersion;
		return {//移动终端浏览器版本信息
		   trident: u.indexOf('Trident') > -1, //IE内核
		   presto: u.indexOf('Presto') > -1, //opera内核
		   webKit: u.indexOf('AppleWebKit') > -1, //苹果、谷歌内核
		   gecko: u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1, //火狐内核
		   mobile: !!u.match(/AppleWebKit.*Mobile/i) || !!u.match(/MIDP|SymbianOS|NOKIA|SAMSUNG|LG|NEC|TCL|Alcatel|BIRD|DBTEL|Dopod|PHILIPS|HAIER|LENOVO|MOT-|Nokia|SonyEricsson|SIE-|Amoi|ZTE/), //是否为移动终端
		   ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
		   android: u.indexOf('Android') > -1 || u.indexOf('Linux') > -1, //android终端或者uc浏览器
		   iPhone: u.indexOf('iPhone') > -1 || u.indexOf('Mac') > -1, //是否为iPhone或者QQHD浏览器
		   iPad: u.indexOf('iPad') > -1, //是否iPad
		   webApp: u.indexOf('Safari') == -1 //是否web应该程序，没有头部与底部
		};
	}(),
	language : (navigator.browserLanguage || navigator.language).toLowerCase()
};
var touchEvents = {
	touchstart : "touchstart",
	touchmove : "touchmove",
	touchend : "touchend",

	/**
	 * @desc:判断是否pc设备，若是pc，需要更改touch事件为鼠标事件，否则默认触摸事件
	 */
	initTouchEvents : function() {
		if (browser.versions.mobile == false) {
			this.touchstart = "mousedown";
			this.touchmove = "mousemove";
			this.touchend = "mouseup";
		}
	}
};
touchEvents.initTouchEvents();
var tcStart=touchEvents.touchstart,tcEnd=touchEvents.touchend;


function winHide() {
	$("#popDiv").css('display','none');
}

function winShow(thisObj) {	
	$("#popDiv").show();
	var arr = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ];	
	$(".key").each(function(i) {
		var index = parseInt(Math.random() * arr.length);
		$(this).html(arr[index]);
		arr.splice(index, 1);
	});
	$(thisObj).val("");
    $(".key").off(tcStart);
    $(".key").on(tcStart,function(){
		$(this).addClass("keyPress");
		if($(thisObj).val().length>5){
			return;
		}
		$(thisObj).val($(thisObj).val() + "" + $(this).html());		
	});
	$(".key").off(tcEnd);
	$(".key").on(tcEnd,function(){
		$(".key").removeClass("keyPress");
	});
    delKey(thisObj);	
}


function delKey(delObj) {
    $("#delKey").off(tcEnd);
    $("#delKey").on(tcStart,function(){
    	$(this).addClass("keyDelPress");
    });
    $("#delKey").on(tcEnd,function(){
    	$(this).removeClass("keyDelPress");
        if ($(delObj).val() != "") {
    		$(delObj).val($(delObj).val().substring(0, $(delObj).val().length - 1));
    	}
    });
}
