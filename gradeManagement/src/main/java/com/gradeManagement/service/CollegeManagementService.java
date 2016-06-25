package com.gradeManagement.service;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gradeManagement.dao.CollegeManagementDao;
import com.gradeManagement.model.College;

@Service("collegeManagementService")
public class CollegeManagementService {

	Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private CollegeManagementDao collegeManagementDao;

	public List<College> getCollegeManagementList() {
		return collegeManagementDao.getCollegeManagementList();
	}

	public void addCollegeManagement(College college) {
		collegeManagementDao.addCollegeManagement(college);
	}

	public boolean checkCollegePkOverlap(College college) {
		boolean checkResult = collegeManagementDao.checkCollegePkOverlap(college) == 0 ? true : false;
			
		return checkResult;
	}
}
