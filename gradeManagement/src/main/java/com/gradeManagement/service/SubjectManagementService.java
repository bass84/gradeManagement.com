package com.gradeManagement.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gradeManagement.dao.SubjectManagementDao;
import com.gradeManagement.model.Subject;

@Service("subjectManagementService")
public class SubjectManagementService {

	@Autowired
	private SubjectManagementDao subjectManagementDao;

	@Transactional
	public void addSubjectManagement(Subject subject) {
		subject.setSemester(subject.getYear() + subject.getSemester());
		subjectManagementDao.addSubjectManagement(subject);
		
	}

	@Transactional
	public List<Subject> getSubjectManagementList() {
		return subjectManagementDao.getSubjectManagementList();
		
	}
	
	@Transactional
	public Subject getSubjectManagement(Subject subject) {
		return subjectManagementDao.getSubjectManagement(subject);
	}
	
	@Transactional
	public void updateSubjectManagement(Subject subject) {
		subject.setSemester(subject.getYear() + subject.getSemester());
		subjectManagementDao.updateSubjectManagement(subject);
		
	}
	@Transactional
	public boolean checkSubjectPkOverlap(Subject subject) {
		
		if(subject.getCollegeId() != 0 && subject.getYear() != 0 
				&& !subject.getSemester().equals("0")  && !subject.getSubjectName().equals("")) {
			subject.setSemester(subject.getYear() + subject.getSemester());
			return subjectManagementDao.checkSubjectPkOverlap(subject) == 0  ? true : false;
		}
		else {
			return true;
		}
		
	}

	
}
