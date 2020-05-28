package com.learn;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.learn.Aravindh.entity.Systemreport;
import com.learn.Aravindh.service.TableService;

@Controller
public class HomeController {
	
	@Autowired
	private TableService tableService;
	
	@RequestMapping("/")
	public String Home(Model theModel, @ModelAttribute("tabledata") Systemreport systemreport){
		
		List<Systemreport> dbresult=tableService.getTableData();
		theModel.addAttribute("tabledata",dbresult);
		System.out.println(dbresult);
		return "index";
	}

}
