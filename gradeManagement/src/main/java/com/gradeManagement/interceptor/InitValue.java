package com.gradeManagement.interceptor;

import java.util.List;

import javax.servlet.ServletRequest;
import javax.servlet.ServletRequestEvent;
import javax.servlet.ServletRequestListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.springframework.beans.factory.annotation.Autowired;

import com.gradeManagement.dao.CollegeManagementDao;
import com.gradeManagement.model.College;

public class InitValue implements HttpSessionListener{

	
	@Autowired
	private CollegeManagementDao collegeManagementDao;

	List<College> collegeList;
	
	@Override
	public void sessionCreated(HttpSessionEvent event) {
		HttpSession session = event.getSession();
		collegeList = collegeManagementDao.getCollegeManagementList();
		session.setAttribute("collegeList", collegeList);
		
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent arg0) {
		// TODO Auto-generated method stub
		
	}
	
	
	
//	@Autowired
//	private CollegeManagementDao collegeManagementDao;
//	private List<College> collegeList;
//	
//	public List<College> getCollegeList() {
//		return collegeList;
//	}
//
//	public void setCollegeList() {
//		this.collegeList = collegeManagementDao.getCollegeManagementList();
//	}
	
	
	
	
	
}
