package app.dto;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class PasswordEncoder {
   
	public String EncBySha256(String data) throws Exception {
		  String retVal = "";
		  try {
		  	MessageDigest md = MessageDigest.getInstance("SHA-256");
		  	md.update(data.getBytes());

		  	byte byteData[] = md.digest();
		  	StringBuffer sb = new StringBuffer();
		    
		    for(int i=0; i<byteData.length; i++) {
		      sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
		    }

		    StringBuffer hexString = new StringBuffer();
		    for(int i=0; i<byteData.length;i++) {
		    String hex = Integer.toHexString(0xff & byteData[i]);
		    if(hex.length() == 1) {
		      hexString.append('0');
		    }
		      hexString.append(hex);
		    }

		  	retVal = hexString.toString();
		  } catch(NoSuchAlgorithmException e){
		  	System.out.println("EncBySHA256 Error:" + e.toString());
		  }
		  return retVal;
		}
}