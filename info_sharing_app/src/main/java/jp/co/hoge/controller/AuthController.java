package jp.co.hoge.controller;

import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jp.co.hoge.dto.PasswordResetDTO;
import jp.co.hoge.dto.UserRegistrationDTO;
import jp.co.hoge.entity.User;
import jp.co.hoge.service.UserService;

@Controller
public class AuthController {

	@Autowired
	private UserService userService;

	// デフォルト画面表示
	@GetMapping("/")
	public String redirectLoginPage() {
		return "redirect:/login";
	}

	// ログイン画面表示
	@GetMapping("/login")
	public String showLoginPage() {
		return "auth/login";
	}

	// ログイン処理
	@PostMapping("/login")
	public String handleLogin(@RequestParam String username, @RequestParam String password, HttpSession session, Model model) {
		// サービスでログイン処理を実行
		String errorMessage = userService.loginUser(username, password);

		if (errorMessage == null) {
			// ログイン成功時、セッションに必要な情報を保存
			User user = userService.findByUsername(username);  // ユーザー情報を再取得
			session.setAttribute("userId", user.getId());        // ユーザーID
			session.setAttribute("username", username);         // ユーザー名
			session.setAttribute("isAdmin", user.getIsAdmin()); // 管理者フラグ
			return "redirect:/home";  // ログイン後のホームへリダイレクト
		}

		// ログイン失敗時にエラーメッセージを渡す
		model.addAttribute("errorMessage", errorMessage);
		return "auth/login";  // ログイン画面に戻る
	}

	// 新規登録画面の表示
	@GetMapping("/register")
	public String showRegisterPage() {
		return "auth/register";
	}

	// 新規登録処理
	@PostMapping("/register")
	public String handleRegister(@Validated @ModelAttribute UserRegistrationDTO userDTO, BindingResult result, HttpSession session, Model model) {
		// ユーザー登録処理
		String usernameError = userService.checkUsername(userDTO.getUsername());
		String emailError = userService.checkEmail(userDTO.getEmail());
		String passwordMatchError = userDTO.getPassword().equals(userDTO.getConfirmPassword()) ? null : "パスワードと確認用パスワードが一致しません";

		// エラーがある場合は戻る
		if (usernameError != null || emailError != null || passwordMatchError != null) {
			if (usernameError != null) model.addAttribute("usernameError", usernameError);
			if (emailError != null) model.addAttribute("emailError", emailError);
			if (passwordMatchError != null) model.addAttribute("passwordMatchError", passwordMatchError);
			return "auth/register";
		}

		// サービス層でユーザー登録処理
		String errorMessage = userService.registerUser(userDTO);
		if (errorMessage != null) {
			model.addAttribute("errorMessage", errorMessage);
			return "auth/register";  // 登録画面に戻る
		}

		session.setAttribute("username", userDTO.getUsername());
		model.addAttribute("user", userDTO); // 登録したユーザー情報を完了画面で表示するためにModelに追加
		return "auth/register_complete";
	}

	// パスワードリセット画面表示
	@GetMapping("/password-reset")
	public String showPasswordResetPage() {
		return "auth/password_reset";
	}

	// パスワードリセット処理
	@Validated
	@PostMapping("/password-reset")
	public String handlePasswordReset(@ModelAttribute PasswordResetDTO passwordResetDTO, BindingResult result, Model model) {
		// バリデーションエラーがあれば再度フォームに戻す
		if (result.hasErrors()) {
			return "auth/password_reset";
		}

		// パスワード一致確認をサービス層で行う
		String passwordMatchError = userService.validatePasswordMatch(passwordResetDTO.getNewPassword(), passwordResetDTO.getConfirmPassword());
		if (passwordMatchError != null) {
			model.addAttribute("passwordMatchError", passwordMatchError); // パスワード一致エラーを追加
		}

		// ユーザーの存在確認
		String userExistenceError = userService.validateUserExistence(passwordResetDTO.getUsername());
		if (userExistenceError != null) {
			model.addAttribute("userExistenceError", userExistenceError); // ユーザー存在エラーを追加
		}

		// エラーメッセージがあれば戻す
		if (model.containsAttribute("passwordMatchError") || model.containsAttribute("userExistenceError")) {
			return "auth/password_reset";  // エラーがある場合はフォームに戻る
		}

		// パスワードリセット処理はエラーがない場合のみ実行
		userService.resetPassword(passwordResetDTO.getUsername(), passwordResetDTO.getNewPassword());

		// リセット後に再度ユーザー情報を取得
		User updatedUser = userService.findByUsername(passwordResetDTO.getUsername()); // リセット後のユーザー情報を再取得

		// モデルにユーザー情報を追加
		model.addAttribute("user", updatedUser); // リセットしたユーザー情報を表示
		return "auth/password_reset_complete"; // 完了画面に遷移
	}

	// パスワードリセット完了画面表示
	@GetMapping("/password-reset-complete")
	public String showPasswordResetCompletePage(Model model) {
		return "auth/password_reset_complete"; // パスワードリセット完了ページに遷移
	}

	// ログアウト処理
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		// セッションを無効化
		session.invalidate();
		return "redirect:/logout-complete";
	}

	// ログアウト完了ページ表示
	@GetMapping("/logout-complete")
	public String showLogoutCompletePage() {
		return "auth/logout_complete";
	}
}
