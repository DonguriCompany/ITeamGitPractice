package jp.co.hoge.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import jp.co.hoge.entity.Event;

public interface EventRepository extends JpaRepository<Event, Long> {

	// 日時順でイベントを取得
	List<Event> findAllByOrderByDateTimeAsc();

	// 月でイベントを取得
	@Query("SELECT e FROM Event e WHERE TO_CHAR(e.dateTime, 'YYYY-MM') = :month")
	List<Event> findByMonth(@Param("month") String month);
}

