package jp.co.hoge.controller;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jp.co.hoge.dto.UserAttendanceStatusDTO;
import jp.co.hoge.entity.Event;
import jp.co.hoge.entity.EventParticipant;
import jp.co.hoge.entity.User;
import jp.co.hoge.service.EventParticipantService;
import jp.co.hoge.service.EventService;
import jp.co.hoge.service.UserService;

@Controller
public class EventParticipantController {

	@Autowired
	private EventService eventService;

	@Autowired
	private EventParticipantService eventParticipantService;

	@Autowired
	private UserService userService;

	// 出欠登録画面表示
	@GetMapping("/event-participation/{eventId}")
	public String showParticipationForm(@PathVariable Long eventId, HttpSession session, Model model) {
		Event event = eventService.findById(eventId);
		Long userId = (Long) session.getAttribute("userId");

		// ログインされているかのチェック
		if (userId == null) {
			// ログイン画面へリダイレクト
			return "redirect:/login";
		}

		EventParticipant participant = eventParticipantService.findByEventIdAndUserId(eventId, userId);

		model.addAttribute("event", event);
		model.addAttribute("participant", participant);
		return "event/event_participation";
	}

	// 出欠登録処理
	@PostMapping("/event-participation/{eventId}")
	public String handleParticipation(
			@PathVariable Long eventId,
			@RequestParam String attendance_status,
			HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");

		// 出欠情報を保存または更新
		eventParticipantService.saveOrUpdateParticipant(eventId, userId, attendance_status);

		return "redirect:/event-participation-complete/" + eventId; // 完了画面にリダイレクト
	}

	// 出欠確認完了画面
	@GetMapping("/event-participation-complete/{eventId}")
	public String showParticipationComplete(@PathVariable Long eventId, HttpSession session, Model model) {
		Event event = eventService.findById(eventId);
		Long userId = (Long) session.getAttribute("userId");

		// 出欠参加者一覧を取得
		List<EventParticipant> participants = eventParticipantService.findByEventId(eventId);

		// 参加者のユーザー名を取得
		List<UserAttendanceStatusDTO> userAttendanceStatusList = new ArrayList<>();
		for (EventParticipant participant : participants) {
			User user = userService.findById(participant.getUserId());
			String attendanceStatus = getAttendanceStatusInJapanese(participant.getAttendanceStatus());

			// LocalDateTime を Date に変換
			LocalDateTime updatedAt = participant.getUpdatedAt();
			Date updatedAtDate = Date.from(updatedAt.atZone(ZoneId.systemDefault()).toInstant());

			userAttendanceStatusList.add(new UserAttendanceStatusDTO(user.getUsername(), attendanceStatus, updatedAtDate));
		}

		model.addAttribute("event", event);
		model.addAttribute("participants", userAttendanceStatusList);
		return "event/event_participation_complete";
	}


	// 出欠ステータスを日本語に変換
	private String getAttendanceStatusInJapanese(String attendanceStatus) {
		switch (attendanceStatus) {
		case "attending":
			return "参加";
		case "not_attending":
			return "不参加";
		case "maybe":
			return "未定";
		default:
			return "未定";
		}
	}
}
