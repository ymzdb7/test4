package test;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.crm.util.ResultMapUtil;

@Controller
@RequestMapping("/test")
public class Test {

	static String content;
	
	@RequestMapping("/setEditorContent.do")
	//@ResponseBody
	public String setEditorContent(Model model, String editorValue) {
		//System.out.println(editorValue);
		if (!editorValue.equals("")){
			this.content = editorValue;
		}
		
		model.addAttribute("content",this.content);
		return "../test/editor_index";
	}

	
	@RequestMapping("/getEditorContent.do")
	public String getEditorContent() {

		//List<String> listContent = new ArrayList<String>();
		//listContent.add(this.content);
		//return listContent;
		return this.content;
	}

}
