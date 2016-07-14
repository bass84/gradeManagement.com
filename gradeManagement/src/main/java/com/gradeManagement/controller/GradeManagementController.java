package com.gradeManagement.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gradeManagement.model.College;
import com.gradeManagement.model.Courses;
import com.gradeManagement.model.GradeManagement;
import com.gradeManagement.model.Student;
import com.gradeManagement.model.Subject;
import com.gradeManagement.service.CollegeManagementService;
import com.gradeManagement.service.GradeManagementService;
import com.gradeManagement.service.StudentManagementService;
import com.gradeManagement.service.SubjectManagementService;

@Controller
@RequestMapping("/management")
public class GradeManagementController {
	
	Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private GradeManagementService gradeManagementService;
	
	@Autowired
	private CollegeManagementService collegeManagementService;
	
	@Autowired
	private SubjectManagementService subjectManagementService;
	
	@Autowired
	private StudentManagementService studentManagementService;
	
	@RequestMapping(value="/getManagementList", method = RequestMethod.GET)
	public String getManagementList(ModelMap modelMap, GradeManagement gradeManagement) {
		List<College> collegeList = collegeManagementService.getCollegeManagementList();
		List<Subject> subjectList = subjectManagementService.getSubjectManagementList();
		List<Subject> subjectListUseY = new ArrayList<Subject>();
		List<Subject> subjectListUseN = new ArrayList<Subject>();
		for(Subject subject : subjectList) {
			if(subject.getUseYn() != null && subject.getUseYn().equals("Y")) {
				subjectListUseY.add(subject);
			}
			else {
				subjectListUseN.add(subject);
			}
		}
		modelMap.addAttribute("headTitle", "관리정보 입력");
		modelMap.addAttribute("subjectListUseY", subjectListUseY);
		modelMap.addAttribute("subjectListUseN", subjectListUseN);
		modelMap.addAttribute("collegeList", collegeList);
		modelMap.addAttribute("subjectList", subjectListUseY);
		return "/management/managementList";
	}
	
	@RequestMapping(value="/addManagement", method = RequestMethod.POST)
	public String addManagement(Subject subject) {
		gradeManagementService.addManagement(subject);
		return "redirect:getManagementList";
	}
	
	@RequestMapping(value="/getManagementView", method = RequestMethod.GET)
	public String getManagementView(ModelMap modelMap, Subject subject) {
		subject = subjectManagementService.getSubjectManagement(subject);
		List<Courses> courseList = gradeManagementService.getCourseList(subject);
		List<Student> studentList = studentManagementService.getStudentInCourseList(subject);
		List<Subject> subjectList = subjectManagementService.getSubjectManagementList();
		List<Subject> subjectListUseY = new ArrayList<Subject>();
		
		for(Subject s : subjectList) {
			if(s.getUseYn() != null && s.getUseYn().equals("Y")) {
				subjectListUseY.add(s);
			}
		}
		
		modelMap.addAttribute("subject", subject);
		modelMap.addAttribute("courseList", courseList);
		modelMap.addAttribute("studentList", studentList);
		modelMap.addAttribute("subjectList", subjectListUseY);
		return "/management/managementView";
	}
	
	@RequestMapping(value="/addStudentForCourses", method = RequestMethod.POST)
	public String addStudentForCourses(Courses courses, String student, @RequestParam String subjectName) throws UnsupportedEncodingException {
		gradeManagementService.addStudentForCourses(courses, student);
		String urlParam = "?collegeId=" + courses.getCollegeId() + "&semester=" + courses.getSemester() + "&subjectName=" + URLEncoder.encode(courses.getSubjectName(), "UTF-8");
		return "redirect:getManagementView" + urlParam;
	}
	
	@RequestMapping(value="/deleteStudentIncourses", method = RequestMethod.POST)
	@ResponseBody
	public boolean deleteStudentIncourses(String checkedValue) {
		boolean isResult = gradeManagementService.deleteStudentIncourses(checkedValue);
		return isResult;
	}

}
