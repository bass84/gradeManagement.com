package com.gradeManagement.controller;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gradeManagement.model.College;
import com.gradeManagement.model.Student;
import com.gradeManagement.service.StudentManagementService;

@Controller
@RequestMapping("/studentManagement")
public class StudentManagementController {

	Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private StudentManagementService studentManagementService;

	@RequestMapping(value="getStudentManagementList", method=RequestMethod.GET)
	public String getStudentManagementList(ModelMap modelMap, Student student, College college) {
		List<Student> studentManagementList = studentManagementService.getStudentManagementList(college);
		modelMap.addAttribute("studentManagementList", studentManagementList);
		modelMap.addAttribute("headTitle","학생정보");
		modelMap.addAttribute("college", college);
		return "/studentManagement/studentManagementList";
	}
}
