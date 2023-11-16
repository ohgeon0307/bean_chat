package app.dto;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.Base64.Encoder;

public class MessageDigestHelper {
	public static String getSHA256AsBase64(String input, String salt, int count) {
		if (input == null || input.length() == 0) {
			return "";
		}

		String digest = "";
		MessageDigest messageDigest = null;
		try {
			messageDigest = MessageDigest.getInstance("SHA-256");
			messageDigest.reset();
			messageDigest.update(salt.getBytes(StandardCharsets.UTF_8));

			byte[] output = messageDigest.digest(input.getBytes(StandardCharsets.UTF_8));
			for (int index = 0; index < count; index++) {
				messageDigest.reset();
				output = messageDigest.digest(output);
			}

			Encoder encoder = Base64.getEncoder();
			digest = new String(encoder.encode(output));
		} catch (NoSuchAlgorithmException e) {
			digest = "";
		}
		return digest;
	}

}
