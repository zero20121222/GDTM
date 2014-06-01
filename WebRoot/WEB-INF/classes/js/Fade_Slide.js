var ifIE = window.ActiveXObject ? true : false;//判断是否是IE对象

//对象id索引方式
function $(id){
	return typeof(id) == "string" ? document.getElementById(id) : id;
}

//添加处理事件
function addEvent(obj , event, fun){
	if(ifIE){
		obj.attachEvent("on"+event , fun);
	}else{
		obj.addEventListener(event , fun , false);
	}
}

//对于对象的继承关系操作
function extend(child , parent){
	for(var attribute in parent){
		child[attribute] = parent[attribute];
	}

	return child;
}

//得到当前对象的css元素数据（这个函数可以检索对象的class样式类的当前状态--》使用类的style无法查询的）
function currentObjStyle(obj){
	return obj.currentStyle || document.defaultView.getComputedStyle(obj , null);
}

//为对象绑定操作函数，并返回操作函数
function bind(obj , fun){
	return function(){
		return fun.call(obj);//这个相当于是obj.fun()无参函数
	}
}

//将Tween封装成为对象
/*
 * t:当前时间
 * b:初始值
 * c:变化量
 * d:持续时间
 */
function Tween(t , b, c, d, s){
	this.t = t == null || undefined ? 0 : t;
	this.b = b == null || undefined ? 0 : b;
	this.c = c == null || undefined ? 0 : c;
	this.d = d == null || undefined ? 100 : d;
	this.s = s == null || undefined ? 1.70158 : s;
}
Tween.prototype.setFun = function(funName){
	this.funName = funName == null || undefined ? "quart" : funName;
	if(funName == "quart"){
		return this.Quart();
	}else if(funName == "back"){
		return this.Back();
	}else if(funName == "bounce"){
		return this.Bounce();
	}else if(funName == "circ"){
		return this.Circ();
	}
}
Tween.prototype.Quart = function(){//四次方的缓动
	var t = this.t;
	return -this.c * ((t=t/this.d-1)*t*t*t - 1) + this.b;
}
Tween.prototype.Back = function(){//超过范围的三次方缓动
	var t = this.t;
    return this.c*((t=t/this.d-1)*t*((this.s+1)*t + this.s) + 1) + this.b;
}
Tween.prototype.Bounce = function(){//指数衰减的反弹缓动 
	var t = this.t;
	if ((t/=this.d) < (1/2.75)) {  
		return this.c*(7.5625*t*t) + this.b;  
	} else if (t < (2/2.75)) {  
		return this.c*(7.5625*(t-=(1.5/2.75))*t + .75) + this.b;  
	} else if (t < (2.5/2.75)) {  
		return this.c*(7.5625*(t-=(2.25/2.75))*t + .9375) + this.b;  
	} else {  
		return this.c*(7.5625*(t-=(2.625/2.75))*t + .984375) + this.b;  
	}  
}
Tween.prototype.Circ = function(){
	var t = this.t;
	return this.c * Math.sqrt(1 - (t=t/this.d-1)*t) + this.b;
}



////////////////////////////////////////////////////////////////////////////////////////
/* 图片管理对象设计 */
/* 对象参数
 * container:对象容器(必需设定)
 * slider:滑动对象(必需设定)
 * count:对象个数(必需设定)
 * slideargu:滑动对象参数设置
 * tween:滑动缓动算法对象
 * startFun():这个是对于SlideObj对象的run方法执行前调用的初始化方法（为空的方法提供给用户设定的接口）
 * finishFun():这个是提供用户在停止图片播放时调用的函数（为空的方法提供给用户设定的接口）
 * slideRun(index):index->当前移动图片对象索引（这个是一个某张图片开始移动的方法）
 * slideMove():图片对象的移动距离的控制
 * slideMoveTo():图片的位置的移动算法
 * slideNext():确定下一张图片移动对象
 * slidePrevious():确定上一张图片移动对象
 * slideStop():是图片移动停顿
 */
function SlideObj(container , slider , count , slideargu, tween){
	this.container = $(container);//对象容器
	this.slider = $(slider);//滑动对象
	this.count = count;//对象个数
	this.slideargu = slideargu == null || undefined ? new SlideArgs() : slideargu;//滑动参数设置
	this.tween = tween == null || undefined ? new Tween() : tween;//滑动缓动算法对象
	
	this.nowIndex = 0;//当前对象索引值
	this.oldIndex = 0;//旧的对象索引值
	this.moveTarget = 0;//目标值
	this.timer = null;//定时对象对于事件的清除操作

	//对象容器&滑动对象样式修正 
	this.container.style.position = "relative";//这个必须是相对定位
    this.container.style.overflow = "hidden";  
    this.slider.style.position = "absolute";//必须是绝对定位不然无法移动 
    
	if(this.slideargu.change == 0){
		if(this.slideargu.direction == ("left" || "right")){
			this.slideargu.change = this.slider["offsetWidth"]/this.count;
		}else{
			this.slideargu.change = this.slider["offsetHeight"]/this.count;
		}
	}
}
SlideObj.prototype.startFun = function(){};//这个是提供用户在图片转换时的接口
SlideObj.prototype.finishFun = function(){};//这个是提供用户在停止图片播放时调用的函数
SlideObj.prototype.slideRun = function(index){
	var indexs = index == undefined ? this.nowIndex : index;

	if(indexs < 0){
		indexs = this.count - 1;//往回移动
	}else if(indexs >= this.count){
		indexs = 0;//这个是直接跳转到0位置处
	}
	
	//需要移动到的位置&保存当前索引对象
	this.moveTarget = -Math.abs(this.slideargu.change) * (this.nowIndex = indexs);
	
	this.tween.t = 0;//进行下一张图片变换
	this.tween.b = parseInt(currentObjStyle(this.slider)[this.slideargu.direction]);//初始值
	this.tween.c = this.moveTarget - this.tween.b;//移动量

	this.startFun();
    this.slideMove();
}
SlideObj.prototype.slideMove = function(){//对象移动
	clearTimeout(this.timer);//清除实现过的时间函数调用
	
    //未到达目标继续移动否则进行下一次滑动(一开始的移动量为零直接去下一个对象)
    if (this.tween.c && this.tween.t < this.tween.d) {
        this.slideMoveTo(Math.round(this.tween.setFun(this.slideargu.tweenFun)));
		this.tween.t++;
		
        this.timer = setTimeout(bind(this, this.slideMove), this.slideargu.time);  
    }else{
        this.slideMoveTo(this.moveTarget);//需要移动到的位置this.moveTarget
        this.oldIndex = this.nowIndex;
        
		//this.auto:用于控制是否自动的播放下一张图片,this.pause:用于设置图片的停顿时间
		if(this.slideargu.auto){
			this.timer = setTimeout(bind(this, this.slideNext), this.slideargu.pause);
		}
    }
}
SlideObj.prototype.slideMoveTo = function(length){
	this.slider.style[this.slideargu.direction] = length + "px";
}
SlideObj.prototype.slideNext = function(){
	this.slideRun(++this.nowIndex);
}
SlideObj.prototype.slidePrevious = function(){
	this.slideRun(--this.nowIndex);
}
SlideObj.prototype.slideStop = function(){
	clearTimeout(this.timer);
	this.slideMoveTo(this.moveTarget);
}


/*
 * SlideArgs滑动参数设置
 * direction:移动方向(left|top)
 * auto:是否自动播放图片
 * change:改变量
 * time:滑动延时
 * pause:停顿时间
 * tweenFun:图片缓动算法名称
 * changetweenFun(tweenFun):tweenFun（图片缓动算法名称）更改图片缓动算法
 */
function SlideArgs(direction , auto, change, time, pause, tweenFun){
	this.direction = direction == null || undefined ? "left" : direction;//移动方向
	this.auto = auto == null || undefined ? true : auto;//是否自动
	this.change = change == null || undefined ? 0 : change;//改变量
	this.time = time == null || undefined ? 10 : time;//滑动延时
	this.pause = pause == null || undefined ? 2000 : pause;//停顿时间
	this.tweenFun = tweenFun == null || undefined ? "quart" : tweenFun;//图片缓动算法
}
SlideArgs.prototype.changetweenFun = function(tweenFun){//更改图片缓动算法
	this.tweenFun = tweenFun == null || undefined ? "quart" : tweenFun;
}



////////////////////////////////////////////////////////////////////////////////////
/*淡入淡出效果实现操作
 * container:对象容器(必需设定)
 * fader:淡入淡出对象(必需设定)(内部的必须是img图片对象用于检索)
 * fadeway:淡入淡出的起始方式（淡入|淡出）
 * fadeargu:淡入淡出对象参数设置
 * tween:缓动算法对象
 * fadeHide():对象效果层影藏
 * startFun():这个是提供用户在初始化框架时调用的函数
 * finishFun():这个是提供用户在停止图片播放时调用的函数
 * fadeRun(index):（index：这个表示的是需要淡入淡出的对象索引）图片的淡入淡出效果实现
 * fadeOut():图片淡出方法
 * fadeIn():图片淡入方法
 * fadeChange():图片的透明度的更改方法
 * fadeNext():下一张图片处理方法
 * fadePrevious():上一张图片处理方法
 * fadeStop():图片停止运动方法
 * 为了解决关于当前图片与目标图片的切换问题需要两个索引对象控制
 */
function FadeObj(container , fader,  fadeway, fadeargu, tween){
	this.container = $(container);//对象容器
	this.fader = $(fader);//淡入淡出对象
	this.fadeway = fadeway == null || undefined ? "out" : fadeway;//判断是先淡入还是淡出操作
	this.fadeargu = fadeargu == null || undefined ? new FadeArgs() : fadeargu;//淡入淡出系数
	this.tween = tween == null || undefined ? new Tween() : tween;//缓动算法对象
	
	this.fadePs = this.fader.childNodes;//得到全部图片对象
	this.count = this.fadePs.length;//图片数目
	this.fadeHide();

	this.nowIndex = 0;//当前对象索引值
	this.oldIndex = 0;//旧对象索引
	this.timer = null;//定时对象对于事件的清除操作
}
FadeObj.prototype.fadeHide = function(){
	//将其与图片隐藏
	for(var num=1 ; num<this.count; num++){
		this.fadePs[num].style.display = "none";
	}
}
FadeObj.prototype.startFun = function(){};//这个是提供用户在初始化框架时调用的函数
FadeObj.prototype.finishFun = function(){};//这个是提供用户在停止图片播放时调用的函数
FadeObj.prototype.fadeRun = function(index){//图片的淡入淡出效果实现
	this.fadePs[this.oldIndex].style.display = "none";//移除上一个对象
	this.nowIndex = index == null || undefined ? this.nowIndex : index;//当前对象索引
	this.fadePs[this.nowIndex].style.display = "block";//开启下一个对象
	this.oldIndex = this.nowIndex;//保存当前索引对象

	this.tween.t = 0;//进行下一张图片变换
	this.tween.b = parseFloat(currentObjStyle(this.fadePs[this.nowIndex])["opacity"]);//获取当前对象透明度值

	this.startFun();
	if(this.fadeway == "out"){//淡出
		this.tween.c = Math.abs(this.fadeargu.minratio - this.tween.b);
		
		this.fadeOut();//淡出算法
	}else{//淡入
		this.tween.c = Math.abs(this.fadeargu.maxratio - this.tween.b);

		this.fadeIn();//淡入算法
	}
}
FadeObj.prototype.fadeOut = function(){//淡出算法
	clearTimeout(this.timer);//清除实现过的时间函数调用
	
    if (this.tween.c && this.tween.t < this.tween.d) {
        this.fadeChange(2*this.fadeargu.maxratio - this.tween.setFun(this.fadeargu.tweenFun));
		this.tween.t++;
		
        this.timer = setTimeout(bind(this, this.fadeOut), this.fadeargu.time);  
    }else{
        this.fadeChange(this.fadeargu.minratio);
        
		if(this.fadeargu.auto){
			this.timer = setTimeout(bind(this, this.fadeNext), this.fadeargu.outpause);
		}
    }
}
FadeObj.prototype.fadeIn = function(){//淡入算法
	clearTimeout(this.timer);//清除实现过的时间函数调用
	
    if (this.tween.c && this.tween.t < this.tween.d) {
        this.fadeChange(this.tween.setFun(this.fadeargu.tweenFun));
		this.tween.t++;
		
        this.timer = setTimeout(bind(this, this.fadeIn), this.fadeargu.time);  
    }else{
        this.fadeChange(this.fadeargu.maxratio);
        
		if(this.fadeargu.auto){
			this.timer = setTimeout(bind(this, this.fadeNext), this.fadeargu.inpause);
		}
    }
}
FadeObj.prototype.fadeChange = function(opValue){//当前图片透明度更改
	if(ifIE){
		this.fadePs[this.nowIndex].style.filter = "alpha(opacity="+opValue*100+")";//IE下更改透明度
	}else{
		this.fadePs[this.nowIndex].style.opacity = opValue;//非IE下更改透明度
	}
}
FadeObj.prototype.fadeNext = function(){//下一张图片显示
	if(this.fadeway == "out"){
		this.fadeway = "in";//下一步淡入
		
		if(++this.nowIndex >= this.count){//判断是否到最后一张图
			this.nowIndex = 0;
		}

		this.fadePs[this.nowIndex].style.opacity = this.fadeargu.minratio;

		this.fadeRun(this.nowIndex);
	}else{
		this.fadeway = "out";//下一步淡出

		this.fadePs[this.nowIndex].style.opacity = this.fadeargu.maxratio;

		this.fadeRun(this.nowIndex);
	}
}
FadeObj.prototype.fadePrevious = function(){//上一张图片显示
	if(this.fadeway == "out"){
		this.fadeway = "in";//下一步淡入
		
		if(--this.nowIndex < 0){//判断是否到最后一张图
			this.nowIndex = this.count;
		}
		
		this.fadePs[this.nowIndex].style.opacity = this.fadeargu.minratio;
		
		this.fadeRun(this.nowIndex);
	}else{
		this.fadeway = "out";//下一步淡出
		
		this.fadePs[this.nowIndex].style.opacity = this.fadeargu.maxratio;
		
		this.fadeRun(this.nowIndex);
	}
}
FadeObj.prototype.fadeStop = function(){//当使某个图片停止操作处理
	clearTimeout(this.timer);
	this.fadeChange(this.fadeargu.maxratio);
}

/*淡入淡出对象参数类型
 * auto:是否自动
 * minratio:透明度最小值
 * maxratio:透明度最大值
 * time:淡入淡出效果延时
 * outpause:淡出停顿时间
 * inpause:淡入停顿时间
 * tweenFun:图片缓动算法
 * changetweenFun(tweenFun):tweenFun:图片缓动算法名称，更改图片缓动算法
 */
function FadeArgs(auto , minratio, maxratio, time, outpause, inpause, tweenFun){
	this.auto = auto == null || undefined ? true : auto;//是否自动
	this.minratio = minratio == null || undefined ? 0.1 : minratio;//透明度最小值
	this.maxratio = maxratio == null || undefined ? 1 : maxratio;//透明度最大值
	this.time = time == null || undefined ? 10 : time;//淡入淡出效果延时
	this.outpause = outpause == null || undefined ? 200 : outpause;//淡出停顿时间
	this.inpause = inpause == null || undefined ? 2000 : inpause;//淡入停顿时间
	this.tweenFun = tweenFun == null || undefined ? "quart" : tweenFun;//图片缓动算法
}
FadeArgs.prototype.changetweenFun = function(tweenFun){//更改图片缓动算法
	this.tweenFun = tweenFun == null || undefined ? "quart" : tweenFun;
}