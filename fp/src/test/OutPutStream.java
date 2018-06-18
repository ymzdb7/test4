package test;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

public class OutPutStream {

	public static void main(String[] args) throws IOException {
		File f = new File("D:" + File.separator + "file" + File.separator
				+ "filetest.txt");
		OutputStream os = new FileOutputStream(f, true);
		String str = "k-------";
		byte[] b = str.getBytes();
		os.write(b);
		os.close();
		
	}	

}


	
