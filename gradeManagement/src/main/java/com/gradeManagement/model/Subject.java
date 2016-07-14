package com.gradeManagement.model;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;
import org.apache.ibatis.type.Alias;

@Alias("subject")
public class Subject {

	private Integer collegeId;
	private String collegeName;
	private Integer year;
	private String semester;
	private String subjectName;
	private Integer gradeType;
	private String gradeTypeName;
	private Integer attendanceScoreRatio;
	private String useYn;

	public Integer getCollegeId() {
		return collegeId;
	}

	public void setCollegeId(Integer collegeId) {
		this.collegeId = collegeId;
	}

	public String getCollegeName() {
		return collegeName;
	}


	public void setCollegeName(String collegeName) {
		this.collegeName = collegeName;
	}


	public Integer getYear() {
		return year;
	}


	public void setYear(Integer year) {
		this.year = year;
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


	public Integer getGradeType() {
		return gradeType;
	}


	public void setGradeType(Integer gradeType) {
		this.gradeType = gradeType;
	}


	public String getGradeTypeName() {
		return gradeTypeName;
	}


	public void setGradeTypeName(String gradeTypeName) {
		this.gradeTypeName = gradeTypeName;
	}


	public Integer getAttendanceScoreRatio() {
		return attendanceScoreRatio;
	}


	public void setAttendanceScoreRatio(Integer attendanceScoreRatio) {
		this.attendanceScoreRatio = attendanceScoreRatio;
	}
	
	
	public String getUseYn() {
		return useYn;
	}

	
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}
	
	
}
