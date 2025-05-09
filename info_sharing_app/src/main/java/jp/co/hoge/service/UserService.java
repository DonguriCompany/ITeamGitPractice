package jp.co.hoge.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jp.co.hoge.dto.UserRegistrationDTO;
import jp.co.hoge.entity.User;
import jp.co.hoge.repository.UserRepository;

@Service
public class UserService {

	@Autowired
	private UserRepository userRepository;

	// 全ユーザーを取得
	public List<User> getAllUsers() {
		return userRepository.findAll();
	}

	// 管理者ユーザーのみ取得
	public List<User> getAdminUsers() {
		return userRepository.findByIsAdminTrue();
	}

	// ユーザーIDを基にユーザーを取得するメソッド
	public User findById(Long userId) {
		return userRepository.findById(userId).orElse(null);
	}

	// ユーザー名でユーザーを検索する
	public User findByUsername(String username) {
		return userRepository.findByUsername(username).orElse(null);
	}

	// ユーザーを保存
	public User saveUser(User user) {
		return userRepository.save(user);
	}

	// ユーザーIDでユーザーを取得
	public User getUserById(Long id) {
		return userRepository.findById(id).orElse(null);
	}

	// ユーザーの削除
	public void deleteUser(Long id) {
		userRepository.deleteById(id); // JPAで該当IDのデータを削除
	}

	// ユーザーの更新
	public void updateUser(User user) {
		userRepository.save(user); // JPAで保存（IDが既存なら更新される）
	}


	// ログイン処理
	public String loginUser(String username, String password) {
		User user = userRepository.findByUsername(username).orElse(null);

		if (user != null && user.getPasswordHash().equals(password)) {
			// パスワードが一致すればログイン成功
			return null;
		}

		// ユーザー名またはパスワードが間違っている場合
		return "ユーザー名またはパスワードが間違っています";
	}



	// ユーザー名の重複チェック
	public String checkUsername(String username) {
		if (userRepository.existsByUsername(username)) {
			return "このユーザー名はすでに使用されています";
		}
		return null;  // エラーなし
	}

	// メールアドレスの重複チェック
	public String checkEmail(String email) {
		if (userRepository.existsByEmail(email)) {
			return "このメールアドレスはすでに使用されています";
		}
		return null;  // エラーなし
	}

	// ユーザー登録処理
	public String registerUser(UserRegistrationDTO userDTO) {
		// ユーザーオブジェクトを作成
		User user = new User();
		user.setUsername(userDTO.getUsername());
		user.setEmail(userDTO.getEmail());

		// パスワードをそのまま設定（ハッシュ化しない）
		user.setPasswordHash(userDTO.getPassword());

		// ユーザーを保存
		userRepository.save(user);
		return null;  // エラーなし
	}



	// パスワード一致確認
	public String validatePasswordMatch(String newPassword, String confirmPassword) {
		if (!newPassword.equals(confirmPassword)) {
			return "パスワードが一致しません";
		}
		return null;  // 一致していればエラーなし
	}

	// ユーザー存在確認
	public String validateUserExistence(String username) {
		User user = userRepository.findByUsername(username).orElse(null);

		if (user == null) {
			return "ユーザーが見つかりません";
		}
		return null;  // ユーザーが存在する場合はエラーなし
	}

	// パスワードリセット処理
	public String resetPassword(String username, String newPassword) {
		// ユーザーの存在確認
		String userExistenceError = validateUserExistence(username);
		if (userExistenceError != null) {
			return userExistenceError;  // ユーザーが見つからない場合、エラーメッセージを返す
		}

		// ユーザーを取得
		User user = userRepository.findByUsername(username).orElse(null);

		// パスワードを更新する処理
		if (user != null) {
			user.setPasswordHash(newPassword);
			userRepository.save(user);
		}

		return null;  // エラーメッセージがない場合は正常終了
	}

}
