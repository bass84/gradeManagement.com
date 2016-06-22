package com.gradeManagement.controller;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gradeManagement.model.GradeManagement;
import com.gradeManagement.service.GradeManagementService;

@Controller
@RequestMapping("/management")
public class GradeManagementController {
	
	Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private GradeManagementService gradeManagementService;
	
	@RequestMapping(value="/getManagementList", method = RequestMethod.GET)
	public String addManagement(ModelMap modelMap, GradeManagement gradeManagement) {
		modelMap.addAttribute("headTitle", "관리정보 입력");
		return "/management/managementList";
	}
	
	@RequestMapping(value="/addManagement", method = RequestMethod.POST)
	public String addManagementPost(ModelMap modelMap, GradeManagement gradeManagement) {
		logger.info("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$" + gradeManagement.toString());
		return "redirect:getManagementList";
	}

}
