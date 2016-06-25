package com.gradeManagement.controller;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gradeManagement.model.College;
import com.gradeManagement.service.CollegeManagementService;

@Controller
@RequestMapping(value="/collegeManagement")
public class CollegeManagementCotroller {

	Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private CollegeManagementService collegeManagementService;
	
	@RequestMapping(value="/getCollegeManagementList", method=RequestMethod.GET)
	public String getCollegeManagementList(ModelMap modelMap, College college) {
		List<College> collegeManagementList =  collegeManagementService.getCollegeManagementList();
		modelMap.addAttribute("headTitle", "학교관리");
		modelMap.addAttribute("collegeManagementList", collegeManagementList);
		
		return "/collegeManagement/collegeManagementList";
	}
	
	@RequestMapping(value="/addCollegeManagement", method=RequestMethod.POST)
	public String addCollegeManagement(College college) {
		logger.info("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$" + college);
		collegeManagementService.addCollegeManagement(college);
		return "redirect:getCollegeManagementList";
	}
	
	@RequestMapping(value="/checkCollegePkOverlap", method=RequestMethod.GET)
	@ResponseBody
	public boolean checkCollegePkOverlap(College college) {
		boolean checkResult = collegeManagementService.checkCollegePkOverlap(college);
		
		return checkResult;
	}
	
	//@RequestMapping(value="/getCollegeManagement", method=RequestMethod.GET)
	
}
