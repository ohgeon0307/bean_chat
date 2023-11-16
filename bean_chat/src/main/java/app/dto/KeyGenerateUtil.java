package app.dto;

import java.util.UUID;

public class KeyGenerateUtil {
	
	public static String getSalt() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}

}
