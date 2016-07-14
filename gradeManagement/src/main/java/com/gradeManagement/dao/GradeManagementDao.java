package com.gradeManagement.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gradeManagement.model.Courses;
import com.gradeManagement.model.Subject;

@Repository("gradeManagementDao")
public class GradeManagementDao {

	@Autowired
	private SqlSession sqlSessionTemplate;
	
	public void addManagement(Subject subject) {
		sqlSessionTemplate.update("gradeManagementDao.addManagement", subject);
		
	}

	public List<Courses> getCourseList(Subject subject) {
		return sqlSessionTemplate.selectList("gradeManagementDao.getCourseList", subject);
	}

	public void addStudentForCourses(Courses courses) {
		sqlSessionTemplate.insert("gradeManagementDao.addStudentForCourses", courses);
	}

	public void deleteStudentIncourses(Courses courses) {
		sqlSessionTemplate.delete("gradeManagementDao.deleteStudentIncourses", courses);
	}


}
