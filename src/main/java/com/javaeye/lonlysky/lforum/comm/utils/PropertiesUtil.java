package com.javaeye.lonlysky.lforum.comm.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.javaeye.lonlysky.lforum.exception.WebException;

/**
 * Properties工具
 * 
 * @author 黄磊
 *
 */
public class PropertiesUtil {

	private static final Logger logger = LoggerFactory.getLogger(PropertiesUtil.class);

	private PropertiesUtil() {
	}

	/**
	 * 加载指定Properties文件
	 * 
	 * @param filePath 路径
	 * @return Properties对象
	 */
	public static Properties loadProperties(String filePath) {
		File file = new File(filePath);
		Properties properties = new Properties();
		try {
			properties.load(new FileInputStream(file));
			if (logger.isDebugEnabled()) {
				logger.debug("加载文件成功：" + filePath);
			}
			return properties;
		} catch (FileNotFoundException e) {
			logger.error("找不到文件：" + filePath, e);
			throw new WebException("找不到指定Properties文件");
		} catch (IOException e) {
			logger.error("加载文件：" + filePath + "异常", e);
			throw new WebException("加载指定Properties失败");
		}
	}

	/**
	 * 获取指定键值对
	 * 
	 * @param filePath	文件路径
	 * @param key	键
	 * @return 值
	 */
	public static String getStringValue(String filePath, String key) {
		Properties properties = loadProperties(filePath);
		String value = properties.getProperty(key);
		properties.clear();
		if (logger.isDebugEnabled()) {
			logger.debug("获取键值对：" + key + " - " + value);
		}
		return value;
	}

}
