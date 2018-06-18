import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

public class InputStreamTest {
	public static void main(String[] args) throws IOException {
		File f = new File("D:" + File.separator + "file" + File.separator
				+ "oop.bmp");
		File ff = new File("D:" + File.separator + "file" + File.separator
				+ "aaa.bmp");
		InputStream fz=new FileInputStream(f);
		OutputStream zt=new FileOutputStream(ff);
		byte[] b=new byte[5000];
		while(fz.read(b)!=-1){
			zt.write(b);
		}
		fz.close();
		zt.close();
	}
}
