package test;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;

public class ReadTest {
	public static void main(String[] args) throws IOException {
		File f = new File("D:" + File.separator + "file" + File.separator
				+ "filetest.txt");
		Reader rr=new FileReader(f);
		BufferedReader br=new BufferedReader(rr);//������һ���ַ�д�����Ļ��������󣬲���ָ��Ҫ������������������
				System.out.println(br.readLine());
				
				br.close();
				rr.close();
		
//				 �������������
//		String str="";
//		while((str=br.readLine())!=null){
//			System.out.println(str);
//		}
		
		
	} 
}
