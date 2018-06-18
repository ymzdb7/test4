package test;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.FileItem;

@Controller
@RequestMapping("/upload")
public class uploaFileSpring {

	@RequestMapping("/uploadPhoto")
	@ResponseBody
	public String uploadImage(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,
			@RequestParam(value = "file", required = true) MultipartFile file) {
		// String path = session.getServletContext().getRealPath("/upload");
		String pic_path = "D:\\fp\\base\\upload\\tmp\\";
		System.out.println("real path: " + pic_path);
		String fileName = file.getOriginalFilename();
		System.out.println("file name: " + fileName);
		File targetFile = new File(pic_path, fileName);
		if (!targetFile.exists()) {
			targetFile.mkdirs();
		}
		try {
			file.transferTo(targetFile);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		String fileUrl = fileName;
		return fileUrl;
	}

	/***
	 * 上传文件 用@RequestParam注解来指定表单上的file为MultipartFile
	 * 
	 * @param file
	 * @return
	 */
	@RequestMapping("/fileUpload")
	public String fileUpload(HttpServletRequest request,
			@RequestParam("file") MultipartFile file) {
		// 判断文件是否为空
		if (!file.isEmpty()) {
			try {
				// 文件保存路径
				String filePath = request.getSession().getServletContext()
						.getRealPath("/")
						+ "uploada/" + file.getOriginalFilename();
				// 转存文件
				file.transferTo(new File(filePath));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		// 重定向
		return "redirect:/upload/list";
	}

	/***
	 * 读取上传文件中的所有文件并返回
	 * 
	 * @return
	 */
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request) {
		String filePath = request.getSession().getServletContext()
				.getRealPath("/")
				+ "uploada/";
		ModelAndView mav = new ModelAndView("list");
		File uploadDest = new File(filePath);
		String[] fileNames = uploadDest.list();
		for (int i = 0; i < fileNames.length; i++) {
			// 打印出文件名
			System.out.println(fileNames[i]);
		}
		return mav;
	}
	
	
	public void checkFile(HttpServletRequest request,HttpServletResponse response,
			MultipartFile file){
		// 检测是不是存在上传文件
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		//spring 要用 MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request; 
		if (isMultipart) {
			System.out.println("~~~111111111111111111111~~~~~~~~~~~~~~~");

		    response.setCharacterEncoding("utf-8");  
		    response.setContentType("application/x-download");    
		    response.setHeader("Accept-Ranges", "bytes"); 
		    int fSize = 10;//Integer.parseInt(String.valueOf(uploadFile.length()));   
			DiskFileItemFactory factory = new DiskFileItemFactory();
			factory.setSizeThreshold(1024 * 1024);
			factory.setRepository(new File("D:\\fp"));
			ServletFileUpload upload = new ServletFileUpload(factory);
			upload.setFileSizeMax(50 * 1024 * 1024);
			upload.setSizeMax(50 * 1024 * 1024);
			upload.setHeaderEncoding("UTF-8");
			List<FileItem> items = null;
			try {
				// 解析request请求
				System.out.println("~~~~~~~~~~~~~~~~~~~");
				items = upload.parseRequest(request);
				//} catch (FileUploadException e) {
			} catch (Exception e) {
				e.printStackTrace();
			}

			if (items != null) {
				// 解析表单项目
				Iterator<FileItem> iter = items.iterator();
				while (iter.hasNext()) {
					FileItem item = iter.next();
		
					// 如果是普通表单属性
					if (item.isFormField()) {
						// 相当于input的name属性 <input type="text" name="content">
						String name = item.getFieldName();
						// input的value属性
						String value = item.getString();
						System.out.println("属性:" + name + " 属性值:" + value);
					}
					// 如果是上传文件
					else {
						//Client client =new Client();
						// 属性名
						String fieldName = item.getFieldName();
						// 上传文件路径
						String fileName = item.getName();
						fileName = fileName
								.substring(fileName.lastIndexOf("/") + 1);// 获得上传文件的文件名
		
		
						//client.upload(uploadPath+"\\"+fileName);
		
		
				        response.setHeader("Content-Length", String.valueOf(fSize));    
				        response.setHeader("Content-Disposition", "attachment;fileName=" + fileName);  
				        try {
				        	item.write(new File("D:\\fp\\base\\upload\\tmp\\", fileName));
				        	//message = "success";
				        } catch (Exception e) {
				        	//message = "shi bai";
				        	e.printStackTrace();
				        }
					}
				}
			}
		}
	}
}
