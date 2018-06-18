package test;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;


public class WriteTest {
	public static void main(String[] args) throws IOException {
		File f=new File("D:"+File.separator+"file"+File.separator+"writefiletest.txt");
		Writer wr=new FileWriter(f);
		String str="skksksk..........";
		wr.write(str);
		wr.close();
	}
}
