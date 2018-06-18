package test;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

public class UploadServlet extends HttpServlet {

	private String uploadPath = "upload/files/"; // 上传文件的目录
	private String tempPath = "upload/tmp/"; // 临时文件目录
	private String serverPath = null;

	private int sizeMax = 3;// 图片最大上限
	private String[] fileType = new String[] { ".jpg", ".gif", ".bmp", ".png",
			".jpeg", ".ico" };

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("上下文路径："+request.getContextPath());
		System.out.println("真实路径："+request.getRealPath("/"));
		this.doGet(request, response);
	}

	public ResponseEntity<byte[]> testResponseEntity(HttpSession session)
			throws IOException {
		byte[] body = null;
		ServletContext servletContext = session.getServletContext();
		System.out.println("真实路径："+servletContext.getRealPath("/"));
		InputStream in = servletContext.getResourceAsStream("/files/test.txt"); // WebRoot下的路径
		body = new byte[in.available()];
		in.read(body);

		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Disposition", "attachment;filename=test.txt");

		HttpStatus statusCode = HttpStatus.OK;

		ResponseEntity<byte[]> response = new ResponseEntity<byte[]>(body,
				headers, statusCode);
		return response;
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		serverPath = getServletContext().getRealPath("/").replace("\\", "/");
		// Servlet初始化时执行,如果上传文件目录不存在则自动创建
		if (!new File(serverPath + uploadPath).isDirectory()) {
			new File(serverPath + uploadPath).mkdirs();
		}
		if (!new File(serverPath + tempPath).isDirectory()) {
			new File(serverPath + tempPath).mkdirs();
		}

		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setSizeThreshold(5 * 1024); // 最大缓存
		factory.setRepository(new File(serverPath + tempPath));// 临时文件目录

		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setSizeMax(sizeMax * 1024 * 1024);// 文件最大上限

		String filePath = null;
		try {
			List<FileItem> items = upload.parseRequest(request);// 获取所有文件列表
			for (FileItem item : items) {
				// 获得文件名，这个文件名包括路径
				if (!item.isFormField()) {
					// 文件名
					String fileName = item.getName().toLowerCase();

					if (fileName.endsWith(fileType[0])
							|| fileName.endsWith(fileType[1])
							|| fileName.endsWith(fileType[2])
							|| fileName.endsWith(fileType[3])
							|| fileName.endsWith(fileType[4])
							|| fileName.endsWith(fileType[5])) {
						String uuid = Long.toString(System.currentTimeMillis());
						filePath = serverPath + uploadPath + uuid
								+ fileName.substring(fileName.lastIndexOf("."));
						item.write(new File(filePath));
						PrintWriter pw = response.getWriter();
						pw.write("<script>alert('Upload OK!');window.returnValue='"
								+ uploadPath
								+ uuid
								+ fileName.substring(fileName.lastIndexOf("."))
								+ "';window.close();</script>");
						pw.flush();
						pw.close();
					} else {
						request.setAttribute("errorMsg", "ERROR !!!");
						request.getRequestDispatcher("/test/uploadPage.jsp")
								.forward(request, response);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("errorMsg", "上传失败,请确认上传的文件大小不能超过" + sizeMax
					+ "M");
			request.getRequestDispatcher("/test/uploadPage.jsp").forward(
					request, response);
		}

	}
}
