package jp.co.hoge.entity;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "events")
@Data // Lombokでゲッター、セッター、toString、equals、hashCodeを自動生成
@NoArgsConstructor // 引数なしコンストラクタを生成
@AllArgsConstructor // 全フィールドを引数に持つコンストラクタを生成
public class Event {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(nullable = false)
	private String title;

	@Column(columnDefinition = "TEXT")
	private String description;

	@Column(name = "event_date_time", nullable = false)
	private LocalDateTime dateTime;

	@Column(name = "created_at", nullable = false)
	private LocalDateTime createdAt = LocalDateTime.now();

	@Column(name = "updated_at")
	private LocalDateTime updatedAt;

	@Column(name = "deleted_at")
	private LocalDateTime deletedAt; // 論理削除用

	// 作成日時がnullだった場合現在の日時
	@PrePersist
	public void prePersist() {
		if (this.createdAt == null) {
			this.createdAt = LocalDateTime.now();
		}
	}

	// 更新日時がnullだった場合現在の日時
	@PreUpdate
	public void preUpdate() {
		this.updatedAt = LocalDateTime.now();
	}

	// LocalDateTimeをDateに変換するヘルパーメソッド
	public Date getDateTimeAsDate() {
		return Date.from(dateTime.atZone(ZoneId.systemDefault()).toInstant());
	}

	// createdAtをDateに変換するヘルパーメソッド
	public Date getCreatedAtAsDate() {
		return Date.from(createdAt.atZone(ZoneId.systemDefault()).toInstant());
	}

	// updatedAtをDateに変換するヘルパーメソッド
	public Date getUpdatedAtAsDate() {
		return updatedAt != null ? Date.from(updatedAt.atZone(ZoneId.systemDefault()).toInstant()) : null;
	}
}
