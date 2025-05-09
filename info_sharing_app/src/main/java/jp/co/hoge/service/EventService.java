package jp.co.hoge.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jp.co.hoge.dto.EventDTO;
import jp.co.hoge.entity.Event;
import jp.co.hoge.repository.EventParticipantRepository;
import jp.co.hoge.repository.EventRepository;

@Service
public class EventService {

	@Autowired
	private EventRepository eventRepository;

	@Autowired
	private EventParticipantRepository eventParticipantRepository;

	// 全イベント取得
	public List<EventDTO> getAllEvents() {
		List<Event> events = eventRepository.findAll();
		return events.stream()
				.map(event -> new EventDTO(
						event.getId(),
						event.getTitle(),
						event.getDateTime(),
						event.getDescription()))
				.collect(Collectors.toList());
	}

	// イベントを保存
	public void saveEvent(Event event) {
		eventRepository.save(event);
	}

	// イベントをIDで取得
	public Event findById(Long id) {
		return eventRepository.findById(id)
				.orElseThrow(() -> new IllegalArgumentException("Invalid event ID: " + id));
	}

	public void updateEvent(Event updatedEvent) {
		Event existingEvent = eventRepository.findById(updatedEvent.getId())
				.orElseThrow(() -> new IllegalArgumentException("イベントが見つかりません"));
		existingEvent.setTitle(updatedEvent.getTitle());
		existingEvent.setDescription(updatedEvent.getDescription());
		existingEvent.setDateTime(updatedEvent.getDateTime());
		existingEvent.setUpdatedAt(LocalDateTime.now());
		eventRepository.save(existingEvent);
	}

	// イベントの削除
	@Transactional
	public void deleteEvent(Long id) {
		// 参加者情報を削除（eventIdが一致するレコードを削除）
		eventParticipantRepository.deleteByEventId(id);

		// イベント情報を削除
		eventRepository.deleteById(id);
	}

	// 日時順で全イベント取得
	public List<Event> getAllEventsSortedByDate() {
		return eventRepository.findAllByOrderByDateTimeAsc();
	}

	// 指定された月のイベントを取得
	public List<Event> getEventsByMonth(String month) {
		return eventRepository.findByMonth(month);
	}
}
