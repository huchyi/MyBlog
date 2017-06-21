
//设置cookie
function setCookie(name, value, day) {
    var oDate = new Date();
    oDate.setDate(oDate.getDate() + day);
    document.cookie = name + '=' + value + ';expires=' + oDate;
}
//删除cookie
function delCookie(name) {
    setCookie(name, 1, -1);
}

//获取cookie
function getCookie(name) {
    alert(">>>>>>>>>>>>>>cookie:" +　document.cookie)
    var arr = document.cookie.split(';');
    for(var i = 0; i < arr.length; i++) {
        var arrName = arr[i].split('=');
        if(arrName[0].value === name) {
            return arrName[1];
        }
    }
    return '';
}

//将字符串时间转换为毫秒,1秒=1000毫秒;参数可传1s，6s，8h,4d。。。
function getMsec(DateStr){
    var timeNum=str.substring(0,str.length-1)*1; //时间数量
    var timeStr=str.substring(str.length-1,str.length); //时间单位前缀，如h表示小时
    if (timeStr=="s"){ //20s表示20秒
        return timeNum*1000;}
    else if (timeStr=="h"){ //12h表示12小时
        return timeNum*60*60*1000;}
    else if (timeStr=="d"){
        return timeNum*24*60*60*1000;} //30d表示30天
}