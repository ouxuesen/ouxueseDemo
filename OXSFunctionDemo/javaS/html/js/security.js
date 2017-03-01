
/*任意进制加密*/
function EnChTo(h,data){
    var monyer = new Array();var i,s;
    for(i=0;i<data.length;i++){
        monyer+=data.charCodeAt(i).toString(h)+" "; 
	}
    return monyer.toString();
}
/*任意进制解密*/
function DeChTo(h,data){
    var monyer = new Array();var i;
    var s=data.split(" ");
    for(i=0;i<s.length;i++){
        monyer+=String.fromCharCode(parseInt(s[i],h));
	}
    return monyer.toString();
}