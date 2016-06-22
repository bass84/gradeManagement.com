package com.gradeManagement.model;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;
import org.apache.ibatis.type.Alias;

@Alias("courses")
public class Courses {
	
	private int collegeId;
	private int studentId;
	private String semester;
	private String subjectName;
	private int attendance;
	private int attendanceScore;
	private int midtermExamScore;
	private int finalExamScore;
	private int reportScore;
	
	public int getCollegeId() {
		return collegeId;
	}
	public void setCollegeId(int collegeId) {
		this.collegeId = collegeId;
	}
	public int getStudentId() {
		return studentId;
	}
	public void setStudentId(int studentId) {
		this.studentId = studentId;
	}
	public String getSemester() {
		return semester;
	}
	public void setSemester(String semester) {
		this.semester = semester;
	}
	public String getSubjectName() {
		return subjectName;
	}
	public void setSubjectName(String subjectName) {
		this.subjectName = subjectName;
	}
	public int getAttendance() {
		return attendance;
	}
	public void setAttendance(int attendance) {
		this.attendance = attendance;
	}
	public int getAttendanceScore() {
		return attendanceScore;
	}
	public void setAttendanceScore(int attendanceScore) {
		this.attendanceScore = attendanceScore;
	}
	public int getMidtermExamScore() {
		return midtermExamScore;
	}
	public void setMidtermExamScore(int midtermExamScore) {
		this.midtermExamScore = midtermExamScore;
	}
	public int getFinalExamScore() {
		return finalExamScore;
	}
	public void setFinalExamScore(int finalExamScore) {
		this.finalExamScore = finalExamScore;
	}
	public int getReportScore() {
		return reportScore;
	}
	public void setReportScore(int reportScore) {
		this.reportScore = reportScore;
	}
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}
	
	
	

}
