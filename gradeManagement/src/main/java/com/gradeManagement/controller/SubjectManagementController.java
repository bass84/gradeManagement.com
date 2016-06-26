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
import com.gradeManagement.model.Subject;
import com.gradeManagement.service.CollegeManagementService;
import com.gradeManagement.service.SubjectManagementService;

@Controller
@RequestMapping(value="/subjectManagement")
public class SubjectManagementController {

	Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private SubjectManagementService subjectManagementService;
	
	@Autowired
	private CollegeManagementService collegeManagementService;
	
	@RequestMapping(value="/getSubjectManagementList", method=RequestMethod.GET)
	public String getSubjectManagementList(ModelMap modelMap) {
		List<Subject> subjectManagementList =  subjectManagementService.getSubjectManagementList();
		List<College> collegeList = collegeManagementService.getCollegeManagementList();
		modelMap.addAttribute("headTitle", "수업관리");
		modelMap.addAttribute("subjectManagementList", subjectManagementList);
		modelMap.addAttribute("collegeList", collegeList);
		return "/subjectManagement/subjectManagementList";
	}
	
	@RequestMapping(value="/addSubjectManagement", method=RequestMethod.POST)
	public String addSubjectManagement(ModelMap modelMap, Subject subject) {
		subjectManagementService.addSubjectManagement(subject);
		return "redirect:getSubjectManagementList";
	}
	
	@RequestMapping(value="/getSubjectManagement", method=RequestMethod.GET)
	@ResponseBody
	public Subject getSubjectManagement(Subject subject) {
		subject = subjectManagementService.getSubjectManagement(subject);
		return subject;
	}
	
	@RequestMapping(value="/updateSubjectManagement", method=RequestMethod.POST)
	public String updateSubManagement(Subject subject) {
		subjectManagementService.updateSubjectManagement(subject);
		return "redirect:getSubjectManagementList";
	}
	
	@RequestMapping(value="/checkSubjectPkOverlap", method=RequestMethod.GET)
	@ResponseBody
	public boolean checkSubjectPkOverlap(Subject subject) {
		boolean checkResult = subjectManagementService.checkSubjectPkOverlap(subject);
		return checkResult;
	}
	
	@RequestMapping(value="/deleteSubjectManagement", method=RequestMethod.POST)
	@ResponseBody
	public boolean deleteSubjectManagement(Subject subject) {
		return false;
	}
}
