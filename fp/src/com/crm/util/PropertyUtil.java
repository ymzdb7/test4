package com.crm.util;

import com.sun.istack.internal.logging.Logger;

import java.io.*;
import java.util.Properties;

/**
 * Desc:properties文件获取工具类
 * Created by hafiz.zhang on 2016/9/15.
 */
public class PropertyUtil {
	//static Logger logger = Logger.getLogger(PropertyUtil.class);
    private static Properties props;
    static{
        loadProps();
    }

    synchronized static private void loadProps(){
        //logger.info("开始加载properties文件内容.......");
        props = new Properties();
        InputStream in = null;
        try {
        	//<!--第一种，通过类加载器进行获取properties文件流-->
            in = PropertyUtil.class.getClassLoader().getResourceAsStream("upload.properties");
            //  <!--第二种，通过类进行获取properties文件流-->
            //in = PropertyUtil.class.getResourceAsStream("/upload.properties");
            props.load(in);
        } catch (FileNotFoundException e) {
            //logger.error("jdbc.properties文件未找到");
        	e.printStackTrace();
        } catch (IOException e) {
            //logger.error("出现IOException");
        	e.printStackTrace();
        } finally {
            try {
                if(null != in) {
                    in.close();
                }
            } catch (IOException e) {
                //logger.error("jdbc.properties文件流关闭出现异常");
            	e.printStackTrace();
            }
        }
        //logger.info("加载properties文件内容完成...........");
        //logger.info("properties文件内容：" + props);
    }

    public static String getProperty(String key){
        if(null == props) {
            loadProps();
        }
        return props.getProperty(key);
    }

    public static String getProperty(String key, String defaultValue) {
        if(null == props) {
            loadProps();
        }
        return props.getProperty(key, defaultValue);
    }
}