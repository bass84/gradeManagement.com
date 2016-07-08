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
import com.gradeManagement.model.Student;
import com.gradeManagement.service.CollegeManagementService;
import com.gradeManagement.service.StudentManagementService;

@Controller
@RequestMapping("/studentManagement")
public class StudentManagementController {

	Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private StudentManagementService studentManagementService;
	
	@Autowired
	private CollegeManagementService collegeManagementService;

	@RequestMapping(value="getStudentManagementList", method=RequestMethod.GET)
	public String getStudentManagementList(ModelMap modelMap, Student student, College college) {
		List<Student> studentManagementList = studentManagementService.getStudentManagementList(college);
		List<College> collegeManagementList = collegeManagementService.getCollegeManagementList();
		for(College c : collegeManagementList) {
			if(c.getCollegeId() == college.getCollegeId()) {
				college.setCollegeId(c.getCollegeId());
				college.setCollegeName(c.getCollegeName());
			}
		}
		modelMap.addAttribute("studentManagementList", studentManagementList);
		modelMap.addAttribute("collegeList", collegeManagementList);
		modelMap.addAttribute("headTitle","학생정보");
		modelMap.addAttribute("college", college);
		return "/studentManagement/studentManagementList";
	}
	
	@RequestMapping(value="addStudent", method=RequestMethod.POST)
	public String addStudent(Student student, College college) {
		studentManagementService.addStudent(student, college);
		return "redirect:getStudentManagementList?collegeId=1";
	}
	
	
	@RequestMapping(value="getStudentManagement", method=RequestMethod.GET)
	@ResponseBody
	public Student getStudent(Student student) {
		student = studentManagementService.getStudent(student);
		return student;
	}
	
	@RequestMapping(value="checkStudentPkOverlap", method=RequestMethod.GET)
	@ResponseBody
	public boolean checkStudentPkOverlap(Student student) {
		boolean checkResult = studentManagementService.checkStudentPkOverlap(student);
		return checkResult;
	}
	

}