package jp.co.hoge.dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class UserDTO {
	private Long id;
	private String username;
	private String email;
	private String createdAt; // フォーマット済みの日付
	private String updatedAt; // フォーマット済みの日付
	private Boolean isAdmin;  // 管理者フラグ

	private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

	public UserDTO(Long id, String username, String email, LocalDateTime createdAt, LocalDateTime updatedAt, Boolean isAdmin) {
		this.id = id;
		this.username = username;
		this.email = email;
		this.createdAt = createdAt != null ? createdAt.format(FORMATTER) : null;
		this.updatedAt = updatedAt != null ? updatedAt.format(FORMATTER) : null;
		this.isAdmin = isAdmin;
	}

	// Getter and Setter
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}

	public String getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(String updatedAt) {
		this.updatedAt = updatedAt;
	}

	public Boolean getIsAdmin() {
		return isAdmin;
	}

	public void setIsAdmin(Boolean isAdmin) {
		this.isAdmin = isAdmin;
	}
}
