package jp.co.hoge.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jp.co.hoge.entity.EventParticipant;
import jp.co.hoge.repository.EventParticipantRepository;

@Service
public class EventParticipantService {

	@Autowired
	private EventParticipantRepository eventParticipantRepository;

	// イベントIDとユーザーIDに基づいて出欠情報を取得
	public EventParticipant findByEventIdAndUserId(Long eventId, Long userId) {
		return eventParticipantRepository.findByEventIdAndUserId(eventId, userId);
	}

	// イベントIDに基づいて全ての参加者を取得
	public List<EventParticipant> findByEventId(Long eventId) {
		return eventParticipantRepository.findByEventId(eventId);
	}

	// 出欠情報を保存または更新
	@Transactional
	public void saveOrUpdateParticipant(Long eventId, Long userId, String attendanceStatus) {
		// 既存の出欠情報を取得
		EventParticipant existingParticipant = eventParticipantRepository.findByEventIdAndUserId(eventId, userId);

		if (existingParticipant != null) {
			// 出欠情報を更新
			existingParticipant.setAttendanceStatus(attendanceStatus);
			existingParticipant.setUpdatedAt(LocalDateTime.now());
			eventParticipantRepository.save(existingParticipant);
		} else {
			// 新規出欠情報を作成
			EventParticipant participant = new EventParticipant();
			participant.setEventId(eventId);
			participant.setUserId(userId);
			participant.setAttendanceStatus(attendanceStatus);
			participant.setUpdatedAt(LocalDateTime.now()); // 新規作成時にも更新日時を設定
			participant.setCreatedAt(LocalDateTime.now());
			eventParticipantRepository.save(participant);
		}
	}

	// ユーザー削除前に参加情報も削除
	@Transactional
	public void deleteByUserId(Long userId) {
		eventParticipantRepository.deleteByUserId(userId);
	}
}
