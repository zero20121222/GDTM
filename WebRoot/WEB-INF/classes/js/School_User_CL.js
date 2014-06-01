//这个是用于设置一个用户保存用户真实姓名的操作处理（方便后期用户在访问网页有关于用户真实姓名的操作时不需要时时的去访问数据库）
function userNameObj(trueName){
	this.trueName = trueName;
	this.cookieObj = new CookieObj();//创建一个cookie处理对象
}
userNameObj.prototype.keepTrueName = function(){//将name保存到Cookie中
	this.cookieObj.setCookie("GDT_TrueName" , this.trueName, 7);
};
userNameObj.prototype.readTrueName = function(){
	this.trueName = this.cookieObj.getCookie("GDT_TrueName");
	
	return this.trueName;
};