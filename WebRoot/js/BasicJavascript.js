//这个是作为一个基础的javascript调用对象处理文件
var ifIE = window.ActiveXObject ? true : false;
var all_minWindows = null;//创建一个长久保存最小化对象的函数
var request = null;//用于保存一个全局的request对象

/*
 * 得到特定id编号的html元素对象
 */
function $(objname){
	return document.getElementById(objname);
}

//这个是用于异步交互的ajax技术(创建一个XMLHttpRequest对象)
function createXMLHttp(){
	if(ifIE){
		request = new ActiveXObject("Microsoft.XMLHTTP");
	}else if(window.XMLHttpRequest){
		request = new XMLHttpRequest();
	}
}

//得到一个XMLHttpRequest对象
function newXMLHttpRequest(){
	if(ifIE){
		return new ActiveXObject("Microsoft.XMLHTTP");
	}else if(window.XMLHttpRequest){
		return new XMLHttpRequest();
	}
}

//自动的将iframe大小更改为本页面的高度
function suit_Page(){
	var iframe_name = "main_body";
	var frame = parent.document.getElementById(iframe_name);
	
	frame.style.marginTop = 0;
	frame.style.marginBottom = 0;
	frame.style.height = document.body.clientHeight + "px";
}

//获取对象元素相对于整个page的X&Y坐标位置
function relativePageY(){
	return event.pageY || (event.clientY + (document.documentElement.scrollTop || document.body.scrollTop));
}

function relativePageX(){
	return event.pageX || (event.clientX + (document.documentElement.scrollLeft || document.body.scrollLeft));
}

/*
 * 这个是用于对于元素对象添加事件的函数
 */
function addEvent(obj , event, fun){
	if(ifIE){
		obj.attachEvent("on"+event , fun);
	}else{
		obj.addEventListener(event , fun , false);
	}
}

//去除事件对象的事件绑定
function removeEventHandler(target, type, func) {
    if (target.removeEventListener){
        target.removeEventListener(type, func, false);
    }else if (target.detachEvent){
        target.detachEvent("on" + type, func);
    }else{
    	delete target["on" + type];
    }
}

/* 为了实现关于兼容IE以及各类浏览器对于offsetLeft的数据的获取方式的不同 */
function getOffsetLeft(obj){
	var left = 0;
	var offsetObj = obj;
	
	while(offsetObj!=null && offsetObj!=document.body){
		left += offsetObj.offsetLeft;
		
		if(ifIE){
			parseInt(offsetObj.currentStyle.borderLeftWidth)>0 ? left += parseInt(offsetObj.currentStyle.borderLeftWidth) : "";
		}
		offsetObj = offsetObj.offsetParent;
	}
	
	return left;
}

function getOffsetTop(obj){
	var top = 0;
	var offsetObj = obj;
	
	while(offsetObj!=null && offsetObj!=document.body){
		top += offsetObj.offsetTop;
		
		if(ifIE){
			parseInt(offsetObj.currentStyle.borderTopWidth)>0 ? top += parseInt(offsetObj.currentStyle.borderTopWidth) : "";
		}
		offsetObj = offsetObj.offsetParent;
	}
	
	return top;
}

//对字符串长度的计算主要正对的是中文
//中文的Unicode编码是[u4e00-u9fa5]
function check_Length(infor){
	var re = /[\u4e00-\u9fa5]/g;
	return infor.replace(re,"aa").length;
}

//用于验证是否是数字字符
function checkmath(infor){
	var re = /^[0-9]*$/g;
	if(infor.replace(re,"") == ""){
		return true;
	}else{
		return false;
	}
}

//年龄格式验证
function check_age(infor){
	if(checkmath(infor)){
		return (parseInt(infor)>0 && parseInt(infor)<=120) ? true : false;
	}else{
		return false;
	}
}

//用于验证手机
function check_PH(infor){
	var re = /\d{11}/;
	if(infor.replace(re,"") == ""){
		return true;
	}else{
		return false;
	}
}

//用于验证身份证号码
function check_Card(infor){///(^\d{15}$)|(^\d{17}([0-9]|X)$)/
	var re = /(^\d{15}$)|(^\d{17}([0-9]|[X|x])$)/;
	if(infor.replace(re,"") == ""){
		return true;
	}else{
		return false;
	}
}

//用于验证英文字符
function checkenglish(infor){
	var re = /[a-zA-Z]/g;
	if(infor.replace(re,"") == ""){
		return true;
	}else{
		return false;
	}
}

function checkmodle_Name(infor){
	var re = /^\S+\D.*$/;
	if(infor.replace(re,"") == ""){
		return true;
	}else{
		return false;
	}
}

//用于验证是否是中文字符
function checkChinese(infor){
	var re = /[^\u4E00-\u9FA5]/g;
	//这里是通过replace来对infor进行操作假设infor是中文那么返回的结果是""
	if(infor.replace(re,"") == ""){
		return true;
	}else{
		return false;
	}
}

//用于验证中文名字格式
function check_ChineseName(infor){
	var re = /[^\u4E00-\u9FA5]/g;
	if(infor.replace(re,"") != "" && infor.length<=5 && infor.length >=2){
		return true;
	}else{
		return false;
	}
}

//用于判断输入信息是否为空
function checkemptyinfor(infor){
	//这个表示的是多个空格
	var re = /^ +| +$/g;
	if(infor.replace(re,"") == ""){
		return true;
	}else{
		return false;
	}
}

//用于检测手机的格式是否正确
function check_phone(infor){
	var re = /^1[3|4|5|8][0-9]\d{8}$/;
	if(infor.replace(re , "") == ""){//(/^1[3|4|5|8][0-9]\d{4,8}$/.test(sMobile))
		return true;
	}else{
		return false;
	}
}

//用于检索E-mail格式是否正确
function check_Email(infor){
	var re = /\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/;
	if(infor.replace(re,"") == ""){
		return true;
	}else{
		return false;
	}
}

//检验Qq信息
function check_Qq(infor){
	var re = /^\d{5,10}$/;
	if(infor.replace(re,"") == ""){
		return true;
	}else{
		return false;
	}
}

//检验密码信息
function check_PW(infor){
	var re = /^[\@A-Za-z0-9\!\#\$\%\^\&\*\.\~]{6,20}$/;
	if(infor != "" && infor.replace(re,"") == ""){
		return true;
	}else{
		return false;
	}
}

//input样式设定元素对象(作为一个父对象元素)
function inputElementObj(inputobj){
	this.inputobj = inputobj;
	loadScript_Css("css/BasicCss.css" , "css", null);
}
inputElementObj.prototype.createView = function(){
	addEvent(this.inputobj , "blur", this.onblurEvent(this.inputobj));
	addEvent(this.inputobj , "focus", this.onfocusEvent(this.inputobj));
	addEvent(this.inputobj , "keyup", this.onkeyupEvent(this.inputobj));
	addEvent(this.inputobj , "keydown", this.onkeydownEvent(this.inputobj));
};
inputElementObj.prototype.onkeyupEvent = function(inputObj){};
inputElementObj.prototype.onkeydownEvent = function(inputObj){};
inputElementObj.prototype.onblurEvent = function(inputObj){//失去焦点触发事件
	return function(){
		inputObj.parentNode.className = "input_frame";
	}
};
inputElementObj.prototype.onfocusEvent = function(inputObj){//得到焦点触发事件
	return function(){
		inputObj.parentNode.className = "input_frame_focus";
	}
};

//(对于TextArea对象的基本事件的控制)
function textareaElementObj(textareaObj,maxLength){//设定textarea对象样式
	this.textareaObj = textareaObj;
	this.maxLength = maxLength == null || undefined ? 200 : maxLength;
	this.nowLength = 0;//用于标记当前的输入字符个数
	this.maxCount = null;//用于标记输入字符的长度的控制
	loadScript_Css("css/BasicCss.css" , "css", null);
}
textareaElementObj.prototype.createView = function(){
	this.createMaxCount();
	addEvent(this.textareaObj , "blur", this.blurEvent(this));
	addEvent(this.textareaObj , "focus", this.focusEvent(this.textareaObj));
	addEvent(this.textareaObj , "keyup", this.keyupEvent(this));
};
textareaElementObj.prototype.createMaxCount = function(){
	this.maxCount = document.createElement("div");
	this.maxCount.className = "textarea_maxCount";
	this.maxCount.innerHTML = this.nowLength+"/"+this.maxLength;
	
	this.textareaObj.parentNode.appendChild(this.maxCount);
};
textareaElementObj.prototype.blurEvent = function(textObj){
	return function(){
		textObj.textareaObj.parentNode.className = "textarea_frame";
		
		if(textObj.textareaObj.value.length > textObj.maxLength){
			textObj.textareaObj.value = textObj.textareaObj.value.substring(0 , textObj.maxLength);
			textObj.maxCount.innerHTML = textObj.maxLength+"/"+textObj.maxLength;
		}
	};
};
textareaElementObj.prototype.focusEvent = function(textareaObj){
	return function(){
		textareaObj.parentNode.className = "textarea_frame_focus";
	};
};
textareaElementObj.prototype.setTextInfor = function(textInfor){//输入信息到textarea中数据同时计算信息长度
	this.nowLength = textInfor.length;
	this.maxCount.innerHTML = this.nowLength+"/"+this.maxLength;
};
textareaElementObj.prototype.keyupEvent = function(textObj){
	return function(){
		if(textObj.textareaObj.value.length > textObj.maxLength){
			textObj.textareaObj.value = textObj.textareaObj.value.substring(0 , textObj.maxLength);
		}else{
			textObj.nowLength = textObj.textareaObj.value.length;
			textObj.maxCount.innerHTML = textObj.nowLength+"/"+textObj.maxLength;
		}
	};
};


//获取窗口浏览器当前窗口高度
function windowHeight(){
	var winHeight = 0;
	if (window.innerHeight){
        winHeight = window.innerHeight;
    }else if ((document.body) && (document.body.clientHeight)){
        winHeight = document.body.clientHeight;
    }
    // 通过深入Document内部对body进行检测，获取窗口大小
    if (document.documentElement  && document.documentElement.clientHeight){
        winHeight = document.documentElement.clientHeight;
    }
    return winHeight;
}
//获取窗口浏览器当前窗口宽度
function windowWidth(){
	var winWidth = 0;
	if (window.innerHeight){
        winWidth = window.innerWidth;
    }else if ((document.body) && (document.body.clientWidth)){
        winWidth = document.body.clientWidth;
    }
    // 通过深入Document内部对body进行检测，获取窗口大小
    if (document.documentElement  && document.documentElement.clientWidth){
        winWidth = document.documentElement.clientWidth;
    }
    return winWidth;
}

/* 文档加载 */
function loadFiles(path , id, callback){
	if(path == (null || undefined)){
		return;
	}
	var iframe = document.getElementById(id);

	if(path == iframe.src){
		return;
	}

	if (callback){//回调函数
		if(ifIE){
			iframe.onreadystatechange = function(){
				if (iframe.readyState == 'loaded' || iframe.readyState == 'complete'){
					iframe.onreadystatechange = null;
					callback();
				}
			};
		}else{
			iframe.onload = function(){
				if (!iframe.readyState){
					iframe.onload = null;
					callback();
				}
			};
		}
	}
	iframe.src = path;
}


//cookie对象的创建以及获取方式的设定
function CookieObj(){};
CookieObj.prototype.setCookie = function(c_name , c_value, c_expiredays){//设定cookie
	var expire_date = new Date();
	expire_date.setDate(expire_date.getDate() + parseInt(c_expiredays));//存在时间期限
	
	try{
		var cookie_infor = c_name + "=" + escape(c_value) + ((c_expiredays == (null || undefined)) ? "" : ";expires="+expire_date.toUTCString());
		document.cookie = cookie_infor;
	}catch(err){
		alert("cookie 保存异常");
	}
};
CookieObj.prototype.getCookie = function(c_name){//取得cookie
	if(document.cookie.length > 0){
		var c_start = document.cookie.indexOf(c_name + "=");//返回c_name字符的开始位置
		if(c_start != -1){
			c_start = c_start + c_name.length + 1;
			var c_end = document.cookie.indexOf(";" , c_start);
			if(c_end == -1) c_end = document.cookie.length;//这个是当该对象为cookie最后一个数据时
			return unescape(document.cookie.substring(c_start , c_end));//截取字符串对象
		}
	}
	
	return "";
};

/*
 * 实现对于html元素添加一个处理事件函数
 * 函数作用是：判断当前的处理元素是否是这个当前注册事件元素的子元素对象
 */
function addHtml_ParamFunction(){
	/* IE 比较自私它是将HTMLElement封装了起来外部是得不到他的引用的，所以IE不存在表示全部html元素的对象的 */
	if(typeof(HTMLElement) != "undefined"){
		HTMLElement.prototype.contains = function(obj){
			while(obj != null && typeof(obj.tagName) != "undefined"){
				if(obj == this){
					return true;
				}
				obj = obj.parentNode;
			}
			return false;
		};
	}
}

/*
 * loadScript_Css(path , style, callback):js&css文件的动态加载方式
 * path:文件路径
 * style:文件类型
 * callback:回调函数
 * location:设置文件加载地址（默认为当前页面）
 */
function loadScript_Css(path , style, callback, location){
	loadLocation = location == null || undefined ? document : location;
	
	if(path == (null || undefined)){
		return;
	}

    if(style == "javascript"){
		var all_script = loadLocation.getElementsByTagName("script");
		for(var i=0;i<all_script.length;i++){
			if(path == all_script[i].src){
				return;
			}
		}

		var script = loadLocation.createElement("script");
		script.type = "text/javascript";

		if (callback){//回调函数
			if(ifIE){
				script.onreadystatechange = function(){
					if (script.readyState == 'loaded' || script.readyState == 'complete'){
						script.onreadystatechange = null;
						callback();
					}
				};
			}else{
				script.onload = function(){
					if (!script.readyState){
						script.onload = null;
						callback();
					}
				};
			}
		}
		script.src = path;
		var head = loadLocation.getElementsByTagName("head")[0];
		head.appendChild (script);

	}else if(style == "css"){
		var all_link = loadLocation.getElementsByTagName("link");
		for(var i=0;i<all_link.length;i++){
			if(path == all_link[i].href){
				return;
			}
		}
		
		var link = loadLocation.createElement("link");
		link.type = "text/css";
		link.rel = "stylesheet";//这个必须要添加
		
		if (callback){//回调函数
			if(ifIE){
				link.onreadystatechange = function(){
					if (link.readyState == 'loaded' || link.readyState == 'complete'){
						link.onreadystatechange = null;
						callback();
					}
				};
			}else{
				//当css文件加载完成后将自动的调用回调函数
				link.onload = function(){
					if (!link.readyState){
						link.onload = null;
						callback();
					}
				};
			}
		}
		link.href = path;
		var head = loadLocation.getElementsByTagName("head")[0];
		head.appendChild (link);
	}
}



/*************************************************** 文件上传控件(可移动的上传组件对象) ******************************************/
//创建一个全局窗口数组对象用于管理全部窗口的添加于删除操作
function moveUploadFactory(){
	this.uploadFrameArray = new Array();//用于管理对象的数组
}
moveUploadFactory.prototype.addUploadWindow = function(upWindow){//添加窗口对象到数组中
	this.uploadFrameArray.push(upWindow);
};
moveUploadFactory.prototype.findUploadWindow = function(upWindow){//查询窗口对象是否在数组中
	for(var i=0;i<this.uploadFrameArray.length;i++){
		if(upWindow == this.uploadFrameArray[i].mWindow){
			return i;
		}
	}
	
	return null;
};
moveUploadFactory.prototype.clearWindow = function(upWindow){//清除某个窗口对象
	var clearNum = this.findUploadWindow(upWindow);
	if(clearNum != null){
		this.uploadFrameArray[clearNum].mWindow = null;//将窗口关闭
	}
};
moveUploadFactory.prototype.uploadSuccess = function(uploadId){//这个方法可以通过复写来实现重用操作
	var uploadObj = this.uploadFrameArray[uploadId];
	if(uploadObj.uploadFileName != ""){
		var nameObj = uploadObj.uploadFileName.split("\\");
		
		uploadObj.resultObj.elements["stage_file_up"].style.display = "none";
		uploadObj.resultObj.elements["stage_filed"].value = nameObj[nameObj.length-1];//显示文件名
	}else{
		uploadObj.resultObj.elements["stage_file_up"].style.display = "none";
		uploadObj.resultObj.elements["stage_filed"].value = null;
	}
};
moveUploadFactory.prototype.errorView = function(uploadId , str){
	this.uploadFrameArray[uploadId].errorView(str);
	this.uploadFrameArray[uploadId].reflashButtonEvent();//刷新submitEvent(刷新上传事件)
};
moveUploadFactory.prototype.resultView = function(uploadId , str){
	this.uploadFrameArray[uploadId].resultView(str);
	this.uploadFrameArray[uploadId].reflashButtonEvent();//刷新submitEvent(刷新上传事件)
	
	//将上传的文件名显示在页面上
	this.uploadSuccess(uploadId);
};


//可移动的文件上传框架(对于这个长处组件更改操作)
/*
 * uploadObj:需要添加上传组件的对象
 * upurl:上传的url
 * uploadTitle:文件上传组件名称
 * filetype:上传的文件类型
 * resultObj:用于结果的显示操作的对象
 * container:容器对象
 */
function moveUploadObj(uploadObj , upurl, uploadTitle, filetype, resultObj, container){
	this.uploadObj = uploadObj;
	this.upurl = upurl;
	this.uploadTitle = uploadTitle;
	this.filetype = filetype == null || undefined ? "file" : filetype;
	this.resultObj = resultObj;
	this.container = container;
	
	this.mWindow = null;
	this.uploadForm = null;//用于索引文件上传的form对象的
	this.errorInfor = null;//用于索引错误显示的对象
	this.submitEvent = false;//控制是否已产生上传事件
	this.uploadFileName = null;//用于保存上传的文件名
	
	//将创建的对象转载到数组中
	uploadFactory.addUploadWindow(this);
	loadScript_Css("css/BasicCss.css" , "css", null);
}
moveUploadObj.prototype.createView = function(){
	addEvent(this.uploadObj , "click", this.createNewUpload(this));
};
moveUploadObj.prototype.alterView = function(alertObj){//更改信息头部以及注册dblclick事件
	addEvent(alertObj , "dblclick", this.createNewUpload(this));
};
moveUploadObj.prototype.createNewUpload = function(upObj){
	return function(){
		if(upObj.mWindow == null){
			var event = window.event ? window.event : arguments[0];//arguments[0]:这个是用于保存事件对象的
			
			var upload_frame = document.createElement("div");
			upload_frame.className = "upload_file_frame";
			
			var frame_form = document.createElement("div");
			frame_form.className = "frame_form_view";
			
			upObj.uploadForm = document.createElement("form");
			upObj.uploadForm.target = "move_upload_iframe";
			upObj.uploadForm.className = "upload_form";
			upObj.uploadForm.enctype = "multipart/form-data";
			upObj.uploadForm.encoding = "multipart/form-data";//这个是用于解决IE中javascript动态设置enctype是无效的问题(在IE中需要设定为encoding = "multipart/form-data")
			upObj.uploadForm.method = "post";
			upObj.uploadForm.innerHTML = "<div class='input_frame'>"
								  +"<input type='file' name='upload_file_input' class='upload_file_input' hidefocus='hidefocus' name='project_file'/>"
		        				  +"<input type='text' name='invented_file_name' readonly/>"
		        				  +"<div class='select_upload'></div></div>"
		        				  +"<iframe style='display:none' name='move_upload_iframe'></iframe>"
		        				  +"<input type='button' name='file_send_submit' class='upload_submit' value='发送'/>";
		    
		    frame_form.appendChild(upObj.uploadForm);
			
			var frame_error = document.createElement("div");
			frame_error.className = "frame_error_view";
			
			upObj.errorInfor = document.createElement("span");
			upObj.errorInfor.id = "move_upload_error";
			upObj.errorInfor.className = "upload_error_infor";
			
			frame_error.appendChild(upObj.errorInfor);
			upload_frame.appendChild(frame_form);
			upload_frame.appendChild(frame_error);
			
			var titleClose = new Window_close();
			titleClose.close_Click = upObj.close_Click;//复写click方法
			//关闭了
			var title = new Window_titleview(null , null, new Window_title(upObj.uploadTitle), null, null, false, null, null, titleClose, null);//设置标题信息
			var frame = new Window_frame(320 , 70, (upObj.container.offsetHeight-70)/2, (upObj.container.offsetWidth-320)/2);
			
			upObj.mWindow = new moveWindow(frame , title, null, null, null, null, true, null, null, upObj.container);
			upObj.mWindow.create_View();
			upObj.mWindow.Win_view.add_Child(upload_frame);
			
			addEvent(upObj.uploadForm.elements["file_send_submit"] , "click", upObj.uploadFile(upObj));
			addEvent(upObj.uploadForm.elements["file_send_submit"] , "mouseover", upObj.submitOver);
			addEvent(upObj.uploadForm.elements["file_send_submit"] , "mouseout", upObj.submitOut);
			
			addEvent(upObj.uploadForm.elements["upload_file_input"] , "change", upObj.setUploadFileName(upObj.uploadForm));
		}
	};
};
moveUploadObj.prototype.setUploadFileName = function(uploadForm){
	return function(){
		uploadForm.elements["invented_file_name"].value = uploadForm.elements["upload_file_input"].value;
	}
};
moveUploadObj.prototype.close_Click = function(parentObj){
	return function(){  
		//判断当前上传窗口是否正在发送文件
		if(!uploadFactory.uploadFrameArray[uploadFactory.findUploadWindow(parentObj.getParentObj())].submitEvent){
			if(!parentObj.getParentObj().Win_closeC){
				parentObj.getParentObj().Win_cover.close_Cover();
			}
			
			uploadFactory.clearWindow(parentObj.getParentObj());
			parentObj.getParentObj().closeWindow();
		}
	};
};
moveUploadObj.prototype.uploadFile = function(upObj){
	return function(){
		if(upObj.upurl == null || undefined){
			
		}else{
			var uploadID = uploadFactory.findUploadWindow(upObj.mWindow);
			upObj.uploadForm.action = upObj.upurl+"&uploadID="+uploadID+"&oldFileName="+encodeURI(encodeURI(upObj.uploadFileName));//对中文进行16位加密
			
			if(upObj.filetype == "file" && !upObj.submitEvent && upObj.checkFileType(upObj.uploadForm)){
				upObj.submitEvent = true;
				
				upObj.resultView("文件正在上传请等待...");
				upObj.uploadFileName = upObj.getUploadFileName();//获取文件名
				upObj.uploadForm.submit();
			}else if(upObj.filetype == "picture" && !upObj.submitEvent && upObj.checkFileType(upObj.uploadForm)){
				upObj.submitEvent = true;
				
				upObj.resultView("图片正在上传请等待...");
				upObj.uploadFileName = upObj.getUploadFileName();
				upObj.uploadForm.submit();
			}
		}
	};
};
moveUploadObj.prototype.reflashButtonEvent = function(){//刷新控件事件锁定
	this.submitEvent = false;
};
moveUploadObj.prototype.checkFileType = function(uploadForm){//这个方法可以通过复写来实现不同文件格式的判断
	if(uploadForm.elements["upload_file_input"].value != "" && uploadForm.elements["invented_file_name"].value != ""){
		return true;
	}else{
		this.errorView("请输入需要上传的文件...");
		return false;
	}
};
moveUploadObj.prototype.resultView = function(str){
	this.errorInfor.style.color = "green";
	this.errorInfor.innerHTML = str;
	this.mWindow.setWindowHeight(90);
};
moveUploadObj.prototype.errorView = function(str){//文件格式问题
	this.errorInfor.style.color = "red";
	this.errorInfor.innerHTML = str;
	this.mWindow.setWindowHeight(90);
};
moveUploadObj.prototype.submitOver = function(){
	//this.style.background = "background:url(images/frame_button1.png)";
};
moveUploadObj.prototype.submitOut = function(){
	//this.style.background = "url(images/frame_button0.png)";
};
moveUploadObj.prototype.getUploadFileName = function(){//获取上传文件名称
	if(this.uploadForm.elements["invented_file_name"].value != ""){
		var nameObj = this.uploadForm.elements["invented_file_name"].value.split("\\");
		
		return nameObj[nameObj.length-1];//返回上传文件名
	}
};





/*----------------------------接下来是对于课拖拽的div对象属性设置--------------------------------*/
//这个是作为一个用于装载最小化窗口对象的模块
/* 
 * mindocument:这个是用于表示当前对象是在window||parent.window上
 * rangeObj:这个是用于表示当前的对象是显示在那个对象上面的(默认为当前页面的body对象上)
 */
function min_Windows(mindocument , rangeObj){
	this.mindocument = mindocument == null || undefined ? window : mindocument;
	this.rangeObj = rangeObj == null || undefined ? document.body : rangeObj;
	this.minWinframe = this.mindocument.document.createElement("div");//这个是一个用于存放全部对象的div框架
	
	//创建一个最小化管理队列
	this.create_View = function(){
		this.minWinframe.style.position = "fixed";
		this.minWinframe.style.height = "40px";
		this.minWinframe.style.zIndex = "9999";
		this.minWinframe.style.overflow = "hidden";
		//this.minWinframe.style.top = document.documentElement.clientHeight - 40 + "px";
		this.minWinframe.style.right = "0px";
		this.minWinframe.style.bottom = "0px";

		if(ifIE){
			this.minWinframe.style.styleFloat = "right";
		}else{
			this.minWinframe.style.cssFloat = "right";
		}
		
		this.rangeObj.appendChild(this.minWinframe);
	}
	
	//添加一个最小化窗口到队列中
	this.add_minWindow = function(minWin){
		this.minWinframe.appendChild(minWin);
	}

	//将最小化窗口对象移除队列
	this.remove_minWindow = function(minWin){
		this.minWinframe.removeChild(minWin);
	}
}

//关于父节点的引用以及方法的设置决定使用javascript的继承机制
//这样设置是为了子类向上访问父类对象
function Win_Object(){
	this.parentObj = null;
}
//设置元素对象的父节点
Win_Object.prototype.setParentObj = function(parentObj){
	this.parentObj = parentObj;
}
//得到该元素的父节点
Win_Object.prototype.getParentObj = function(){
	return this.parentObj;
}

//这个是作为一个窗口对象的副本引用
function old_moveWindow(mWindow){
	this.Win_frame = mWindow.Win_frame;//保存窗口对象
	this.Win_titleview = mWindow.Win_titleview;//保存标题对象
}

//定义窗口元素属性(这个是最上层的框架组件)
/*
 ************************** 还需要做一些完整性的操作处理解决(1.需要处理范围限定操作  2.对于最小化的对象的一些操作 3.对于cover对象的覆盖范围的大小修正) *************************
 * moveWindow(Win_frame , Win_titleview, Win_closeT, Win_view, Win_closeV, Win_cover, Win_closeC, Win_drag, Win_document, Win_container)
 * 创建一个总体的窗口对象(不添加参数则表示的是默认设置状态)
 * 继承对象Win_Object()
 * 对象属性-》》
 * Win_frame->>最外围的div对象用于转载全部对象可以使用new Window_frame()创建该对象 
 * Win_titleview->>用于管理窗口对象的头部信息包括（标题图标，信息内容，最小化，最大化，关闭按钮）默认new Window_titleview()
 * Win_closeT->>这个是用于管理该窗口标题对象是否关闭(默认false)
 * Win_view->>这个是用于管理提供编程人员的自由添加对象的一个接口(默认new Window_view())
 * Win_closeV->>这个是用于表示人员是否关闭该信息显示对象（默认false）
 * Win_cover->>这个是用于表示是否创建一个遮罩对象（默认new Window_cover()当前移动window是显示在遮罩对象上层的，当关闭cover对象后将显示在载入moveWindow对象的对象上层）
 * Win_closeC->>这个表示是否关闭该遮罩对象（默认false）
 * Win_drag->>这个表示的是对于窗口移动对象模式的确立(0:表示关闭功能 1：表示头部 2：表示全部对象（frame）默认1)
 * Win_document->>这个是用于表示当前容器所在的document对象（默认是window）
 * Win_container->>装载对象的对象容器对象(默认为Win_documen.document.body)
 * 
 * 对象功能-》》
 * closeWindow()关闭对象窗口也就从body中移除该对象
 * create_View()创建对象元素（例如.frame...）并且在窗口中显示出来
 * hideWindow()将窗口对象影藏起来而非关闭对象
 * displayWindow（）将影藏对象窗口显示处理
 * getMinWindow()创建最小化对象（通过判断对象是否存在可以实现创建，以及将影藏对象显示） 
 */
function moveWindow(Win_frame , Win_titleview, Win_closeT, Win_view, Win_closeV, Win_cover, Win_closeC, Win_drag, Win_document, Win_container){
	//这个是外围div
	this.Win_frame = Win_frame == null || undefined ? new Window_frame() : Win_frame;

	//这个表示title的全部信息
	this.Win_titleview = Win_titleview == null || undefined ? new Window_titleview() : Win_titleview;
	this.Win_closeT = Win_closeT == null || undefined ? false : Win_closeT;//是否关闭部件

	//这个是提供用户自己可设计的一个接口组件
	this.Win_view = Win_view == null || undefined ? new Window_view() : Win_view;
	this.Win_closeV = Win_closeV == null || undefined ? false : Win_closeV;
	
	//这个是用于表示当前容器所在的document对象
	this.Win_document = Win_document == null || undefined ? window : Win_document;
	//装载对象的对象容器对象
	this.Win_container = Win_container == null || undefined ? this.Win_document.document.body : Win_container;

	//这个是一个遮罩对象（用于遮罩处理）
	this.Win_cover = Win_cover == null || undefined ? new Window_cover(this.Win_document , this.Win_container) : Win_cover;
	this.Win_closeC = Win_closeC == null || undefined ? false : Win_closeC;

	//在这里添加一个元素的拖拽对象0:表示关闭功能 1：表示头部 2：表示全部对象（frame）
	this.Win_drag = Win_drag == null || undefined ? 1 : Win_drag;
	
	//拖拽对象移动参数设定
	this.Win_location = new DragWindowParam(0,0,false,false,this.Win_container.offsetWidth,this.Win_container.offsetHeight,false);

	//这个表示的是窗口最小化的对象
	this.Win_minframe = null;

	//在这里添加一个关于对于当前对象信息的一个副本对象
	this.Win_oldframe = null;//这个表示的是指副本对象
}
moveWindow.prototype = new Win_Object();//这个是实现使moveWindow对象继承Win_Object()对象
moveWindow.prototype.closeWindow = function(){//为组建添加一个关闭函数用于对于框架的关闭的控制
	//这个是判断当前对象是否含有影藏对象（假如存在也要将它去除）
	if(this.Win_oldframe != null){
		//关闭影藏对象(节约内存空间||这个假如是当前显示对象则也将删除掉)
		this.Win_container.removeChild(this.Win_oldframe.Win_frame.frame);
	}else{
		this.Win_container.removeChild(this.Win_frame.frame);
	}
	
	if(this.Win_minframe != null){
		all_minWindows.remove_minWindow(this.Win_minframe.frame);
	}

	this.Win_frame = null;
	this.Win_minframe = null;
};
moveWindow.prototype.installLocation = function(locationParam){//设置移动对象参数对象
	this.Win_location = locationParam;
};
moveWindow.prototype.achieveLocation = function(locationParam){//获取移动对象参数对象
	return this.Win_location;
};
moveWindow.prototype.installLimitX = function(limitX){//动态的设定对象的移动范围限定区域(X坐标)
	this.Win_location.limitX = limitX;
};
moveWindow.prototype.installLimitY = function(limitY){//动态的设定对象的移动范围限定区域(Y坐标)
	this.Win_location.limitY = limitY;
};
moveWindow.prototype.create_View = function(){//将组建拼装
	this.Win_frame.setParentObj(this);//添加一个父类对象引用
	this.Win_frame.create_View();
	
	if(!this.Win_closeT){
		this.Win_titleview.setParentObj(this);
		this.Win_frame.add_Child(this.Win_titleview.create_View());
	}
	
	if(!this.Win_closeV){
		this.Win_view.setParentObj(this);
		this.Win_frame.add_Child(this.Win_view.create_View());
		//this.Win_view.hiddenView();
	}
	
	
	if(!this.Win_closeC){
		this.Win_cover.create_View();
	}
	
	//this.Win_closeC ? document.body.appendChild(this.Win_frame.frame) : this.Win_cover.rangeObj.appendChild(this.Win_frame.frame);
	this.Win_container.appendChild(this.Win_frame.frame);
	
	if(this.Win_drag == 1){
		//默认的是title对象作为可拖拽的对象
		new MoveWinDrag(this.Win_titleview.titles , this.Win_frame.frame, this.Win_location, this).createView();
	}else if(this.Win_drag == 2){
		new MoveWinDrag(this.Win_frame.frame , this.Win_frame.frame, this.Win_location, this).createView();
	}
};
moveWindow.prototype.hiddenWin_view = function(){//为了解决当鼠标移动到iframe时产生iframe内部事件触发影响消除操作
	this.Win_view.hiddenView();
};
moveWindow.prototype.showWin_view = function(){//为了解决当鼠标移动到iframe时产生iframe内部事件触发影响消除操作
	this.Win_view.showView();
};
moveWindow.prototype.opacityWin_frame = function(opacity){//设置透明操作
	this.Win_frame.opacityFrame(opacity);
};
moveWindow.prototype.structWindow = function(){//这个是用于构建一个装好的移动模型但是还未添加
	this.Win_frame.setParentObj(this);//添加一个父类对象引用
	this.Win_frame.create_View();
	
	if(!this.Win_closeT){
		this.Win_titleview.setParentObj(this);
		this.Win_frame.add_Child(this.Win_titleview.create_View());
	}
	
	if(!this.Win_closeV){
		this.Win_view.setParentObj(this);
		this.Win_frame.add_Child(this.Win_view.create_View());
	}
};
moveWindow.prototype.getWindowWidth = function(){
	return this.Win_frame.fwidth;
};
moveWindow.prototype.setWindowWidth = function(width){//设置窗口的宽度
	this.Win_frame.setFrameWidth(width);
};
moveWindow.prototype.getWindowHeight = function(){
	return this.Win_frame.fheight;
};
moveWindow.prototype.setWindowHeight = function(height){//设置窗口的高度
	this.Win_frame.setFrameHeight(height);
};
moveWindow.prototype.hideWindow = function(){//实现窗口对象的影藏
	//装载对象的副本然后实现对象的影藏
	this.Win_oldframe = new old_moveWindow(this);
	this.Win_frame.frame.style.display = "none";
};
moveWindow.prototype.displayWindow = function(){//将隐藏窗口显示
	//接收隐藏对象
	if(this.Win_oldframe != null){
		this.Win_frame = this.Win_oldframe.Win_frame;
		this.Win_titleview = this.Win_oldframe.Win_titleview;
	}
	
	this.Win_frame.frame.style.display = "block";
	this.Win_minframe != null ? this.Win_minframe.frame.style.display = "none" : "";
};
moveWindow.prototype.getWindowX = function(){//得到元素对象的当前位置x轴坐标
	return this.Win_location.left;
};
moveWindow.prototype.getWindowY = function(){//得到元素对象的当前位置y轴坐标
	return this.Win_location.top;
};
moveWindow.prototype.setWindowX = function(location_X){//设置窗口对象x轴坐标
	this.Win_frame.setWindowX(location_X);
};
moveWindow.prototype.setWindowY = function(location_Y){//设置窗口对象y轴坐标
	this.Win_frame.setWindowY(location_Y);
};
moveWindow.prototype.getMinWindow = function(){//得到该窗口的最小化模式
	//判断当前是否存在最小化对象（假如不存在则创建一个新的对象）
	if(this.Win_minframe == null){
		this.Win_minframe = new Window_frame(150 , 30, 0, 0, null, "yellow", "relative", "min_Window" , 0);
		this.Win_minframe.setParentObj(this);//为当前对象设置对于其父对象的引用
		this.Win_minframe.create_View();
		this.Win_frame = this.Win_minframe;
		
		var minTitle = new Window_titleview(null , null, null , null, null , null, null , null, null , null, "#EFEFEF");
		minTitle.setParentObj(this);
		minTitle.Win_titleimg = new Window_titleimg();
		minTitle.Win_titleimg.setParentObj(minTitle);
		minTitle.Win_titleimg.tisrc = this.Win_titleview.Win_titleimg.tisrc;
		minTitle.create_timage = this.Win_titleview.create_timage;
		
		//minTitle.Win_title = this.Win_titleview.Win_title;
		minTitle.Win_title = new Window_title();
		minTitle.Win_title.setParentObj(minTitle);
		minTitle.Win_title.ttext = this.Win_titleview.Win_title.ttext;
		minTitle.create_ttitle = this.Win_titleview.create_ttitle;
		
		minTitle.create_tmin = false;
		minTitle.Win_max = this.Win_titleview.Win_max;
		minTitle.create_tmax = true;
		
		//minTitle.Win_close = this.Win_titleview.Win_close;
		minTitle.Win_close = new Window_close();
		minTitle.Win_close.setParentObj(minTitle);
		minTitle.create_tclose = this.Win_titleview.create_tclose;
		minTitle.setParentObj(this);

		this.Win_frame.add_Child(minTitle.create_View());
		minTitle.Win_title.target.title = minTitle.Win_title.ttext;//为div添加一个title属性
		
		if(all_minWindows == null){
			all_minWindows = new min_Windows(this.Win_cover.cover_document , this.Win_cover.rangeObj);//创建一个保存最小化对象的队列	
			all_minWindows.create_View();
			all_minWindows.add_minWindow(this.Win_frame.frame);
		}else{
			all_minWindows.add_minWindow(this.Win_frame.frame);
		}
	}else{
		this.Win_frame = this.Win_minframe;
		this.Win_frame.frame.style.display = "block";
	}
};


/*
 * 这个是一个窗口对象用于保存装载的头部等信息
 * Window_frame(fwidth , fheight, ftop, fleft, fborder, fimage, fposition, ftype, fzindex)
 * 继承对象-》》Win_Object();
 * 对象属性-》》
 * fwidth->>窗口对象的宽度（默认：450px）
 * fheight->>窗口对象的长度（默认：300px）
 * ftop->>窗口对象的位置top（默认：200px）
 * fleft->>窗口对象的位置left（默认：400px）
 * fborder->>窗口对象的外围边框的设置（默认：5px solid #c4c4c4）
 * fimage->>窗口对象的背景的设置（默认：white）
 * fposition->>窗口对象的位置模式：absolute（默认.绝对定位）,relative（相对定位）,fixed（固定定位）
 * ftype->>窗口对象的显示模式：Window窗口模式（默认）,min_Window(最小化模式)
 * fzindex->>窗口对象的屏幕显示（垂直高度）zIndex(默认：9999)
 * fclass->>确认是否使用定义的className样式(默认：true)
 * 
 * 对象的功能函数
 * create_View()该函数用于将对象属性装载到对象中通过ftype判断显示对象的模式(窗口模式，还是最小化模式)
 * add_Child()该函数实现对该对象添加新的子对象
 * 这个是一个框架信息由：宽度，长度，上边距，左边距，边框, 背景图片, 相对位置关系, 框架类型, 对象的zIndex
 */
var window_zIndex = 9999;//这个使用与控制对象的zIndex属性（方便后期多个窗口能够显示在最上层操作处理）
function Window_frame(fwidth , fheight, ftop, fleft, fborder, fimage, fposition, ftype, fzindex, fclass){
	this.fwidth = fwidth == null || undefined ? 450 : fwidth;
	this.fheight = fheight == null || undefined ? 300 : fheight;
	this.ftop = ftop == null || undefined ? 200 : ftop;
	this.fleft = fleft == null || undefined ? 400 : fleft;
	this.fborder = fborder == null || undefined ? "5px solid #C4C4C4" : fborder;
	this.fimage = fimage == null || undefined ? "white" : fimage;
	this.fposition = fposition == null || undefined ? "absolute" : fposition;
	this.ftype = ftype == null || undefined ? "Window" : ftype;//Window:正常窗口模式,min_Window:最小化窗口对象
	this.fzindex = fzindex == null || undefined ? window_zIndex++ : fzindex;
	this.fclass = fclass == null || undefined ? true : fclass;
	
	this.frame = null;//document.createElement("div");
}
Window_frame.prototype = new Win_Object();
Window_frame.prototype.create_View = function(){
	this.frame = this.parentObj.Win_document.document.createElement("div");
	this.frame.style.overflow = "hidden";
	this.frame.style.border = this.fborder;
	this.frame.style.width = this.fwidth+"px";
	this.frame.style.height = this.fheight+"px";
	this.frame.style.zIndex = this.fzindex;
	this.frame.style.background = this.fimage;
	this.frame.style.position = this.fposition;
	if(this.fclass){
		this.frame.style.borderRadius = "5px";
		this.frame.style.boxShadow = "2px 2px 2px #000";
	}

	if(this.ftype == "Window"){
		this.frame.style.top = this.ftop+"px";
		this.frame.style.left = this.fleft+"px";
	}else if(this.ftype == "min_Window"){//最小化窗口对象
		this.frame.style.marginLeft = "2px";
		if(ifIE){
			this.frame.style.styleFloat = "right";
		}else{
			this.frame.style.cssFloat = "right";
		}
	}
	
};
Window_frame.prototype.setFrameWidth = function(width){//设置宽度(动态的)
	this.fwidth = width;
	this.frame.style.width = this.fwidth + "px";
};
Window_frame.prototype.setFrameHeight = function(height){//设置高度
	this.fheight = height;
	this.frame.style.height = this.fheight + "px";
};
Window_frame.prototype.hiddenView = function(){//影藏对象显示组件
	this.frame.style.display = "none";
};
Window_frame.prototype.showView = function(){//显示影藏对象组件
	this.frame.style.display = "block";
};
Window_frame.prototype.setWindowX = function(location_X){//设置窗口的位置X坐标
	this.frame.style.left = location_X+"px";
};
Window_frame.prototype.setWindowY = function(location_Y){//设置窗口的位置Y坐标
	this.frame.style.top = location_Y+"px";
};
Window_frame.prototype.opacityFrame = function(wopacity){//实现将对象模糊操作
	var win_opacity = wopacity == null || undefined ? 0 : wopacity;

	this.frame.style.opacity = win_opacity;
	this.frame.style.filter = "alpha(opacity="+win_opacity*100+")";
};
Window_frame.prototype.add_Child = function(obj){
	this.frame.appendChild(obj);
};

/*
 * 显示全部窗口对象的信息包括图标，标题信息，最小化按钮，关闭按钮，最大化按钮
 * Window_titleview(Win_titleimg , create_timage, Win_title, create_ttitle,Win_min, create_tmin, Win_max, create_tmax, Win_close, create_tclose, titlebg)
 * Window_titleview
 * 继承对象-》Win_Object()
 * 对象属性-》》
 * Win_titleimg-》添加标题图标（默认为：new Window_titleimg()）
 * create_timage-》是否显示标题图标（默认为：true）；
 * Win_title-》添加标题信息（默认为：new Window_title()）
 * create_ttitle-》是否显示标题信息（默认为：true）
 * Win_min-》添加最小化按钮（默认为：new Window_min()）
 * create_tmin-》是否显示最小化按钮（默认为：true）
 * Win_max-》最大化按钮（默认为：new Window_max()）
 * create_tmax-》是否显示最大化按钮（默认为：false）
 * Win_close-》添加关闭按钮（默认为：new Window_close()）
 * create_tclose-》是否显示关闭按钮（默认为：true）
 * titlebg-》当前窗口标题的背景颜色（默认为：white）
 *
 * 对象功能函数-》》
 * create_View()该函数实现将对象的属性信息装载到对象元素中，然后返回一个div对象
 */
//function Window_titleview(){};undefined是一个对象状态
function Window_titleview(Win_titleimg , create_timage, Win_title, create_ttitle,
Win_min, create_tmin, Win_max, create_tmax, Win_close, create_tclose, titlebg){
	/*这些都是titleview中的子类*/
	//窗口标志
	this.Win_titleimg = Win_titleimg == null || undefined ? new Window_titleimg() : Win_titleimg;
	this.create_timage = create_timage == null || undefined ? true : create_timage;
	
	//标题
	this.Win_title = Win_title == null || undefined ? new Window_title() : Win_title;
	this.create_ttitle = create_ttitle == null || undefined ? true : create_ttitle;

	//最小化按钮
	this.Win_min = Win_min == null || undefined ? new Window_min() : Win_min;
	this.create_tmin = create_tmin == null || undefined ? true : create_tmin;
	
	//最大化按钮
	this.Win_max = Win_max == null || undefined ? new Window_max() : Win_max;
	this.create_tmax = create_tmax == null || undefined ? false : create_tmax;

	//关闭按钮(这些按钮的事件处理都是分装好的无法更改)
	this.Win_close = Win_close == null || undefined ? new Window_close() : Win_close;
	this.create_tclose = create_tclose == null || undefined ? true : create_tclose;

	//背景颜色
	this.titlebg = titlebg == null || undefined ? "white" : titlebg;

	//标题框架对象
	this.titles = null;//document.createElement("div");
}
Window_titleview.prototype = new Win_Object();//继承父类对象属性以及方法
//为对象添加一个显示对象的方法
Window_titleview.prototype.create_View = function(){
	this.titles = this.parentObj.Win_document.document.createElement("div");
	this.titles.style.height = "30px";
	this.titles.style.background = this.titlebg;
	this.titles.style.overflow = "hidden";
	this.titles.style.borderBottom = "1px solid #486b02";
	this.titles.style.cursor = "move";
	
	/*
	 * 在该元素中添加子元素对象
	 * 同时添加一个父对象的引用
	 */
	 
	if(this.create_timage){
		//设置该元素的父类对象
		this.Win_titleimg.setParentObj(this);
		this.titles.appendChild(this.Win_titleimg.create_View());
	}

	if(this.create_ttitle){
		this.Win_title.setParentObj(this);
		this.titles.appendChild(this.Win_title.create_View());
	}

	if(this.create_tclose){
		this.Win_close.setParentObj(this);
		this.titles.appendChild(this.Win_close.create_View());
	}
	
	if(this.create_tmax){
		this.Win_max.setParentObj(this);
		this.titles.appendChild(this.Win_max.create_View());
	}

	if(this.create_tmin){
		this.Win_min.setParentObj(this);
		this.titles.appendChild(this.Win_min.create_View());
	}

	return this.titles;
};
Window_titleview.prototype.alterTitleText = function(titleText){//更改标题
	this.Win_title.alterTitleText(titleText);
};


/*
 * 窗口标题信息
 * Window_title(ttext)
 * 继承对象-》》Win_Object()
 * 对象属性-》》
 * ttext->>标题显示的内容（默认："这个是title信息"）
 *
 * 对象的功能函数
 * create_View->>创建对象模式(设置对象的基本信息保存到div中)返回一个div对象
 */
function Window_title(ttext){
	this.ttext = ttext == null || undefined ? "这个是title信息" : ttext;
	this.target = null;//document.createElement("div");
}
Window_title.prototype = new Win_Object();//继承窗口的父节点
Window_title.prototype.create_View = function(){
	this.target = this.parentObj.getParentObj().Win_document.document.createElement("div");
	/*
	 * 这个也是IE与Firefox的一个严重的bug在IE中设置float属性要使用style.styleFloat
	 * 而在Firefox中则要使用style.cssFloat来设置这个float属性(所以先要对浏览器进行检验)
	 */
	if(ifIE){
		this.target.style.styleFloat = "left";
	}else{
		this.target.style.cssFloat = "left";
	}
	//this.target.style.width = "70%";
	//使用自动的计算出当前的显示标题的大小宽度
	this.target.style.width = this.parentObj.getParentObj().Win_frame.fwidth - 70 +"px";
	this.target.style.overflow = "hidden";
	this.target.style.marginTop = "3px";
	this.target.style.fontSize = "12px";
	this.target.style.fontWeight = "bold";
	this.target.style.textIndent = "4px";//字符缩进
	this.target.style.lineHeight = "24px";
	this.target.style.textOverflow = "ellipsis";
	this.target.style.overflow = "hidden";
	this.target.style.whiteSpace = "nowrap";
	this.target.innerHTML = this.ttext;

	return this.target;
};
Window_title.prototype.alterTitleText = function(titleText){//更改头部信息内容
	this.target.innerHTML = titleText;
};


/*
 * 这个是用于创建一个标题图案
 * Window_titleimg(tisrc)
 * 继承对象-》》Win_Object()
 * 对象属性-》》
 * tisrc->>这个表示的当前图像的路径（默认：image/title.png）
 *
 * 对象的功能函数
 * create_View->>将对象的信息保存到div对象中（返回一个div对象）
 */
function Window_titleimg(tisrc){
	this.tisrc = tisrc == null || undefined ? "image/win_title.png" : tisrc;
	this.target = null;//document.createElement("img");
}
Window_titleimg.prototype = new Win_Object();
Window_titleimg.prototype.create_View = function(){
	this.target = this.parentObj.getParentObj().Win_document.document.createElement("img");
	if(ifIE){
		this.target.style.styleFloat = "left";
	}else{
		this.target.style.cssFloat = "left";
	}

	this.target.style.width = "25px";//这个使用固化的具体大小定位(不能更改)
	this.target.style.height = "25px";
	this.target.style.marginLeft = "3px";
	this.target.style.marginTop = "3px";
	this.target.src = this.tisrc;

	return this.target;
}


/*
 * 这个是对于关闭按钮的设置
 * Window_close(clickImage , overImage, outImage)
 * 继承对象-》》Win_Object()
 * 对象属性-》
 * clickImage->点击时更改的图标样式（默认："url(image/talkclose.png) no-repeat"）
 * overImage->当鼠标移动到关闭按钮对象上时将图标样式更改（默认："url(image/talkclose1.png) no-repeat"）
 * outImage->当鼠标离开关闭按钮对象时将图标样式刚改（默认："url(image/talkclose.png) no-repeat"）；
 * 
 * 对象的功能函数-》》
 * create_View()将对象的设置信息保存到当前close对象的属性中(返回对象的引用)
 * close_Click()当点击事件发生时触发功能函数（程序员可以通过重写close_Click()函数来实现特定的关闭时触发的功能）
 * close_Over()当鼠标移动到对象上时触发功能函数（程序员可以重写该方法）
 * close_Out()当鼠标移出对象时触发功能函数（程序员可以重写该方法）
 */
function Window_close(clickImage , overImage, outImage){
	//这个是点击时的图像标志
	this.clickImage = clickImage == null || undefined ? "url(image/talkclose.png) no-repeat" : clickImage;
	this.overImage = overImage == null || undefined ? "url(image/talkclose1.png) no-repeat" : overImage;
	this.outImage = outImage == null || undefined ? "url(image/talkclose.png) no-repeat" : outImage;
	this.target = null;//document.createElement("div");
	loadScript_Css("css/BasicCss.css" , "css", null);
}
Window_close.prototype = new Win_Object();
//这个实现的是这些信息的装载以及事件的注册实现
Window_close.prototype.create_View = function(){
	this.target = this.parentObj.getParentObj().Win_document.document.createElement("div");
	this.target.className = "window_close_out";
	this.target.title = "关闭";
	if(ifIE){
		this.target.style.styleFloat = "right";
	}else{
		this.target.style.cssFloat = "right";
	}

	//可以使用attachEvent或者addEvenetListener来为对象添加事件（使用这种方法可以对函数添加参数不然无法为事件调用函数添加参数）
	addEvent(this.target , "click", this.close_Click(this.parentObj));//点击事件
	addEvent(this.target , "mouseout", this.close_Out(this));//移出事件
	addEvent(this.target , "mouseover", this.close_Over(this));//移入事件事件

	return this.target;
}
//这个是一个相当重要的一个特点必需要记住（关于在对象事件函数中添加处理参数的方式,因为对于事件绑定函数中使用的this指的是触发该事件的对象元素所以无法调用特定对象所以使用这个方法）
Window_close.prototype.close_Click = function(parentObj){
	//这个相当于点击事件发生时返回一个function对象来处理该数据
	return function(){  
		//判断该对象是否打开了遮罩层
		if(!parentObj.getParentObj().Win_closeC){
			parentObj.getParentObj().Win_cover.close_Cover();
		}
		
		parentObj.getParentObj().closeWindow();
	}
}
Window_close.prototype.close_Out = function(paramObj){
	return function(){
		paramObj.target.className = "window_close_out";
	}
}
Window_close.prototype.close_Over = function(paramObj){
	return function(){
		paramObj.target.className = "window_close_over";
	}
}

/*
 * 这个是对于最小化按钮的设置
 * Window_min(clickImage , overImage, outImage)
 * 继承对象-》》Win_Object()
 * 对象属性-》
 * clickImage->点击时更改的图标样式（默认："url(image/talkmin.png) no-repeat"）
 * overImage->当鼠标移动到关闭按钮对象上时将图标样式更改（默认："url(image/talkmin1.png) no-repeat"）
 * outImage->当鼠标离开关闭按钮对象时将图标样式刚改（默认："url(image/talkmin.png) no-repeat"）；
 * 
 * 对象的功能函数-》》
 * create_View()将对象的设置信息保存到当前target对象的属性中(返回对象的引用)
 * min_Click()当点击事件发生时触发功能函数（程序员可以通过重写min_Click()函数来实现特定的关闭时触发的功能）
 * min_Over()当鼠标移动到对象上时触发功能函数（程序员可以重写该方法）
 * min_Out()当鼠标移出对象时触发功能函数（程序员可以重写该方法）
 */
function Window_min(clickImage , overImage, outImage){
	this.clickImage = clickImage == null || undefined ? "url(image/talkmin.png) no-repeat" : clickImage;
	this.overImage = overImage == null || undefined ? "url(image/talkmin1.png) no-repeat" : overImage;
	this.outImage = outImage == null || undefined ? "url(image/talkmin.png) no-repeat" : outImage;
	this.target = null;//document.createElement("div");
	loadScript_Css("css/BasicCss.css" , "css", null);
}
Window_min.prototype = new Win_Object();
//这个实现的是这些信息的装载以及事件的注册实现
Window_min.prototype.create_View = function(){
	this.target = this.parentObj.getParentObj().Win_document.document.createElement("div");
	this.target.className = "window_min_out";
	this.target.title = "最小化";
	if(ifIE){
		this.target.style.styleFloat = "right";
	}else{
		this.target.style.cssFloat = "right";
	}

	addEvent(this.target , "click", this.min_Click(this.parentObj));
	addEvent(this.target , "mouseover", this.min_Over(this));
	addEvent(this.target , "mouseout", this.min_Out(this));

	return this.target;
}
//添加对于最小化窗口的事件处理(最小化决定使用一个提示框在最下角上)
Window_min.prototype.min_Click = function(parentObj){
	return function(){
		//这个需要实现的是将最小化的对象显示在屏幕的最后下角
		parentObj.getParentObj().hideWindow();//调用总对象关闭窗口

		//创建一个最小化对象
		parentObj.getParentObj().getMinWindow();
	}
}
Window_min.prototype.min_Over = function(paramObj){
	return function(){
		paramObj.target.className = "window_min_over";
	}
}
Window_min.prototype.min_Out = function(paramObj){
	return function(){
		paramObj.target.className = "window_min_out";
	}
}


/*
 * 这个是对于最大化按钮的设置
 * Window_max(clickImage , overImage, outImage)
 * 继承对象-》》Win_Object()
 * 对象属性-》
 * clickImage->点击时更改的图标样式（默认："url(image/window_max.png) no-repeat"）
 * overImage->当鼠标移动到关闭按钮对象上时将图标样式更改（默认："url(image/window_max1.png) no-repeat"）
 * outImage->当鼠标离开关闭按钮对象时将图标样式刚改（默认："url(image/window_max.png) no-repeat"）；
 * 
 * 对象的功能函数-》》
 * create_View()将对象的设置信息保存到当前target对象的属性中(返回对象的引用)
 * max_Click()当点击事件发生时触发功能函数（程序员可以通过重写max_Click()函数来实现特定的关闭时触发的功能）
 * max_Over()当鼠标移动到对象上时触发功能函数（程序员可以重写该方法）
 * max_Out()当鼠标移出对象时触发功能函数（程序员可以重写该方法）
 */
function Window_max(clickImage , overImage, outImage){
	this.clickImage = clickImage == null || undefined ? "url(image/window_max.png) no-repeat" : clickImage;
	this.overImage = overImage == null || undefined ? "url(image/window_max1.png) no-repeat" : overImage;
	this.outImage = outImage == null || undefined ? "url(image/window_max.png) no-repeat" : outImage;
	this.target = null;//document.createElement("div");
	loadScript_Css("css/BasicCss.css" , "css", null);
}
Window_max.prototype = new Win_Object();
//这个实现的是这些信息的装载以及事件的注册实现
Window_max.prototype.create_View = function(){
	this.target = this.parentObj.getParentObj().Win_document.document.createElement("div");
	this.target.className = "window_max_out";
	this.target.title = "最大化";
	if(ifIE){
		this.target.style.styleFloat = "right";
	}else{
		this.target.style.cssFloat = "right";
	}

	addEvent(this.target , "click", this.max_Click(this.parentObj));
	addEvent(this.target , "mouseover", this.max_Over(this));
	addEvent(this.target , "mouseout", this.max_Out(this));

	return this.target;
}
//实现最大化的显示框架对象
Window_max.prototype.max_Click = function(parentObj){
	return function(){
		parentObj.getParentObj().displayWindow();
	}
}
Window_max.prototype.max_Over = function(paramObj){
	return function(){
		paramObj.target.className = "window_max_over";
	}
}
Window_max.prototype.max_Out = function(paramObj){
	return function(){
		paramObj.target.className = "window_max_out";
	}
}


/*
 * 这个是用于对于用户自定义的那一部分的信息设计的模式
 * Window_view()
 * 继承对象-》Win_Object()
 * 
 * 对象的功能函数
 * create_View()->>将对象的属性转载到对象中然后提返回一个div对象
 * add_Child()->>这个是为程序员提供一个接口用于装载子元素到该对象中去
 */
function Window_view(view){
	this.view = view;//document.createElement("div");
}
Window_view.prototype = new Win_Object();
Window_view.prototype.create_View = function(){
	if(this.view == (null || undefined)){
		this.view = this.parentObj.Win_document.document.createElement("div");
		this.view.style.width = "100%";
		this.view.style.margin = "0 auto";
	}
	
	return this.view;
};
Window_view.prototype.add_Child = function(obj){
	this.view.appendChild(obj);
};
Window_view.prototype.remove_Child = function(obj){//删除对象
	this.view.removeChild(obj);
};
Window_view.prototype.hiddenView = function(){//隐藏对象操作
	this.view.style.display = "none";
};
Window_view.prototype.showView = function(){//显示对象操作
	this.view.style.display = "block";
};

/*
 * 创建一个遮罩对象（这个是一个相对独立的一个对象）
 * Window_cover(rangeObj ,cwidth , cheight, cimage, cposition, insize)
 * 对象属性-》》
 * cover_document->这个是用于标记当前的文档对象是window.document||parent.document
 * rangeObj->需要覆盖的对象(这个是相当重要的这个是用于表示当前的遮罩对象是相对于哪个对象的上层)
 * cwidth->遮罩对象的宽度（默认为：网页body的宽度）
 * cheight->遮罩对象的高度（默认为：网页body的高度）
 * cimage->遮罩对象的背景颜色（默认为：#777）
 * cposition->遮罩对象的定位模式（默认为：absolute绝对定位）
 * insize->这个表示的是是否使用用户自定义的框架大小也就是cwidth,cheight（默认为：false）
 * 
 * 对象的功能函数-》》
 * create_View()-》将对象的属性信息导入到对象中最后使用appendChild将对象装载到网页中去
 * close_Cover()-》将对象从网页中去除实现关闭遮罩对象
 */
function Window_cover(cover_document , rangeObj, cwidth, cheight, cimage, cposition, insize){
	this.cover_document = cover_document == null || undefined ? window : cover_document;
	this.rangeObj = rangeObj == null || undefined ? document.body : rangeObj;//需要覆盖的对象
	this.cwidth = cwidth == null || undefined ? this.rangeObj.clientWidth : cwidth;//大小
	this.cheight = cheight == null || undefined ? this.rangeObj.clientHeight : cheight;
	this.cimage = cimage == null || undefined ? "#777" : cimage;
	this.cposition = cposition == null || undefined ? "absolute" : cposition;//对于这个组件设置定位模式
	this.insize = insize == null || undefined ? false : insize;//是否使用固定大小（也就是使用设置的大小）
	
	this.cover = this.cover_document.document.createElement("div");

	this.create_View = function(){
		//得到浏览器的大小
		var win_height = this.cover_document.document.body.clientHeight || this.cover_document.document.documentElement.clientHeight;
		var win_width = this.cover_document.document.body.clientWidth || this.cover_document.document.documentElement.clientWidth;
	
		if(!this.insize){
			//不使用固定大小(有系统自动分配)
			this.cover.style.width = this.cwidth < win_width ? win_width+"px" : this.cwidth+"px";
			this.cover.style.height = this.cheight < win_height ? win_height+"px" : this.cheight+"px";
		}else{
			//使用自己设定的遮罩大小
			this.cover.style.width = this.cwidth+"px";
			this.cover.style.height = this.cheight+"px";
		}
		this.cover.style.position = this.cposition;
		this.cover.style.top = "0";
		this.cover.style.left = "0";
		this.cover.style.background = this.cimage;
		this.cover.style.opacity = 0.5;
		this.cover.style.filter = "alpha(opacity=50)";
		this.cover.style.zIndex = "1000";
		
		//parent.document.createElement("div")
		this.rangeObj.appendChild(this.cover);
		//this.rangeObj == document.body ? document.body.appendChild(this.cover) : this.rangeObj.appendChild(this.cover);
	};

	this.close_Cover = function(){
		if(this.cover != null){
			//this.rangeObj == document.body ? document.body.removeChild(this.cover) : this.rangeObj.removeChild(this.cover);
			this.rangeObj.removeChild(this.cover);
			
			this.cover = null;
		}
	};
	
	this.hiddenView = function(){//隐藏遮罩对象
		this.cover.style.display = "none";
	};
	
	this.showView = function(){//显示遮罩对象
		this.cover.style.display = "block";
	}
}


/*-------------------------对于移动的处理------------------------*/
//旧的移动对象(用于保存当前对象的上一个位置)
function DragWindowParam(left , top, lockX, lockY, limitX, limitY, flag){
	this.left = left == null || undefined ? 0 : left;
	this.top = top == null || undefined ? 0 : top;
	this.lockX = lockX == null || undefined ? false : lockX;
	this.lockY = lockY == null || undefined ? false : lockY;
	this.limitX = limitX == null || undefined ? document.body.offsetWidth : limitX;
	this.limitY = limitY == null || undefined ? document.body.offsetHeight : limitY;
	this.flag = flag == null || undefined ? false : flag;
}


//移动窗口对象的移动参数设定
/*
 * 拖拽功能的实现drag_obj允许拖拽的部分,obj拖拽对象
 * MoveWinDrag(drag_obj , obj)
 * 对象属性-》
 * drag_obj-》拖拽对象的允许拖拽的部分
 * obj-》当前可移动的退拽对象
 * param-》移动参数对象
 * winObj-》整个窗口对象元素(就是moveWindow对象)
 * 
 * 对象触发事件-》
 * onmousedown-》当发生该事件时将得到事件触发的位置
 * onmouseup-》当鼠标离开对象时触发事件
 * onmousemove-》当鼠标移动是发生事件
 */
function MoveWinDrag(drag_obj , obj, param, winObj){
	this.drag_obj = drag_obj;
	this.obj = obj;
	this.param = param;
	this.winObj = winObj;
	
	//这个设定是为了方便于document的事件注册
	this.mousedown = this.dragMouseDown(this);
	this.mouseup = this.dragMouseUp(this);
	this.mousemove = this.dragMouseMove(this);
}
MoveWinDrag.prototype.createView = function(){
	addEvent(this.drag_obj , "mousedown", this.mousedown);
	addEvent(this.drag_obj , "mouseup", this.mouseup);
	addEvent(this.drag_obj , "mousemove", this.mousemove);
};
//需要处理的操作是当鼠标按下后进入移动状态时（创建一个覆盖这个frame对象的一个div对象）
MoveWinDrag.prototype.dragMouseDown = function(dragWin){//鼠标按下事件
	return function(){
		var event = dragWin.winObj.Win_document.event ? dragWin.winObj.Win_document.event : arguments[0];
		
		dragWin.drag_obj.style.cursor = "move"; //设置鼠标样式
		dragWin.obj.style.zIndex = window_zIndex++;
		
		dragWin.param.left = event.clientX - dragWin.obj.offsetLeft;//记录鼠标相对于拖拽对象的位置
		dragWin.param.top = event.clientY - dragWin.obj.offsetTop;
		
		dragWin.param.flag = true;
		
		//注意要绑定到document才可以保证事件在整个窗口文档中都有效，如果只绑定到拖放对象就很容易出现拖太快就脱节的现象。
		addEvent(dragWin.winObj.Win_document.document, "mousemove", dragWin.mousemove);
		addEvent(dragWin.winObj.Win_document.document, "mouseup", dragWin.mouseup);
		
		dragWin.winObj.hiddenWin_view();//隐藏iframe对象
		dragWin.winObj.opacityWin_frame(0.6);
		
		//关闭屏蔽页面的选择操作
		dragWin.winObj.Win_document.document.body.style.webkitUserSelect="none"//chrome	
		dragWin.winObj.Win_document.document.body.unselectable="none"//IE
		dragWin.winObj.Win_document.document.body.style.MozUserSelect="none"//firefox
	};
};
MoveWinDrag.prototype.dragMouseUp = function(dragWin){//鼠标放开事件
	return function(){
		dragWin.param.flag = false;	
		
		dragWin.param.left = dragWin.obj.offsetLeft;
		dragWin.param.top = dragWin.obj.offsetTop;
		
		removeEventHandler(dragWin.winObj.Win_document.document, "mousemove", dragWin.mousemove);
		removeEventHandler(dragWin.winObj.Win_document.document, "mouseup", dragWin.mouseup);
		
		dragWin.winObj.showWin_view();//显示iframe对象
		dragWin.winObj.opacityWin_frame(1);
		
		//开启屏蔽页面的选择操作
		dragWin.winObj.Win_document.document.body.style.webkitUserSelect=""//chrome	
		dragWin.winObj.Win_document.document.body.unselectable=""//IE
		dragWin.winObj.Win_document.document.body.style.MozUserSelect=""//firefox
	};
};
MoveWinDrag.prototype.dragMouseMove = function(dragWin){//鼠标移动事件
	return function(){
		var event = dragWin.winObj.Win_document.event ? dragWin.winObj.Win_document.event : arguments[0];
		if(dragWin.param.flag){
			//清除对象选择操作
			dragWin.winObj.Win_document.getSelection ? dragWin.winObj.Win_document.getSelection().removeAllRanges() : dragWin.winObj.Win_document.document.selection.empty();
			
			var disX = event.clientX - dragWin.param.left;
			var disY = event.clientY - dragWin.param.top;
			
			disX = Math.max(Math.min(disX, dragWin.param.limitX - dragWin.obj.offsetWidth), 0);
       		disY = Math.max(Math.min(disY, dragWin.param.limitY - dragWin.obj.offsetHeight), 0);
			
			!dragWin.param.lockX ? dragWin.obj.style.left = disX + "px" : "";
			dragWin.obj.style.top = disY + "px";
		}
	};
};



/*
 * 拖拽功能的实现drag_obj允许拖拽的部分,obj拖拽对象(这个是用于人手动的为对象添加移动事件对象)
 * windowDrag(drag_obj , obj)
 * 对象属性-》
 * drag_obj-》拖拽对象的允许拖拽的部分
 * obj-》当前可移动的退拽对象
 * documentObj-》文档对象(这个对象有可以是window.document | parent.document->为了解决关于IE无法添加子页面对象处理以及对于事件选择取消操作锁定)
 * 对象触发事件-》
 * onmousedown-》当发生该事件时将得到事件触发的位置
 * onmouseup-》当鼠标离开对象时触发事件
 * onmousemove-》当鼠标移动是发生事件
 */
function windowDrag(drag_obj , obj, param, documentObj){
	this.drag_obj = drag_obj;
	this.obj = obj;
	this.param = param;
	this.documentObj = documentObj;
	
	//这个设定是为了方便于document的事件注册
	this.mousedown = this.dragMouseDown(this);
	this.mouseup = this.dragMouseUp(this);
	this.mousemove = this.dragMouseMove(this);
}
windowDrag.prototype.createView = function(){
	addEvent(this.drag_obj , "mousedown", this.mousedown);
	addEvent(this.drag_obj , "mouseup", this.mouseup);
	addEvent(this.drag_obj , "mousemove", this.mousemove);
};
//需要处理的操作是当鼠标按下后进入移动状态时（创建一个覆盖这个frame对象的一个div对象）
windowDrag.prototype.dragMouseDown = function(dragWin){//鼠标按下事件
	return function(){
		var event = window.event ? window.event : arguments[0];
		
		dragWin.param.left = event.clientX - dragWin.obj.offsetLeft;//记录鼠标相对于拖拽对象的位置
		dragWin.param.top = event.clientY - dragWin.obj.offsetTop;
		
		dragWin.param.flag = true;
		
		//注意要绑定到document才可以保证事件在整个窗口文档中都有效，如果只绑定到拖放对象就很容易出现拖太快就脱节的现象。
		addEvent(document, "mousemove", dragWin.mousemove);
		addEvent(document, "mouseup", dragWin.mouseup);
		//addEvent(window, "blur", dragWin.mouseup);
		
		//关闭屏蔽页面的选择操作
		document.body.style.webkitUserSelect="none"//chrome	
		document.body.unselectable="none"//IE
		document.body.style.MozUserSelect="none"//firefox
	};
};
windowDrag.prototype.dragMouseUp = function(dragWin){//鼠标放开事件
	return function(){
		dragWin.param.flag = false;	
		
		dragWin.param.left = dragWin.obj.offsetLeft;
		dragWin.param.top = dragWin.obj.offsetTop;
		
		removeEventHandler(document, "mousemove", dragWin.mousemove);
		removeEventHandler(document, "mouseup", dragWin.mouseup);
		//addEvent(window, "blur", dragWin.mouseup);
		
		//开启屏蔽页面的选择操作
		document.body.style.webkitUserSelect=""//chrome	
		document.body.unselectable=""//IE
		document.body.style.MozUserSelect=""//firefox
	};
};
windowDrag.prototype.dragMouseMove = function(dragWin){//鼠标移动事件
	return function(){
		var event = window.event ? window.event : arguments[0];
		if(dragWin.param.flag){
			window.getSelection ? window.getSelection().removeAllRanges() : document.selection.empty();
			
			var disX = event.clientX - dragWin.param.left;
			var disY = event.clientY - dragWin.param.top;
			
			//移动范围确定操作(1.对于iframe有一些影响-》需要解决 2.对于document事件无法去除问题的解决办法)
			disX = Math.max(Math.min(disX, dragWin.param.limitX - dragWin.obj.offsetWidth), 0);
       		disY = Math.max(Math.min(disY, dragWin.param.limitY - dragWin.obj.offsetHeight), 0);
			
			!dragWin.param.lockX ? dragWin.obj.style.left = disX + "px" : "";
			dragWin.obj.style.top = disY + "px";
		}
	};
};

/*取得元素对象的属性*/
function getObjStyle(obj , type){
	return obj.currentStyle ? obj.currentStyle[type] : window.getComputedStyle(obj , false)[type];
}

/***************************************************   信息提示框架   *********************************************************/
//接下来需要设置一个prompt组件用于实现提示信息操作处理
//将提示框对象定位到最上层
function promptWindow(){
	this.promptObj = null;//显示内容对象
	this.mWindow = null;//用于索引移动窗口对象
	this.wCover = null;//遮罩层对象
	loadScript_Css("css/BasicCss.css" , "css", null, window.top.document);
}
promptWindow.prototype.createWaitView = function(waitInfor){//创建等待界面
	this.mWindow == null ? this.createWindow() : this.mWindow.Win_view.remove_Child(this.promptObj);
	
	this.promptObj = window.top.document.createElement("div");
	this.promptObj.style.cssText = "width:100%;height:100px;position:relative;";
	
	var waitingLogo = window.top.document.createElement("div");
	waitingLogo.style.cssText = "width:39px;height:39px;position:absolute;top:30px;left:30px;background:url(images/waiting_logo.gif);"
	this.promptObj.appendChild(waitingLogo);
	
	var promptInfor = window.top.document.createElement("div");
	promptInfor.style.cssText = "width:300px;height:30px;font-size:13px;font-weight:bold;position:absolute;left:80px;top:35px;text-align:center;line-height:30px;";
	promptInfor.innerHTML = waitInfor;
	this.promptObj.appendChild(promptInfor);
	
	this.mWindow.Win_view.add_Child(this.promptObj);
};
promptWindow.prototype.createConfirmView = function(confirmInfor , buttonInfor){//确认页面
	this.mWindow == null ? this.createWindow() : this.mWindow.Win_view.remove_Child(this.promptObj);
	
	this.promptObj = window.top.document.createElement("div");
	this.promptObj.style.cssText = "width:100%;height:100px;position:relative;";
	
	var promptLogo = window.top.document.createElement("div");
	promptLogo.style.cssText = "width:50px;height:50px;position:absolute;top:30px;left:30px;background:url(images/prompt_logo.png);";
	this.promptObj.appendChild(promptLogo);
	
	var promptInfor = window.top.document.createElement("div");
	promptInfor.style.cssText = "width:300px;height:30px;font-size:13px;font-weight:bold;position:absolute;left:80px;top:35px;text-align:center;line-height:30px;";
	promptInfor.innerHTML = confirmInfor;
	this.promptObj.appendChild(promptInfor);
	
	var promptButton = window.top.document.createElement("div");
	promptButton.className = "prompt_button_out";
	promptButton.innerHTML = buttonInfor;
	this.promptObj.appendChild(promptButton);
	
	this.mWindow.setWindowHeight(120);
	this.mWindow.Win_view.add_Child(this.promptObj);
	
	addEvent(promptButton , "mouseover", this.buttonOver);
	addEvent(promptButton , "mouseout", this.buttonOut);
	addEvent(promptButton , "mousedown", this.confirmButtonEvent);
};
promptWindow.prototype.confirmButtonEvent = function(){};//这个是确认窗口对象事件注册操作（可复写该方法）
promptWindow.prototype.createSelectView = function(selectInfor , leftBtn , rightBtn){//选择页面页面
	this.mWindow == null ? this.createWindow() : this.mWindow.Win_view.remove_Child(this.promptObj);
	
	this.promptObj = window.top.document.createElement("div");
	this.promptObj.style.cssText = "width:100%;height:150px;position:relative;";
	
	var promptLogo = window.top.document.createElement("div");
	promptLogo.style.cssText = "width:50px;height:50px;position:absolute;top:30px;left:30px;background:url(images/prompt_logo.png);";
	this.promptObj.appendChild(promptLogo);
	
	var promptInfor = window.top.document.createElement("div");
	promptInfor.style.cssText = "width:300px;height:30px;font-size:14px;font-weight:bold;position:absolute;left:80px;top:50px;text-align:center;line-height;30px";
	promptInfor.innerHTML = selectInfor;
	this.promptObj.appendChild(promptInfor);
	
	var promptButton1 = window.top.document.createElement("div");
	promptButton1.className = "prompt_button_out1";
	promptButton1.innerHTML = leftBtn;
	this.promptObj.appendChild(promptButton1);
	
	var promptButton2 = window.top.document.createElement("div");
	promptButton2.className = "prompt_button_out2";
	promptButton2.innerHTML = rightBtn;
	this.promptObj.appendChild(promptButton2);
	
	this.mWindow.setWindowHeight(150);
	this.mWindow.Win_view.add_Child(this.promptObj);
	
	//注册动作事件
	addEvent(promptButton1 , "mouseover", this.buttonOver);
	addEvent(promptButton1 , "mouseout", this.buttonOut);
	addEvent(promptButton1 , "mousedown", this.leftBtnClick);
	addEvent(promptButton2 , "mouseover", this.buttonOver);
	addEvent(promptButton2 , "mouseout", this.buttonOut);
	addEvent(promptButton2 , "mousedown", this.rightBtnClick);
};
promptWindow.prototype.leftBtnClick = function(){};//可以用于复写方法来实现点击操作
promptWindow.prototype.rightBtnClick = function(){};//可以用于复写方法来实现点击操作
promptWindow.prototype.buttonOver = function(){
	//alert(this == window);这个是相当恶心的在IE中attachEvent绑定的事件函数中的this是指window（而firefox中的是指当前事件对象）
	/*使用css样式表的伪类控制
	var event = window.event ? window.event : arguments[0];
	var target = event.target ? event.target : event.srcElement;
	
	target.style.background = "url(images/frame_button1.png) no-repeat";
	*/
};
promptWindow.prototype.buttonOut = function(){
	/*
	var event = window.event ? window.event : arguments[0];
	var target = event.target ? event.target : event.srcElement;
	
	target.style.background = "url(images/frame_button0.png) no-repeat";
	*/
};
promptWindow.prototype.createWindow = function(){
	this.createCover();
	var margin_Left = (window.top.document.body.clientWidth - 400)/2;
	var margin_Top = (window.top.document.body.clientHeight - 150)/2;
	
	var frame = new Window_frame(400 , 100, margin_Top, margin_Left, null, null, null, null, null, true);
	
	this.mWindow = new moveWindow(frame , null, true, null, null, null, true, 2, window.top);
	this.mWindow.create_View();
};
promptWindow.prototype.createCover = function(){//创建一个透明的遮罩层
	var coverWidth = window.top.document.body.clientWidth;
	var coverHeight = window.top.document.body.clientHeight;
	
	this.wCover = window.top.document.createElement("div");
	this.wCover.style.position = "absolute";
	this.wCover.style.top = "0";
	this.wCover.style.left = "0";
	//使用这种方法解决对于在IE下无法遮罩全部对象（例如input元素对象的问题）
	this.wCover.innerHTML='<table width="100%" height="100%"><tr><td>&nbsp;</td></tr></table>';
	this.wCover.style.width = coverWidth+"px";
	this.wCover.style.height = coverHeight+"px";
	this.wCover.style.zIndex = "1000";
	
	window.top.document.body.appendChild(this.wCover);
};
promptWindow.prototype.removeCover = function(){//创建一个透明的遮罩层
	window.top.document.body.removeChild(this.wCover);
};
promptWindow.prototype.closeWindow = function(){
	this.mWindow.closeWindow();
	this.removeCover();
};