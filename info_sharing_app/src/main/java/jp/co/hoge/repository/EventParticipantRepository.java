package jp.co.hoge.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import jp.co.hoge.entity.EventParticipant;

@Repository
public interface EventParticipantRepository extends JpaRepository<EventParticipant, Long> {

	// イベントIDとユーザーIDに基づいて出欠情報を取得
	EventParticipant findByEventIdAndUserId(Long eventId, Long userId);

	// イベントIDに基づいて全ての参加者を取得
	List<EventParticipant> findByEventId(Long eventId);

	// 参加者情報を削除
	void deleteByEventId(Long eventId);

	void deleteByUserId(Long userId);
}
