package jp.co.hoge.controller;

import java.time.LocalDateTime;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jp.co.hoge.entity.Event;
import jp.co.hoge.service.EventService;

@Controller
public class EventController {

	@Autowired
	private EventService eventService;

	// イベント一覧ページ
	@GetMapping("/event-list")
	public String showEventList(@RequestParam(required = false) String month, Model model) {
		List<Event> events;

		// 月でフィルタリングされたイベントを取得
		if (month != null && !month.isEmpty()) {
			events = eventService.getEventsByMonth(month);
		} else {
			// 月指定なしの場合、全イベントを日付順に取得
			events = eventService.getAllEventsSortedByDate();
		}

		// 日付フォーマットを追加
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
		List<String> formattedDates = events.stream()
				.map(event -> {
					// dateTime が null の場合、デフォルトのメッセージを表示
					if (event.getDateTime() != null) {
						return event.getDateTime().format(formatter);
					} else {
						return "日付未設定"; // デフォルトメッセージ
					}
				})
				.collect(Collectors.toList());

		// フォーマット済みの日付をモデルに追加
		model.addAttribute("events", events);
		model.addAttribute("formattedDates", formattedDates);
		model.addAttribute("selectedMonth", month);

		// 選択可能な月を生成（過去1年から未来3ヶ月）
		List<String> months = IntStream.range(-12, 4) // 過去12ヶ月 + 未来3ヶ月
				.mapToObj(i -> YearMonth.now().plusMonths(i).toString()) // 月を生成
				.sorted(Comparator.reverseOrder()) // 降順にソート
				.collect(Collectors.toList());
		model.addAttribute("months", months);

		return "event/event_list"; // イベント一覧ページのテンプレート
	}


	// イベント管理画面表示
	@GetMapping("/event-manage")
	public String showEventManagePage() {
		return "event/event_manage";
	}

	// イベント登録フォームを表示
	@GetMapping("/event-create")
	public String showEventCreateForm(HttpSession session, Model model) {
		// 管理者チェック
		Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
		if (isAdmin == null || !isAdmin) {
			return "redirect:/event-list"; // 管理者でない場合はイベント一覧にリダイレクト
		}
		return "event/event_create"; // イベント作成フォームのページを返す
	}

	// イベント登録処理
	@PostMapping("/event-create")
	public String handleEventCreate(
			@RequestParam String title,
			@RequestParam String description,
			@RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm") LocalDateTime dateTime,
			Model model) {


		Event event = new Event();
		event.setTitle(title);
		event.setDescription(description);
		event.setDateTime(dateTime);
		eventService.saveEvent(event);
		model.addAttribute("event", event); // 登録したイベント情報を画面に渡す
		return "event/event_create_complete";
	}

	// イベント作成完了画面表示
	@GetMapping("/event-create-complete")
	public String showEventCreateCompletePage() {
		return "event/event_create_complete";
	}

	// イベント詳細画面表示
	@GetMapping("/event-detail/{id}")
	public String showEventDetail(@PathVariable Long id, HttpSession session, Model model) {
		Event event = eventService.findById(id);
		boolean isAdmin = session.getAttribute("isAdmin") != null && (boolean) session.getAttribute("isAdmin");

		model.addAttribute("event", event);
		model.addAttribute("isAdmin", isAdmin);
		return "event/event_detail";
	}

	// イベント編集画面表示
	@GetMapping("/event-edit/{id}")
	public String showEventEditForm(@PathVariable Long id, Model model) {
		Event event = eventService.findById(id);
		if (event == null) {
			return "error"; // イベントが見つからない場合のエラーページ
		}
		// LocalDateTimeをdatetime-local形式の文字列に変換
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
		String formattedDateTime = event.getDateTime().format(formatter);

		model.addAttribute("event", event);
		model.addAttribute("formattedDateTime", formattedDateTime); // フォーマット済み日付を渡す
		return "event/event_edit";
	}

	// イベント編集処理のエンドポイント
	@PostMapping("/event-edit")
	public String updateEvent(
			@RequestParam Long id,
			@RequestParam String title,
			@RequestParam String dateTime, // フォームから送信される文字列形式の日時
			@RequestParam String description,
			Model model) {

		Event event = eventService.findById(id);
		if (event == null) {
			return "error"; // イベントが見つからない場合のエラーページ
		}

		// 日付文字列を LocalDateTime に変換
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
		LocalDateTime parsedDateTime = LocalDateTime.parse(dateTime, formatter);

		// 更新処理
		event.setTitle(title);
		event.setDateTime(parsedDateTime);
		event.setDescription(description);
		eventService.saveEvent(event);

		// 編集後のイベント情報をモデルに追加
		model.addAttribute("event", event);

		// 編集完了画面にリダイレクト
		return "redirect:/event-edit-complete/" + id;
	}


	// イベント編集完了の処理
	@GetMapping("/event-edit-complete/{id}")
	public String showEventEditComplete(@PathVariable Long id, Model model) {
		Event event = eventService.findById(id);
		if (event == null) {
			return "error"; // イベントが見つからない場合のエラーページ
		}

		// フォーマット用のDateTimeFormatter
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

		// 各日時をフォーマット済み文字列に変換
		String formattedDateTime = event.getDateTime().format(formatter);
		String formattedCreatedAt = event.getCreatedAt().format(formatter);
		String formattedUpdatedAt = event.getUpdatedAt().format(formatter);

		// モデルに追加
		model.addAttribute("event", event);
		model.addAttribute("formattedDateTime", formattedDateTime);
		model.addAttribute("formattedCreatedAt", formattedCreatedAt);
		model.addAttribute("formattedUpdatedAt", formattedUpdatedAt);

		return "event/event_edit_complete";
	}


	// イベント削除処理のエンドポイント
	@PostMapping("/event-delete/{id}")
	public String deleteEvent(@PathVariable Long id, HttpSession session, Model model) {
		// イベントを削除する前に、削除するイベント情報を取得
		Event eventToDelete = eventService.findById(id);

		if (eventToDelete == null) {
			// イベントが存在しない場合のエラーハンドリング
			return "error"; // エラーページに遷移
		}

		// 参加者情報とイベント情報を削除
		eventService.deleteEvent(id);

		// 日付を文字列にフォーマット
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

		// Nullチェックとフォーマット
		String formattedDateTime = eventToDelete.getDateTime() != null ? eventToDelete.getDateTime().format(formatter) : "-";
		String formattedCreatedAt = eventToDelete.getCreatedAt() != null ? eventToDelete.getCreatedAt().format(formatter) : "-";
		String formattedUpdatedAt = eventToDelete.getUpdatedAt() != null ? eventToDelete.getUpdatedAt().format(formatter) : "-";

		// イベント情報とフォーマットした日付をモデルに渡す
		model.addAttribute("event", eventToDelete);
		model.addAttribute("formattedDateTime", formattedDateTime);
		model.addAttribute("formattedCreatedAt", formattedCreatedAt);
		model.addAttribute("formattedUpdatedAt", formattedUpdatedAt);

		// 削除したイベント情報をセッションに保存
		session.setAttribute("deletedEvent", eventToDelete);

		// 削除完了画面に遷移
		return "event/event_delete_complete"; 
	}

	// イベント削除完了画面表示
	@GetMapping("/event-delete-complete")
	public String showEventDeleteCompletePage(Model model) {
		// モデルにイベント情報がセットされているので、そのまま表示
		return "event/event_delete_complete";
	}
}
