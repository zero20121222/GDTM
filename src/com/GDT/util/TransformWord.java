package com.GDT.util;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.List;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.apache.commons.io.output.ByteArrayOutputStream;
import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.converter.PicturesManager;
import org.apache.poi.hwpf.converter.WordToHtmlConverter;
import org.apache.poi.hwpf.usermodel.Picture;
import org.apache.poi.hwpf.usermodel.PictureType;
import org.w3c.dom.Document;

/**
 * Desc:实现word向html的转换
 * Mail:v@terminus.io
 * author:Michael Zhao
 * Date:2014-05-28.
 */
public class TransformWord {

    public static void main(String[] args){
        try {
            new TransformWord().convertHtml("/Users/MichaelZhao/Documents/SchoolProject/GDTM/WebRoot/Schoolinfor/1/News/赵宇-开题报告信息版本2.0(1).doc", "/Users/MichaelZhao/Downloads/赵宇-开题报告信息版本2.0(1).html", "/Users/MichaelZhao/Downloads");
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    public void convertHtml(String inputFile, String saveFile, String savePath) throws TransformerException, IOException, ParserConfigurationException {
        HWPFDocument wordDocument = new HWPFDocument(new FileInputStream(inputFile));
        //word文档向html转换的工具
        WordToHtmlConverter wordToHtmlConverter = new WordToHtmlConverter(DocumentBuilderFactory.newInstance().newDocumentBuilder().newDocument());

        //写入word的相对图片路径
        wordToHtmlConverter.setPicturesManager( new PicturesManager(){
            public String savePicture( byte[] content, PictureType pictureType, String suggestedName, float widthInches, float heightInches){
                return "images/"+suggestedName;
            }
        } );
        wordToHtmlConverter.processDocument(wordDocument);

        //保存图片
        List<Picture> pics = wordDocument.getPicturesTable().getAllPictures();
        if(pics != null){
            for(Picture picture : pics){
                try{
                    picture.writeImageContent(new FileOutputStream(FileUploadCL.queryFilePath(savePath , "images" , picture.suggestFullFileName())));
                }catch(FileNotFoundException e){
                    e.printStackTrace();
                }
            }
        }

        Document htmlDocument = wordToHtmlConverter.getDocument();
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        DOMSource domSource = new DOMSource(htmlDocument);
        StreamResult streamResult = new StreamResult(out);

        //转换工厂
        TransformerFactory factory = TransformerFactory.newInstance();
        Transformer serializer = factory.newTransformer();
        serializer.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
        serializer.setOutputProperty(OutputKeys.INDENT, "yes");
        serializer.setOutputProperty(OutputKeys.METHOD, "html");
        serializer.transform(domSource, streamResult);
        out.close();

        writeFile(new String(out.toByteArray()), saveFile);
    }

    public void writeFile(String content, String path) {
        FileOutputStream fos = null;
        BufferedWriter bw = null;
        try {
            File file = new File(path);
            fos = new FileOutputStream(file);
            bw = new BufferedWriter(new OutputStreamWriter(fos,"UTF-8"));
            bw.write(content);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException ioe) {
            ioe.printStackTrace();
        } finally {
            try {
                if (bw != null)
                    bw.close();
                if (fos != null)
                    fos.close();
            } catch (IOException ie) {
            }
        }
    }
}