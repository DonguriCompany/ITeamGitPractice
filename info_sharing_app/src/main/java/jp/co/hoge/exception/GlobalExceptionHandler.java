package jp.co.hoge.exception;

import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

@ControllerAdvice
public class GlobalExceptionHandler {

	// 予期しないエラーをキャッチ
	@ExceptionHandler(Exception.class)
	@ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)  // 500エラーを返す
	public String handleException(Exception ex, Model model) {
		model.addAttribute("error", ex.getMessage());
		return "shared/error";  // エラーページに遷移
	}

	// 404エラー（ページが見つからない場合）
	@ExceptionHandler(org.springframework.web.servlet.NoHandlerFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public String handleNotFoundException(NoHandlerFoundException ex, Model model) {
		model.addAttribute("error", "ページが見つかりません");
		return "shared/error";  // 404エラーページに遷移
	}
}
