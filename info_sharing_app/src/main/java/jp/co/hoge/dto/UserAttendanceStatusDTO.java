package jp.co.hoge.dto;

import java.util.Date;

public class UserAttendanceStatusDTO {

	private String username;
	private String attendanceStatus;
	private Date updatedAt;  // LocalDateTime -> Date に変更

	public UserAttendanceStatusDTO(String username, String attendanceStatus, Date updatedAt) {
		this.username = username;
		this.attendanceStatus = attendanceStatus;
		this.updatedAt = updatedAt;
	}

	// ゲッターセッター
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getAttendanceStatus() {
		return attendanceStatus;
	}

	public void setAttendanceStatus(String attendanceStatus) {
		this.attendanceStatus = attendanceStatus;
	}

	public Date getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}
}
