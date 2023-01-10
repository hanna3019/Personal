package board;

import java.io.File;
import java.io.UnsupportedEncodingException;

public class UtilMgr {
	
	public static String con(String s) {
		String str = null;
		try {
			str = new String(s.getBytes("8859_1"), "ksc5601");
			// 기본값인 8859_1을 ksc5601로 변경(한글깨짐 방지)
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return str;
	}
	
	public static void delete(String s) {
		File file = new File(s);
		if(file.isFile()) {
			file.delete();
		}
	}

}
