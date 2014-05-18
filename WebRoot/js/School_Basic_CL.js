//用于封装从数据库返回的学院&专业数据
function SelectCollege(){
	this.college = null;//学院名称
	this.majors = new Array();
}
SelectCollege.prototype.setCollegeValue = function(obj){//装载对象元素
	if(obj != null){
		this.college = obj.collegeName;
		this.majors[0] = obj.major1;
		this.majors[1] = obj.major2;
		this.majors[2] = obj.major3;
		this.majors[3] = obj.major4;
		this.majors[4] = obj.major5;
		this.majors[5] = obj.major6;
		this.majors[6] = obj.major7;
		this.majors[7] = obj.major8;
		this.majors[8] = obj.major9;
		this.majors[9] = obj.major10;
	}
};

function userCollegeObj(collegeselect , majorselect){//学校的院系信息
	this.collegeArray = new Array();//创建一个保存数据的数组
	this.collegeselect = collegeselect;//院系
	this.majorselect = majorselect;//专业
}
userCollegeObj.prototype.createView = function(){
	var collegeRequest = newXMLHttpRequest();
	collegeRequest.open("post" , "IndexInterlizeServlet?type=querySchoolCollege", true);
	collegeRequest.onreadystatechange = this.selectColleges(collegeRequest , this);
	
	collegeRequest.send(null);
};
userCollegeObj.prototype.selectColleges = function(collegeRequest , collegeObj){//调用Ajax技术异步查询数据
	return function(){
		if(collegeRequest.readyState == 1 || collegeRequest.readyState == 2 || collegeRequest.readyState == 3){
			
		}else if(collegeRequest.readyState == 4){
			if(collegeRequest.status == 200){
				var colleges = eval(collegeRequest.responseText);
				
				for(var i=0;i<colleges.length;i++){
					var college = new SelectCollege();
					college.setCollegeValue(colleges[i]);
					
					collegeObj.collegeArray.push(college);
				}
				
				collegeObj.createCollegeSelect();
			}
		}
	}
};
userCollegeObj.prototype.createCollegeSelect = function(){
	for(var i=0;i<this.collegeArray.length;i++){
		var option = new Option(this.collegeArray[i].college , this.collegeArray[i].college);
		this.collegeselect.options[i] = option;
		
		addEvent(this.collegeselect , "change", this.changeCollegeEvent(this));
	}
	
	for(var i=0;i<this.collegeArray[0].majors.length;i++){
		if(this.collegeArray[0].majors[i] == "null"){
			break;
		}
		var option = new Option(this.collegeArray[0].majors[i] , this.collegeArray[0].majors[i]);
		this.majorselect.options[i] = option;
	}
};
userCollegeObj.prototype.changeMajorSelect = function(changeValue){
	var changeNum = 0;
	for(var i=0;i<this.collegeArray.length;i++){
		if(this.collegeArray[i].college == changeValue){
			changeNum = i;
			break;
		}
	}
	
	for(var i=0;i<this.collegeArray[changeNum].majors.length;i++){
		if(this.collegeArray[changeNum].majors[i] == "null"){
			break;
		}
		var option = new Option(this.collegeArray[changeNum].majors[i] , this.collegeArray[changeNum].majors[i]);
		this.majorselect.options[i] = option;
	}
};
userCollegeObj.prototype.removeMajorSelect = function(){//清除专业选择
	for(var i=0 ; i<this.majorselect.length ; i++){
        this.majorselect.remove(i);
    }  
};
userCollegeObj.prototype.changeCollegeEvent = function(collegeObj){//清除专业选择
	return function(){
		collegeObj.removeMajorSelect();
		collegeObj.changeMajorSelect(collegeObj.collegeselect.value);
	}
};
userCollegeObj.prototype.selectColllege = function(college){//显示原始数据定位的学校名称
	//对于课题内容更改操作时（显示当前课题的限定学院名称）
	if(college != "null"){
		for(var i=0;i<this.collegeArray.length;i++){
			this.collegeArray[i].college == college ? this.collegeselect.options[i].selected = true : "";
		}
	}else{
		
	}
};
userCollegeObj.prototype.selectMajor = function(major){//显示原始数据定位的专业名称
	for(var i=0;i<this.collegeArray[0].majors.length;i++){
		this.collegeArray[0].majors[i] == major ? this.majorselect.options[i].selected = true : "";
	}
};