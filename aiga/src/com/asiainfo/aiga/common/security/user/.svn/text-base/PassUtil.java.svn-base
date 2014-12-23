package com.asiainfo.aiga.common.security.user;

public class PassUtil {
	
	public static String origin = "`1234567890-=qwertyuiop[]\\asdfghjkl;'zxcvbnm,./~!@#$%^&*()_+QWERTYUIOP{}|ASDFGHJKL:\"ZXCVBNM<>? ";
	
	public static String result = "6B3A39383F3E3D3C33323B26367A7C6E797F727E62647B5056576A786F6D6C63616067302C7173687D696566272524752A4B282F2E552D21232254205A5C4E595F525E42445B7076774A584F4D4C4341404731295153485D4945463735342B";
	
	public static void main(String args[]) {
		
		String resPass = "6A626A6766";
		
		String orinPass;
		try {
			orinPass = getOrinPass(resPass);
			System.out.println(orinPass);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static String getOrinPass(String resPass) throws Exception {
		if(resPass == null || "".equals(resPass)) {
			return "";
		}
		String[] resultSplit = new String[(result.length()/2)];
		for(int i = 0; i < result.length(); i+=2) {
			resultSplit[i/2] = result.substring(i,i+2);
		}
		
		String[] splitPass = new String[(resPass.length()/2)];
		for(int i = 0; i < resPass.length(); i+=2) {
			splitPass[i/2] = resPass.substring(i,i+2);
		}
		String orinPass = "";
		for(int i = 0; i < splitPass.length; i++) {
			int index = 0;
			for(int j = 0; j < resultSplit.length; j++) {
				if(splitPass[i].equals(resultSplit[j])) {
					index = j;
					break;
				}
			}
			orinPass += origin.substring(index, index+1);
		}
		return orinPass;
	}

}
