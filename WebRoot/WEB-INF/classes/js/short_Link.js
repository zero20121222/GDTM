function register_Out(obj, e){//用于判断是否是最外边
	if (e.currentTarget) {
		if (e.relatedTarget != obj) {
			if (obj != e.relatedTarget.parentNode) {
				return true;
			}
		}
	} else {
		if (e.toElement != obj) {
			if (obj != e.toElement.parentNode) {
				return true;
			}
		}
	}

	return false;
}

/*这个部分的文件决定使用javascript动态的调用js文件来实现这样比较缩短时间*/
var mWindow = null;//快捷对象移动体
var short_View = null;//打开的对象
function create_ShortLinks(){//这个明天将它更改成为一个对象类这样便于管理
	var views = document.createElement("div");
	views.style.width = "100%";
	views.style.height = "80px";
	
	
	/*创建拖拽对象*/
	var short_head = document.createElement("div");
	short_head.style.position = "absolute";
	short_head.style.width = "80px";
	short_head.style.height = "80px";
	short_head.style.background = "url(images/project_stop.png)";
	short_head.style.borderRadius = "5px";
	addEvent(short_head , "dblclick" , open_shortView);//事件绑定

	views.appendChild(short_head);
	
	var frame = new Window_frame(80 , 80, 400, 20, "", "", null, null, null, true);
	mWindow = new moveWindow(frame , null, true, null, false, null, true, 2);
	mWindow.structWindow();
	mWindow.Win_view.add_Child(views);
	
	document.body.appendChild(mWindow.Win_frame.frame);
	//为对象装载移动对象元素
	new windowDrag(mWindow.Win_frame.frame , mWindow.Win_frame.frame, mWindow.Win_location).createView();
}
create_ShortLinks.prototype.hiddenView = function(){//对象的隐藏方法
	mWindow.hideWindow();
	if(short_View != null){
		short_View.hiddenView();
	}
}
create_ShortLinks.prototype.displayView = function(){//对象的显示方法
	mWindow.displayWindow();
}


//开启快捷框对象
function open_shortView(){
	mWindow.hideWindow();

	if(short_View == null){
		short_View = new shortView();
	}else{
		short_View.displayView();
	}
}

//创建打开的快捷对象框
function shortView(){
	this.timers = new Array(4);//用于清除事件绑定函数
	this.link_frame = document.createElement("div");//对象框架
	this.link_frame.id = "short_link_frame";
	this.link_frame.style.width = "200px";
	this.link_frame.style.height = "200px";
	this.link_frame.style.position = "absolute";
	this.link_frame.style.left = (parseInt(mWindow.getWindowX()) - 60) + "px";
	this.link_frame.style.top = (parseInt(mWindow.getWindowY()) - 60) + "px";
	addEvent(this.link_frame , "mouseover", this.frame_Over);
	addEvent(this.link_frame , "mouseout", this.frame_Out);
	
	var link_styles = {
		allLink:[{cname:"short_home",title:"主页"},
				 {cname:"short_select",title:"课题选择"},
				 {cname:"short_team",title:"团队信息"},
				 {cname:"short_manage",title:"阶段管理"},
				 {cname:"short_user",title:"用户信息"}]
	};

	for(var i=0;i<link_styles.allLink.length;i++){
		var link = document.createElement("div");
		link.className = link_styles.allLink[i].cname;
		link.title = link_styles.allLink[i].title;

		addEvent(link , "mouseover", this.link_Over(i));
		addEvent(link , "mouseout", this.link_Out(i));
		addEvent(link , "click", this.link_Click(i));//触发click事件
		this.link_frame.appendChild(link);
	}

	document.body.appendChild(this.link_frame);
}
shortView.prototype.displayView = function(){
	short_View.link_frame.style.display = "block";
	short_View.link_frame.style.left = (parseInt(mWindow.getWindowX()) - 60) + "px";
	short_View.link_frame.style.top = (parseInt(mWindow.getWindowY()) - 60) + "px";
}
shortView.prototype.hiddenView = function(){
	for(var i=0;i<short_View.timers.length;i++){//清除所有时间对象
		short_View.timers[i] != null ? clearTimeout(short_View.timers[i]) : "";
	}

	short_View.link_frame.style.display = "none";
}
shortView.prototype.dynamicHidden = function(){//动态隐藏模式
	var childs = short_View.link_frame.childNodes;

	this.timers[4] = setTimeout(function(){
		childs[4].style.display = "none";
	},300);

	this.timers[3] = setTimeout(function(){
		childs[3].style.display = "none";
	},600);

	this.timers[2] = setTimeout(function(){
		childs[2].style.display = "none";
	},900);

	this.timers[1] = setTimeout(function(){
		childs[1].style.display = "none";
	},1200);

	this.timers[0] = setTimeout(function(){
		childs[0].style.display = "none";
		short_View.link_frame.style.display = "none";
		mWindow.displayWindow();
	},1500);
}
shortView.prototype.frame_Over = function(){
	var childs = short_View.link_frame.childNodes;

	for(var i=0;i<short_View.timers.length;i++){
		clearTimeout(short_View.timers[i]);
		childs[i].style.display = "block";
	}
	short_View.link_frame.style.display = "block";
	mWindow.hideWindow();
}
shortView.prototype.frame_Out = function(evt){
	if(register_Out(short_View.link_frame , evt)){
		short_View.dynamicHidden();//窗口隐藏
	}
}
shortView.prototype.link_Over = function(i){
	return function(){
		var childs = short_View.link_frame.childNodes;
		
		if(ifIE){
			childs[i].style.filter = "alpha(opacity="+100+")";
		}else{
			childs[i].style.opacity = 1;
		}
	}
}
shortView.prototype.link_Out = function(i){
	return function(){
		var childs = short_View.link_frame.childNodes;
		
		if(ifIE){
			childs[i].style.filter = "alpha(opacity="+80+")";
		}else{
			childs[i].style.opacity = 0.8;
		}
	}
}
shortView.prototype.link_Click = function(i){//对于不同的按钮设置不同的处理事件函数
	return function(){
		var childs = short_View.link_frame.childNodes;
		
		switch(i){
			case 0: alert("click"); break;
			case 1: alert("over1"); break;
			case 2: alert("over2"); break;
			case 3: alert("over3"); break;
			default : alert("default"); break;
		}
	}
}