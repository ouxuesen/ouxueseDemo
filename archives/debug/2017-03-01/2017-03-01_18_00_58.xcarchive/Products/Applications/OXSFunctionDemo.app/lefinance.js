
function setStorage(key,data,type)
{	
	if(data == "" || data == null)
		return;
	
	if(type == "json" && typeof(data) == "object")
		$.cookie(key,EnChTo(16,encodeURI(JSON.stringify(data))));
	else if(type != "json")
		$.cookie(key,EnChTo(16,encodeURI(data)));
}

function getStorage(key,type)
{	
	var data = $.cookie(key);

	if(data == null || data == 'null')
		return null;
	
	data = DeChTo(16,data);	
	
	data = decodeURI(data);
	
	if(type == "json")	
		return JSON.parse(data.substring(0,data.length-2)+"}");
	else 
		return data.substring(0,data.length-1);
}

function removeStorage(key)
{
	return $.cookie(key,null);
}

loginInfo = getStorage("loginInfo","json");
payInfo = getStorage("payInfo","json");

financeDomain = "jrdev.letv.com";
financeSSLDomain = "jrdev.letv.com";

//financeSSLDomain = "jr.letv.com";
//financeDomain = "jr.letv.com";

//financeHtmlDomain = "jr.letv.com";
financeHtmlDomain = "jrdev.letv.com";
subList = 'leplatform';


function getChannel(){
    var ua = window.navigator.userAgent.toLowerCase();
    if(ua.match(/MicroMessenger/i) == 'micromessenger'){
        return 'weChat';
    }else if(/(iPhone|iPad|iPod|iOS|BlackBerry|IEMobile|Android)/i.test(navigator.userAgent)){
    	return 'mobile';       
    }else{
    	return 'web';
    }
}

function GetQueryString(name)
{
	var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
	var r = window.location.search.substr(1).match(reg);
	if(r!=null)return  r[2]; return null;
}

var channel = getChannel();
var channelId = GetQueryString('openId');
if(channelId == null)
	channelId = getStorage('openId');
else
	setStorage('openId',channelId);

if(channel == "weChat" && channelId == null)
{
	location.href = "http://"+financeDomain+"/leFinanceTrade/oauth.do";
}

function loginout()
{
	$.post("http://"+financeDomain+"/leFinanceTrade/logout",{"userId":loginInfo.userId,"token":loginInfo.token,"channel": getChannel()},function(data){

		removeStorage("loginInfo");
		removeStorage("payInfo");

		loginInfo = null;
		payInfo=null;

		if(data.success == 1)
			redirect('http://sso.letv.com/user/loginout?next_action=http%3A%2F%2F'+financeHtmlDomain+'%2Flefinance%2Findex.html');
		
		if(data.code == 2025)
		{
			redirect('index.html')
		}
		
	},"json");
}

function clearCookie(){ 
	deleteCookie('ssouid');
	deleteCookie('sso_picture');
	deleteCookie('sso_nickname');
	deleteCookie('sso_tk');
} 

function deleteCookie(name) {
	var date=new Date();
	date.setTime(date.getTime()-10000);
	document.cookie=name+"=; expire="+date.toGMTString()+"; path=/;domain=.letv.com";
}; 

function checkBankList(bankID)
{
	switch(bankID)
	{
	case "CMB":
	case "PSBC":
		return false;
	case "招商银行":
	case "邮储银行":
		return false;
	default:
		return true;
	}
}

function convertCartType(type)
{
	switch(parseInt(type))
	{
	case 0:
		return "信用卡";
	case 1:
		return "借记卡";
	case 2:
		return "贷记卡";
	case 3:
		return "预付卡";
	case 4:
		return "虚拟卡";
	case 5:
		return "其他";
	case 6:
		return "其他";
	case 7:
		return "其他";
	case 8:
		return "其他";
	default:
		return "其他";
	}
}

var Wi = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1 ];    // 加权因子   
var ValideCode = [ 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2 ];            // 身份证验证位值.10代表X   
function IdentityCodeValid(idCard) { 

    var re = /^(\d{15}$|^\d{18}$|^\d{17}(\d|X|x))$/ 

	if (!re.test(idCard)){   
	   	return false;  
	} 
	else{
		return true;
	}


	idCard = trim(idCard.replace(/ /g, ""));               //去掉字符串头尾空格                     
	if (idCard.length == 15) {   
		return isValidityBrithBy15IdCard(idCard);       //进行15位身份证的验证
	} else if (idCard.length == 18) {   
		var a_idCard = idCard.split("");                // 得到身份证数组   
		if(isValidityBrithBy18IdCard(idCard)&&isTrueValidateCodeBy18IdCard(a_idCard)){   //进行18位身份证的基本验证和第18位的验证
			return true;   
		}else {   
			return false;   
		}   
	} else {   
		return false;   
	}   
}   
/**  
* 判断身份证号码为18位时最后的验证位是否正确  
* @param a_idCard 身份证号码数组  
* @return  
*/  
function isTrueValidateCodeBy18IdCard(a_idCard) {   
	var sum = 0;                             // 声明加权求和变量   
	if (a_idCard[17].toLowerCase() == 'x') {   
		a_idCard[17] = 10;                    // 将最后位为x的验证码替换为10方便后续操作   
	}   
	for ( var i = 0; i < 17; i++) {   
		sum += Wi[i] * a_idCard[i];            // 加权求和   
	}   
	valCodePosition = sum % 11;                // 得到验证码所位置   
	if (a_idCard[17] == ValideCode[valCodePosition]) {   
		return true;   
	} else {   
		return false;   
	}   
}   
/**  
* 验证18位数身份证号码中的生日是否是有效生日  
* @param idCard 18位书身份证字符串  
* @return  
*/  
function isValidityBrithBy18IdCard(idCard18){   
	var year =  idCard18.substring(6,10);   
	var month = idCard18.substring(10,12);   
	var day = idCard18.substring(12,14);   
	var temp_date = new Date(year,parseFloat(month)-1,parseFloat(day));   
	// 这里用getFullYear()获取年份，避免千年虫问题   
	if(temp_date.getFullYear()!=parseFloat(year)   
		||temp_date.getMonth()!=parseFloat(month)-1   
	||temp_date.getDate()!=parseFloat(day)){   
		return false;   
	}else{   
		return true;   
	}   
}   
/**  
* 验证15位数身份证号码中的生日是否是有效生日  
* @param idCard15 15位书身份证字符串  
* @return  
*/  
function isValidityBrithBy15IdCard(idCard15){   
	var year =  idCard15.substring(6,8);   
	var month = idCard15.substring(8,10);   
	var day = idCard15.substring(10,12);   
	var temp_date = new Date(year,parseFloat(month)-1,parseFloat(day));   
	// 对于老身份证中的你年龄则不需考虑千年虫问题而使用getYear()方法   
	if(temp_date.getYear()!=parseFloat(year)   
		||temp_date.getMonth()!=parseFloat(month)-1   
	||temp_date.getDate()!=parseFloat(day)){   
		return false;   
	}else{   
		return true;   
	}   
}   
//去掉字符串头尾空格   
function trim(str) {   
	return str.replace(/(^\s*)|(\s*$)/g, "");   
}  


function bankLuhmCheck(bankno){

	if(bankno != null && bankno != "" && bankno)
		return true;
	else
		return false;


	var lastNum=bankno.substr(bankno.length-1,1);//取出最后一位（与luhm进行比较）
 
	var first15Num=bankno.substr(0,bankno.length-1);//前15或18位
	var newArr=new Array();
	for(var i=first15Num.length-1;i>-1;i--){    //前15或18位倒序存进数组
		newArr.push(first15Num.substr(i,1));
	}
	var arrJiShu=new Array();  //奇数位*2的积 <9
	var arrJiShu2=new Array(); //奇数位*2的积 >9
     
	var arrOuShu=new Array();  //偶数位数组
	for(var j=0;j<newArr.length;j++){
		if((j+1)%2==1){//奇数位
			if(parseInt(newArr[j])*2<9)
				arrJiShu.push(parseInt(newArr[j])*2);
			else
				arrJiShu2.push(parseInt(newArr[j])*2);
		}
		else //偶数位
			arrOuShu.push(newArr[j]);
	}
     
	var jishu_child1=new Array();//奇数位*2 >9 的分割之后的数组个位数
	var jishu_child2=new Array();//奇数位*2 >9 的分割之后的数组十位数
	for(var h=0;h<arrJiShu2.length;h++){
		jishu_child1.push(parseInt(arrJiShu2[h])%10);
		jishu_child2.push(parseInt(arrJiShu2[h])/10);
	}        
     
	var sumJiShu=0; //奇数位*2 < 9 的数组之和
	var sumOuShu=0; //偶数位数组之和
	var sumJiShuChild1=0; //奇数位*2 >9 的分割之后的数组个位数之和
	var sumJiShuChild2=0; //奇数位*2 >9 的分割之后的数组十位数之和
	var sumTotal=0;
	for(var m=0;m<arrJiShu.length;m++){
		sumJiShu=sumJiShu+parseInt(arrJiShu[m]);
	}
     
	for(var n=0;n<arrOuShu.length;n++){
		sumOuShu=sumOuShu+parseInt(arrOuShu[n]);
	}
     
	for(var p=0;p<jishu_child1.length;p++){
		sumJiShuChild1=sumJiShuChild1+parseInt(jishu_child1[p]);
		sumJiShuChild2=sumJiShuChild2+parseInt(jishu_child2[p]);
	}      
	//计算总和
	sumTotal=parseInt(sumJiShu)+parseInt(sumOuShu)+parseInt(sumJiShuChild1)+parseInt(sumJiShuChild2);
     
	//计算Luhm值
	var k= parseInt(sumTotal)%10==0?10:parseInt(sumTotal)%10;        
	var luhm= 10-k;
     
	if(lastNum==luhm){
		//$("#banknoInfo").html("Luhm验证通过");
		return true;
	}
	else{
		//$("#banknoInfo").html("银行卡号必须符合Luhm校验");
		return false;
	}        
}

function checkMobile(str) {
	var re = /^1\d{10}$/
	if (re.test(str)) {
		return true;
	} else {
		return false;
	}
}

function checkBankInfo()
{
	
	if(payInfo.bankCardNo == null || payInfo.bankCardNo.length == 0 || !payInfo.bankCardNo)
		return false;
	
	return true;
}

function FormatDate (strTime) {
	if(strTime == null)
		return "";
	
	var newTime=strTime.toString().split(" ");
	return newTime[0];
}


function formatNumber(n){
	if(parseInt(n)>0){
		var b=parseInt(n).toString();
		var len=b.length;
		if(len<=3){return b;} 
		var r=len%3;  
		return r>0?b.slice(0,r)+","+b.slice(r,len).match(/\d{3}/g).join(","):b.slice(r,len).match(/\d{3}/g).join(",");
	}else{
		return 0;
	}			  
}

function showLoading(){
	var htmlstr='<div id="dialogLoading"><div class="blackCover"></div><div class="loadingBox"><div class="loading"><img src="images/loading.gif" width="32" height="32"/></div><p>进行中，请稍等...</p></div></div>';
	if($("#dialogLoading").length>0){
		$("#dialogLoading").remove();
	}else{
		$("body").append(htmlstr);
	}
}
	
function hideLoading(){
	$("#dialogLoading").remove();
}

function redirect(url)
{
	if (/MSIE (\d+\.\d+);/.test(navigator.userAgent)){ 
	   var referLink = document.createElement('a');
	   referLink.href = url; 
	   document.body.appendChild(referLink);
	   referLink.click();
	}else {
	   location.href = url; 
	}
}

function historyback()
{
	location.href = document.referrer;
}

function tabMenu(){	
	$(".pro_h2>a").each(function(){
		if($(this).attr("class")=="downIcon"){
			$(this).parent("h2").next().css("display","none");
		}
	});
	var _this=$(".tabMenu .pro_h2");
	_this.off("click");		
	_this.on('click',function(){
		if($(this).children("a").attr("class")=="upIcon"){
			$(this).next().slideUp(100);
			$(this).children("a").attr("class","downIcon");
			return false;
		}else if($(this).children("a").attr("class")=="downIcon"){
			$(".tabMenu .pro_cnt").slideUp(100);
			$(".tabMenu .pro_h2>a").attr("class","downIcon");
			$(this).next().slideDown(100,function(){
				$(document).scrollTop($(document).scrollTop()+$(this).height());
			});	
			$(this).children("a").attr("class","upIcon");
			return false;
		}
	});
}

function resetPwd(bandingurl,url)
{
	setStorage('bandingurl',bandingurl);
	redirect(url);
}

function hideProName(name){
	if(name&&name.length>16&&$(document).width()<330){
		return name.substring(0,16)+"...";
	}else if(name&&name.length>22&&$(document).width()<440){
		return name.substring(0,22)+"...";
	}
	return name;		
}

/*-安全键盘-*/
function addKey(){
	var keyStr='<div id="popDiv" class="popDiv">'
				+'<div class="clearfix key_top" colspan="3">'
						+'<span class="key_close" onclick="winHide();"></span>'
						+'<span class="key_logo">安全输入</span>'							
				+'</div>'
				+'<table cellspacing="2" cellpadding="0">'				
					+'<tr>'
						+'<td class="key" style="width: 33%;">1</td>'
						+'<td class="key" style="width: 33%;">2</td>'
						+'<td class="key" style="width: 33%;">3</td>'
					+'</tr>'
					+'<tr>'
						+'<td class="key">4</td>'
						+'<td class="key">5</td>'
						+'<td class="key">6</td>'
					+'</tr>'
					+'<tr>'
						+'<td class="key">7</td>'
						+'<td class="key">8</td>'
						+'<td class="key">9</td>'
					+'</tr>'
					+'<tr>'
						+'<td style="cursor:auto"></td>'
						+'<td class="key">0</td>'
						+'<td id="delKey" class="key_del"><img src="images/key_del.png"/></td>'
					+'</tr>'
				+'</table>'
		+'</div>'		
		$("#popDiv").remove();
		$("body").append(keyStr);
}
/*------IETips------*/
function ieTest(){	
	if(!$.cookie('ietest')){
		var str='<div class="ie_tips layout" id="ieTips">您如果使用低版本的IE浏览器可能导致浏览异常，请使用IE9及以上版本或者chrome，Firefox最新版；</div>';
		$("#ieTips").remove();
		if(getChannel()=="web"){
			$("body").prepend(str);
			setTimeout(function(){
				$("#ieTips").remove();
			},5000);
		}
		$.cookie("ietest",true);
	}
	
}

/*--inputUP---*/
function inputUP(outbox,inputbox){
	if(getChannel()!="web"){
		var newT=$(outbox)[0].offsetTop;
		var oldH=$(document).height();			
		$(inputbox).focus(function(){
			var newH=$(document).height()+newT;
			$("body").height(newH);
			$(document).scrollTop(newT);
		});
		$(inputbox).blur(function(){
			$("body").height(oldH);
		});
	}
}
/*----*/
function bankLimited(bank_name)
{
	switch(bank_name)
	{
	case "中国银行":
		return "单笔限额5万，日限额30万";
	case "农业银行":
		return "单笔限额5万，日限额30万";
	case "工商银行":
		return "单笔限额5万，日限额5万";
	case "建设银行":
		return "单笔限额5万，日限额5万";
	case "交通银行":
		return "单笔限额5万，日限额5万";
	case "中信银行":
		return "单笔限额5万，日限额30万";
	case "光大银行":
		return "单笔限额5万，日限额30万";
	case "浦东发展银行":
		return "单笔限额5万，日限额5万";
	case "民生银行":
		return "单笔限额5万，日限额30万";
	case "广发银行股份有限公司":
		return "单笔限额5万，日限额20万";
	case "广发银行":
		return "单笔限额5万，日限额20万";
	case "兴业银行":
		return "单笔限额5万，日限额5万";
	case "平安银行":
		return "单笔限额5万，日限额30万";
	case "华夏银行":
		return "单笔限额5万，日限额30万";
	case "北京银行":
		return "单笔限额5万，日限额30万";	
	default:
		return "不支持";
	}
}
/*
* leplatform
*
* */

var LePlatform = {
	/*
	 * 登陆
	 * */
	checklogin:function(cbUrl){
		if (cbUrl == undefined) {
			cbUrl = window.location.href;
		}
		var uid = $.cookie('ssouid');
		if (uid == null || uid == '') {
			redirect('http://sso.letv.com/user/mLoginHome?next_action=' + encodeURI(cbUrl));
		}else{
			timestamp = Date.parse(new Date());
			$.ajax({
				url:"http://sso.letv.com/open/checklogin?jsonp=?",
				type:'GET',
				async:false,
				data:{"time":timestamp},
				dataType:'json',
				success:function(jsonData){
					setStorage('loginInfo', jsonData, 'json');
				}
			});
			return getStorage('loginInfo', 'json');
		}
	},
	/*
	 * 库存查询
	 * */
	findProjectStock:function(stockData){
		var Stock = {};
		$.ajax({
			url:LpfConfig.setting.domain + 'project/findProjectStock/' + stockData + '/h5',
			async:false,
			type:'GET',
			success:function(jsonData){
				Stock.totalAmount = jsonData.data.totalAmount;
				Stock.financedAmount = jsonData.data.financedAmount;
				Stock.usableAmount = jsonData.data.usableAmount;
				Stock.proportion = jsonData.data.usableAmount / jsonData.data.totalAmount;
			}
		});
		return Stock;
	},
	callback:function(cb,json) {
		if (cb != null) {
			cb(json);
		}
	},
	sysPost:function(url,cb,data,htmlObj){
		var d = data || {};
		var type = '';
		var jsonData = {};
		if (typeof data == 'string' || data == undefined) {
			type = 'GET';
		}else{
			type = 'POST';
		}
		$.ajax({
			url:url,
			type:type,
			dataType:'json',
			data:d,
			success:function(Data){
				if (Data.result == 0 || Data.status == 0) {
					console.log(Data.message);
				}else{
					if ($('.list-loading')) {
						$('.list-loading').remove();
					}
					LePlatform.callback(cb, Data);
				}
			},
			complete:function(){
				if(htmlObj){
					htmlObj.append('<div class="list-loading">loading</div>');
				}
			},
			error:function(XMLHttpRequest, textStatus, errorThrown){
				console.log(textStatus);
			}
		});
	},
	asyncGet:function(url,data){
		var result = null;
		$.ajax({
			url:LpfConfig.setting.domain + url,
			type:'GET',
			async:false,
			data:data,
			success:function(jsonData){
				result = jsonData.data;
			}
		});
		return result;
	},
	isCertification:function(userKey){
		return LePlatform.asyncGet(LpfConfig.port.isCertification,{token:userKey});
	},
	isBindCard:function(userKey){
		return LePlatform.asyncGet(LpfConfig.port.isBindCard,{token:userKey});
	},
	isSetupTradePassword:function(userKey){
		return LePlatform.asyncGet(LpfConfig.port.isSetupTradePassword,{token:userKey});
	},
	getUserInfo:function(userKey){
		return LePlatform.asyncGet(LpfConfig.port.getUserInfo,{token:userKey});
	},
	getCardInfo:function(userKey){
		return(LePlatform.asyncGet(LpfConfig.port.getBankInfo,{token:userKey}));
	}
};
$(document).ready(function(){
	//addKey();//安全键盘
	/*appendBotMenu();//主导航*/
	//showHelp();//帮助框
	//tabMenu();//展开收缩tab
});







