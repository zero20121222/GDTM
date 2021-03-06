package com.GDT.Model;

/*
 * 学校数据源文件对象
 * @author zero
 */
public class SchoolUsersFile {
	private int id;			//数据源文件编号
	private int schoolId;	//学校编号
	private String name;	//数据源文件名称
	private String path;	//数据源文件路径
	private String type;	//数据源类型
	private String ifLoad;	//是否已导入数据到数据库
    private int loadCount;  //成功导入的用户数量
    private String createdAt;//创建时间
    private String filePath; //文件路径
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getSchoolId() {
		return schoolId;
	}
	public void setSchoolId(int schoolId) {
		this.schoolId = schoolId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getIfLoad() {
		return ifLoad;
	}
	public void setIfLoad(String ifLoad) {
		this.ifLoad = ifLoad;
	}

    public int getLoadCount() {
        return loadCount;
    }
    public void setLoadCount(int loadCount) {
        this.loadCount = loadCount;
    }

    public String getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }
    public String getFilePath() {
        return filePath;
    }
    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }
}
