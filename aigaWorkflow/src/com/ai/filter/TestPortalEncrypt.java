package com.ai.filter;

import java.text.ParseException;


/** 
 * <p>Title: TestPortalEncrypt.java</p>
 * 
 * <p>Description: 第三方系统解密样例</p>
 * 
 * <p>Date: 2010-7-12</p>
 * 
 * <p>Time: 下午04:26:05</p>
 * 
 * <p>Copyright: Copyright (c) 2010</p>
 * 
 * <p>Company: mochasoft</p>
 * 
 * @author 郝庆伟
 * @version 1.0
 * 
 * <p>============================================</p>
 * <p>Modification History
 * <p>Mender: </p>
 * <p>Date: </p>
 * <p>Reason: </p>
 * <p>============================================</p>
 */
public class TestPortalEncrypt {
	
	/**
	 * 加密方法
	 * @param secretKey 加密密钥
	 * @param str 需要加密的字符串
	 * @return 加密后的字符串
	 */
	public static String testEncode(String secretKey, String str) {
		return EncryptorUtil.encode(secretKey, str);
	}
	
	/**
	 * 解密方法
	 * @param secretKey 解密密钥
	 * @param ciphertext 密文
	 * @param outTime 密文失效时间，以秒为单位
	 * @return 解密后的字符串
	 */
	public static String testDecode(String secretKey, String ciphertext, int outTime) {
		String uid = null;
		try {
			uid = EncryptorUtil.decode(secretKey, ciphertext, outTime);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return uid;
	}

	public static void main(String[] args) {
		String str = testEncode("ALM_HN", "ADMINISTRATOR");
		System.out.println("encodedString:" + str);
		
		// 以下为解密代码，密文的有效期为30分钟
		String str2 = testDecode("ALM_HN", str, 1800);
		System.out.println("decodedString:" + str2);
	}

}
