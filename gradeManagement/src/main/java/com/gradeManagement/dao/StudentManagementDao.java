package com.gradeManagement.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gradeManagement.model.College;
import com.gradeManagement.model.Student;

@Repository("studentManagementDao")
public class StudentManagementDao {

	@Autowired
	private SqlSession sqlSessionTemplate;
	
	public List<Student> getStudentManagementList(College college) {
		return sqlSessionTemplate.selectList("studentManagementDao.getStudentManagementList", college);
	}

	public void addStudent(Student student) {
		sqlSessionTemplate.insert("studentManagementDao.addStudent", student);
	}

	public Student getStudent(Student student) {
		return sqlSessionTemplate.selectOne("studentManagementDao.getStudent", student);
	}

	public int checkStudentPkOverlap(Student student) {
		return sqlSessionTemplate.selectOne("studentManagementDao.checkStudentPkOverlap", student);
	}

}
