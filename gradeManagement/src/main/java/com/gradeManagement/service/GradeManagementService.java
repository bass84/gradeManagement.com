package com.gradeManagement.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gradeManagement.dao.GradeManagementDao;
import com.gradeManagement.model.Courses;
import com.gradeManagement.model.Subject;

import net.sf.json.JSONArray;

@Service("grademanagementService")
public class GradeManagementService {
	
	Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private GradeManagementDao gradeManagementDao;
	
	public void addManagement(Subject subject) {
		gradeManagementDao.addManagement(subject);
		
	}

	public List<Courses> getCourseList(Subject subject) {
		subject.setSemester(subject.getYear().toString() + subject.getSemester());
		return gradeManagementDao.getCourseList(subject);
	}
	@Transactional
	public void addStudentForCourses(Courses courses, String student) {
		String[] students = student.split(",");
		for(String s : students) {
			courses.setStudentId(Integer.parseInt(s));
			gradeManagementDao.addStudentForCourses(courses);
		}
	}

	@Transactional
	public boolean deleteStudentIncourses(String checkedValue) {
		Courses courses = new Courses();
		String courseValues[] = checkedValue.split(",");
		int deleteLength = 0;
		for(String value : courseValues) {
			courses.setCollegeId(Integer.parseInt(value.split("#")[0]));
			courses.setStudentId(Integer.parseInt(value.split("#")[1]));
			courses.setSemester(value.split("#")[2]);
			courses.setSubjectName(value.split("#")[3]);
			gradeManagementDao.deleteStudentIncourses(courses);
			++deleteLength;
		}

		if(deleteLength > 0) {
			return true;
		}
		else {
			return false;
		}
	}
	
	@Transactional
	public boolean insertScores(String coursesValueJson) {
		JSONArray scoreListJson = JSONArray.fromObject(coursesValueJson);
		
		int addCount = 0;
		int scoreListCount = scoreListJson.size();
		
		for(; addCount < scoreListCount; addCount++) {
			Courses courses = new Courses();
			courses.setAttendance(Integer.parseInt(scoreListJson.getJSONObject(addCount).getString("attendance")));
			courses.setAttendanceScore(Integer.parseInt(scoreListJson.getJSONObject(addCount).getString("attendanceScore")));
			courses.setMidtermExamScore(Integer.parseInt(scoreListJson.getJSONObject(addCount).getString("midtermExamScore")));
			courses.setFinalExamScore(Integer.parseInt(scoreListJson.getJSONObject(addCount).getString("finalExamScore")));
			courses.setReportScore(Integer.parseInt(scoreListJson.getJSONObject(addCount).getString("reportScore")));
			courses.setTotalScore(Integer.parseInt(scoreListJson.getJSONObject(addCount).getString("totalScore")));
			courses.setStudentId(Integer.parseInt(scoreListJson.getJSONObject(addCount).getString("studentId")));
			courses.setCollegeId(Integer.parseInt(scoreListJson.getJSONObject(addCount).getString("collegeId")));
			courses.setSemester(scoreListJson.getJSONObject(addCount).getString("semester"));
			courses.setSubjectName(scoreListJson.getJSONObject(addCount).getString("subjectName"));
			logger.info(courses);
			gradeManagementDao.insertScores(courses);
		}
		if(addCount == scoreListCount) {
			return true;
		}
		else {
			return false;
		}
		
		
	}


}
