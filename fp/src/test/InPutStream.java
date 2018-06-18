package test;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
public class InPutStream {
	public static void main(String[] args) throws IOException {
		File f=new File("D:"+File.separator+"file"+File.separator+"filetest.txt");
		InputStream is=new FileInputStream(f);
		
		
		
		byte[] b=new byte[1000];
		int line=is.read(b);
		System.out.println(new String(b,0,line));
		is.close();
	}
	

}
	
	
	
	
	
	
	
	
	
	
	
	
	
	

