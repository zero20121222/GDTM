package com.GDT.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;

import com.jacob.activeX.ActiveXComponent;
import com.jacob.com.ComThread;
import com.jacob.com.Dispatch;
import com.jacob.com.Variant;

/*
 * 将文件转换成其他格式
 * @author zero
 */
public class FileConvert implements FileConvertInterface{
	private static String SCHOOL_INFORPATH = null;//学校文件路径
	private static String PROJECT_INFORPATH = null;//课题文件路径
	private static String TEAM_INFORPATH = null;//团队文件路径
	
	private class WordConvertRunnable implements Runnable{//word装换的内部类对象
		private String filepath;
		private String htmlpath;
		
		private WordConvertRunnable(String filepath, String htmlpath){
			this.filepath = filepath;
			this.htmlpath = htmlpath;
		}
		
		public void run() {
			ActiveXComponent app = new ActiveXComponent("Word.Application");// 查找word组件  
			
			try {
				app.setProperty("Visible", new Variant(false));// 设置word不可见
				Dispatch docs = app.getProperty("Documents").toDispatch();
				 
				//Object设置打开word文件，注意这里第三个参数要设为true，这个参数表示是否以只读方式打开，因为我们不用保存原文件，所以以只读方式打开，如果你想进行读写，那么就得设为false。
				Dispatch doc = Dispatch.invoke(docs , "Open", Dispatch.Method,
				new Object[] { filepath, new Variant(false), new Variant(true) }, new int[1]).toDispatch();
				 
				//作为html格式保存到目标文件(html-new Variant(8) txt-new Variant(2))
				Dispatch.invoke(doc, "SaveAs", Dispatch.Method, new Object[] { htmlpath, new Variant(8) }, new int[1]);
				 
				Variant f = new Variant(false);
				Dispatch.call(doc, "Close", f); //关闭word文件
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				app.invoke("Quit", new Variant[] {});
			}
			
			/*
			 * 实现将html进行转码（转换成UTF-8）
			 */
			try {
				convertFileCode(htmlpath , "UTF-8");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	/*
	 * 初始化FileConvert对象
	 * @param schoolpath
	 * 学校文件路径
	 * @param projectpath
	 * 课题文件路径
	 * @param teampath
	 * 团队文件路径
	 */
	public static void initConvert(String schoolpath , String projectpath, String teampath){
		SCHOOL_INFORPATH = schoolpath;
		PROJECT_INFORPATH = projectpath;
		TEAM_INFORPATH = teampath;
	}

	public void convertProjectInfor(int schoolId , int userId, String filename, int convertType) {
		
	}

	public void convertProjectStageInfor(int schoolId , int userId, int projectId, String filename, int convertType) {
		// TODO Auto-generated method stub
		
	}
	
	/*
	 * @see com.GDT.util.FileConvertInterface#convertSchoolNew(int, int, java.lang.String, int)
	 * 实现将学校上传的word文档转换成为html格式
	 */
	public void convertSchoolNew(int schoolId, int newId, String filename, int convertType) {
		//需要转换的word文档
		String filepath = SCHOOL_INFORPATH + schoolId + "\\News\\" + newId + "\\" + filename;
		//需要转换输出的html文档
		String htmlpath = SCHOOL_INFORPATH + schoolId + "\\News\\" + newId + "\\" + filename.replaceAll(".doc", ".html");
		
		if(convertType == WORDTYPE){
			this.wordConvertHtml(filepath, htmlpath);
		}else if(convertType == EXCELTYPE){
			this.excelConvertHtml(filepath, htmlpath);
		}
	}

	public void convertTeamStageInfor(int teamId, String stageId, String filename, int convertType) {
		
	}

	public void excelConvertHtml(String filepath, String htmlpath) {
		ComThread.InitSTA();
		ActiveXComponent xl = new ActiveXComponent("Excel.Application"); 
		
		try{ 
		    File fo = new File(htmlpath); 
		    if(fo.exists()&&fo.canRead()){ 
		        fo.delete(); 
		    }
		    xl.setProperty("Visible", new Variant(false)); 
		    Dispatch workbooks = xl.getProperty("Workbooks").toDispatch(); 
		    Dispatch workbook = Dispatch.invoke(workbooks, "Open", Dispatch.Method, 
		    new Object[]{filepath, new Variant(false), new Variant(true) }, new int[1]).toDispatch();
		
		    Dispatch.invoke(workbook, "SaveAs", Dispatch.Method, new Object[]{htmlpath, new Variant(44) }, new int[1]);
		
		    Dispatch.call((Dispatch) workbook, "Close", new Variant(false));
		} catch (Exception e){ 
		    e.printStackTrace(); 
		} finally{ 
		    xl.invoke("Quit", new Variant[]{}); 
		    ComThread.Release(); 
		} 
	}
	
	/*
	 * @see com.GDT.util.FileConvertInterface#wordConvertHtml(java.lang.String, java.lang.String)
	 * 实现word文档更改为html格式
	 * 这个实现是独立一个线程处理数据
	 * 对于文件生成html时的格式是GB2312问题（可以自己编写一个用于转换文件编码方式的程序,这样还不如使用POI来实现方便）
	 */
	public void wordConvertHtml(String filepath, String htmlpath) {
		Thread thread = new Thread(new WordConvertRunnable(filepath , htmlpath));
		thread.start();
	}
	
	/*
	 * @see com.GDT.util.FileConvertInterface#convertFileCode(java.lang.String, java.lang.String)
	 * 文件编码转换算法
	 */
	public Boolean convertFileCode(String filepath, String convertCode) throws IOException{
		Boolean convert = false;
		
		fileWrite(filepath , convertCode , fileRead(filepath , getFileEncoding(filepath)));
		
		return convert;
	}  
	
	public StringBuffer fileRead(String filePath , String encoding){
		StringBuffer buffer = new StringBuffer();
		BufferedReader input = null;
		try{
			input = new BufferedReader(new InputStreamReader(new FileInputStream(filePath) , encoding));
			
			String line = "";
			while((line = input.readLine()) != null){
				buffer.append(line);
			}
		}catch(IOException e){
			e.printStackTrace();
		}finally{
			try{
				if(input != null){
					input.close();
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		return buffer;
	}
	
	public Boolean fileWrite(String filePath , String encoding, StringBuffer buffer){
		Boolean result = false;
		BufferedWriter output = null;
		
		try{
			output = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(filePath) , encoding));
			output.write(buffer.toString());
			 
			result = true;
		}catch(IOException e){
			e.printStackTrace();
		}finally{
			try{
				if(output != null){
					output.close();
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		 
		return result;
	 }
	
	/*
	 * @see com.GDT.util.FileConvertInterface#getFileEncoding(java.lang.String)
	 * 获取文件的编码方式是UTF-8或者GBK等
	 */
	public String getFileEncoding(String filePath){
		String fileCode = "GB2312";
		InputStream inputStream = null;
		
		try{
			inputStream = new FileInputStream(filePath);
			byte[] code = new byte[3];
			inputStream.read(code);
			
			if(code[0] == -17 && code[1] == -69 && code[2] == -65){
				fileCode = "UTF-8";
			}else if(code[0] == -1 && code[1] == -2 ){ 
				fileCode = "UTF-16";  
			}else if (code[0] == -2 && code[1] == -1 ){
				fileCode = "Unicode"; 
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try {
				if(inputStream != null){
					inputStream.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		return fileCode;
	}
	
	public static void main(String args[]){
		try {
			//new FileConvert().convertFileCode("F://zero3.html", "UTF-8");
            new FileConvert().wordConvertHtml("/Users/MichaelZhao/Downloads/赵宇-任务书.doc" , "/Users/MichaelZhao/Downloads/");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
