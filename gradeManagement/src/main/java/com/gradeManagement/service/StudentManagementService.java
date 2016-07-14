package com.gradeManagement.service;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gradeManagement.dao.StudentManagementDao;
import com.gradeManagement.model.College;
import com.gradeManagement.model.Student;
import com.gradeManagement.model.Subject;

@Service("studentManagementService")
public class StudentManagementService {

	Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private StudentManagementDao studentManagementDao;
	
	public List<Student> getStudentManagementList(College college) {
		return studentManagementDao.getStudentManagementList(college);
	}

	public void addStudent(Student student, College college) {
		student.setCollegeId(college.getCollegeId());
		studentManagementDao.addStudent(student);
	}

	public Student getStudent(Student student) {
		return studentManagementDao.getStudent(student);
	}

	public boolean checkStudentPkOverlap(Student student) {
		int checkCount = studentManagementDao.checkStudentPkOverlap(student);
		return checkCount > 0 ? false : true;
	}

	public boolean deleteStudent(Student student) {
		int deleteResult = studentManagementDao.deleteStudent(student);
		return deleteResult > 0 ? true : false;
	}

	public List<Student> getStudentInCourseList(Subject subject) {
		return studentManagementDao.getStudentInCourseList(subject);
	}

}
