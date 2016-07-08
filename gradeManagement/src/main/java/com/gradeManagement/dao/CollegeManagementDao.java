package com.gradeManagement.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gradeManagement.model.College;

@Repository("collegeManagementDao")
public class CollegeManagementDao {

	Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private SqlSession sqlSessionTemplate;
	
	public List<College> getCollegeManagementList() {
		return sqlSessionTemplate.selectList("collegeManagementDao.getCollegeManagementList");
	}

	public void addCollegeManagement(College college) {
		sqlSessionTemplate.insert("collegeManagementDao.addCollegeManagement", college);
		
	}

	public int checkCollegePkOverlap(College college) {
		return sqlSessionTemplate.selectOne("collegeManagementDao.checkCollegePkOverlap", college);
	}

	public College getCollege(College college) {
		return sqlSessionTemplate.selectOne("collegeManagementDao.getCollege", college);
	}
}
