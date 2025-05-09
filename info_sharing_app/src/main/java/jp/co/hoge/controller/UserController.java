package jp.co.hoge.controller;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jp.co.hoge.dto.UserDTO;
import jp.co.hoge.entity.User;
import jp.co.hoge.service.EventParticipantService;
import jp.co.hoge.service.UserService;

@Controller
public class UserController {

	@Autowired
	private UserService userService;

	@Autowired
	private EventParticipantService eventParticipantService;

	// ユーザー一覧表示
	@GetMapping("/user-list")
	public String showUserList(Model model, HttpSession session) {
		// 全ユーザーを取得し、DTOに変換
		List<UserDTO> users = userService.getAllUsers().stream()
				.map(user -> new UserDTO(user.getId(), user.getUsername(), user.getEmail(), user.getCreatedAt(), user.getUpdatedAt(), user.getIsAdmin()))
				.collect(Collectors.toList());
		model.addAttribute("users", users);

		// セッションから管理者権限を取得
		Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
		model.addAttribute("isAdmin", isAdmin != null && isAdmin);

		return "user/user_list";
	}

	// ユーザー管理画面表示
	@GetMapping("/user-manage")
	public String showUserManagePage(HttpSession session, Model model) {
		Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");

		if (isAdmin == null || !isAdmin) {
			// 権限がない場合は一覧画面にリダイレクト
			return "redirect:/user-list";
		}

		// 全ユーザーを取得し、DTOに変換
		List<UserDTO> users = userService.getAllUsers().stream()
				.map(user -> new UserDTO(user.getId(), user.getUsername(), user.getEmail(), user.getCreatedAt(), user.getUpdatedAt(), user.getIsAdmin()))
				.collect(Collectors.toList());
		model.addAttribute("users", users);

		return "user/user_manage";
	}

	// ユーザー編集画面表示
	@GetMapping("/user-edit/{id}")
	public String showUserEditPage(@PathVariable Long id, HttpSession session, Model model) {
		// 管理者チェック
		Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
		if (isAdmin == null || !isAdmin) {
			return "redirect:/user-list"; // 管理者でない場合はユーザー一覧にリダイレクト
		}

		User user = userService.getUserById(id); // ユーザーをIDで取得
		if (user == null) {
			return "redirect:/user-list"; // ユーザーが見つからない場合はリストに戻す
		}

		model.addAttribute("user", user);
		return "user/user_edit"; // 編集画面を表示
	}

	// ユーザー編集を行った場合の処理
	@PostMapping("/user-edit/{id}")
	public String handleUserEdit(
			@PathVariable Long id,
			@RequestParam String username,
			@RequestParam String email,
			@RequestParam(required = false) Boolean isAdmin,
			HttpSession session,
			Model model
			) {
		// 管理者チェック
		Boolean sessionIsAdmin = (Boolean) session.getAttribute("isAdmin");
		if (sessionIsAdmin == null || !sessionIsAdmin) {
			return "redirect:/user-list"; // 管理者でない場合は一覧画面にリダイレクト
		}

		// ユーザーを取得
		User user = userService.getUserById(id);
		if (user == null) {
			return "redirect:/user-list"; // ユーザーが見つからない場合は一覧画面にリダイレクト
		}

		// 入力データでユーザー情報を更新
		user.setUsername(username);
		user.setEmail(email);
		user.setIsAdmin(isAdmin != null ? isAdmin : false); // チェックボックスの未選択に対応
		userService.updateUser(user); // DBに保存

		// 完了画面用に更新情報をモデルに追加
		model.addAttribute("updatedUser", user);

		// 完了画面へリダイレクト
		return "user/user_edit_complete";
	}

	// ユーザー編集完了画面表示
	@GetMapping("/user-edit-complete")
	public String showUserEditCompletePage() {
		return "user/user_edit_complete";
	}

	// ユーザー削除完了画面表示
	@PostMapping("/user-delete/{id}")
	public String handleUserDelete(@PathVariable Long id, HttpSession session, Model model) {
		// 管理者チェック
		Boolean sessionIsAdmin = (Boolean) session.getAttribute("isAdmin");
		if (sessionIsAdmin == null || !sessionIsAdmin) {
			return "redirect:/user-list"; // 管理者でない場合は一覧画面にリダイレクト
		}

		// ユーザーを取得
		User user = userService.getUserById(id);
		if (user == null) {
			return "redirect:/user-list"; // ユーザーが見つからない場合は一覧画面にリダイレクト
		}

		// event_participants テーブルから該当ユーザーIDのレコードを削除
		eventParticipantService.deleteByUserId(id);  // 事前に関連レコードを削除

		// LocalDateTime -> Date に変換
		Date createdAtDate = convertToDate(user.getCreatedAt());
		Date updatedAtDate = convertToDate(user.getUpdatedAt());

		// 削除処理
		userService.deleteUser(id);

		// 完了画面用に削除した情報をモデルに追加
		model.addAttribute("deletedUser", user);
		model.addAttribute("createdAtDate", createdAtDate);
		model.addAttribute("updatedAtDate", updatedAtDate);

		// 完了画面へ遷移
		return "user/user_delete_complete";
	}

	// LocalDateTime -> Date に変換するメソッド
	private Date convertToDate(LocalDateTime localDateTime) {
		return Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant());
	}

}
