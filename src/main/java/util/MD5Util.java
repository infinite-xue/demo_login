package util;

import org.springframework.util.DigestUtils;

public class MD5Util {

	public static String getMD5(String str) {
		return DigestUtils.md5DigestAsHex(str.getBytes());
	}

	public static void main(String[] args) {
		System.out.println(MD5Util.getMD5("123"));
	}

}
