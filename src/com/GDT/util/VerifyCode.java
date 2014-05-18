package com.GDT.util;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 这个是一个用于自动的生成验证码的servlet对象 
 * @author zero
 */
public class VerifyCode extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static int CODE_WIDTH = 100;
	private static int CODE_HEIGHT = 36;
	private static char[] ALL_CODE_VALUE = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789".toCharArray();
	private static int[] FONT_STYLE = {Font.PLAIN,Font.BOLD,Font.ITALIC,Font.PLAIN|Font.BOLD,Font.ITALIC|Font.BOLD};
	private static int CODE_LENGTH = 4;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		/* 页面设置
		 * 
		 *
		 */
		response.reset();//清空缓冲区
		response.setContentType("image/jpeg");
		
		//设置页面不缓存
		response.setHeader("Pargma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
		
		Random random = new Random();//随机数
		
		char codebuf[] = new char[CODE_LENGTH];
		for(int i=0;i<CODE_LENGTH;i++){
			codebuf[i] = ALL_CODE_VALUE[Math.abs(random.nextInt())%ALL_CODE_VALUE.length];
		}
		String codevalue = new String(codebuf);//需要返回的验证码信息
		
		//创建缓存图像
		BufferedImage image = new BufferedImage(CODE_WIDTH , CODE_HEIGHT, BufferedImage.TYPE_INT_BGR);
		Graphics g = image.getGraphics();
		if(random.nextInt(2) == 0){
			g.setColor(Color.WHITE);//背景为白色
			g.fillRect(0, 0, CODE_WIDTH, CODE_HEIGHT);
			
			g.setColor(new Color(224,224,224));
			g.drawRect(0,0,CODE_WIDTH-1,CODE_HEIGHT-1);
		}else{
			g.setColor(new Color(237,245,255));
			g.fillRect(0, 0, CODE_WIDTH, CODE_HEIGHT);//绘制背景
			
			g.setColor(new Color(213,232,255));
			g.drawRect(0,0,CODE_WIDTH-1,CODE_HEIGHT-1);
		}
		
		//设定每个验证码的字体样式
		String rand = null;
		for(int i=0;i<CODE_LENGTH;i++){
			rand = codevalue.substring(i , i+1);
			g.setFont(getRandomFont());
			g.setColor(new Color(20+random.nextInt(60),20+random.nextInt(120),20+random.nextInt(180)));
			g.drawString(rand , i*20+10, 20+random.nextInt(6));
		}
		
		HttpSession session = request.getSession();
		session.removeAttribute("verifycode");
		session.setAttribute("verifycode", codevalue);
		
		ServletOutputStream sos = response.getOutputStream();//实现将信息输入到这个response回复请求中以输出流形式。
		ImageIO.write(image , "JPEG", sos);//实现将image对象以JPEG方式写入到sos输出流对象中。
		sos.close();//关闭输出流
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
	
	//得到一个随机的字体样式
	public Font getRandomFont(){
		Random random = new Random();
		
		int font_style = FONT_STYLE[random.nextInt((FONT_STYLE.length))];//字体类型（普通类型，粗体类型，斜体类型）
		int font_size = 22+random.nextInt(8);//设置字体大小1.叶根友特色空心简体终极版2.华文隶书
		Font font = new Font("华文隶书", font_style, font_size);
		
		return font;
	}
}
