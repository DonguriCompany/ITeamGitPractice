package jp.co.hoge.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import jp.co.hoge.entity.User;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

	Optional<User> findByUsername(String username);

	Optional<User> findByEmail(String email);

	// 管理者ユーザーのみ取得
	List<User> findByIsAdminTrue();

	boolean existsByUsername(String username);

	boolean existsByEmail(String email);
}
