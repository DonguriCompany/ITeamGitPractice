package jp.co.hoge.dto;

import java.time.LocalDateTime;

public class EventDTO {
	private Long id;
	private String title;
	private String start; // FullCalendar用にISO 8601形式の日時を文字列で保持
	private String description;

	public EventDTO(Long id, String title, LocalDateTime dateTime, String description) {
		this.id = id;
		this.title = title;
		this.start = dateTime.toString(); // dateTime -> ISO 8601形式の文字列
		this.description = description;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getStart() {
		return start;
	}

	public void setStart(String start) {
		this.start = start;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
}
