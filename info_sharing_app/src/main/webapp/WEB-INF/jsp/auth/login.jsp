<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ログイン</title>
<!-- Materialize CSS -->
<link rel="stylesheet" href="<c:url value='/css/materialize.min.css' />">
<style>
body {
	background-color: #f5f5f5;
	display: flex;
	align-items: center;
	justify-content: center;
	height: 100vh;
	margin: 0;
}

.login-container {
	width: 100%;
	max-width: 400px;
	padding: 20px;
	border-radius: 10px;
	background-color: #fff;
}

.login-container .input-field {
	margin-bottom: 20px;
}

.btn {
	width: 100%;
}

.error-message {
	color: #f44336;
	background-color: #ffebee;
	border: 1px solid #f44336;
	padding: 10px;
	border-radius: 5px;
	text-align: center;
	margin-top: 15px;
}
</style>
</head>
<body>
	<div class="login-container card z-depth-2">
		<h4 class="center-align">ログイン</h4>
		<form action="${pageContext.request.contextPath}/login" method="post">
			<div class="input-field">
				<input type="text" id="username" name="username" required> <label
					for="username">ユーザー名</label>
			</div>
			<div class="input-field">
				<input type="password" id="password" name="password" required>
				<label for="password">パスワード</label>
			</div>
			<button type="submit" class="btn waves-effect waves-light blue">ログイン</button>
		</form>

		<!-- エラーメッセージ -->
		<c:if test="${not empty errorMessage}">
			<div class="error-message">${errorMessage}</div>
		</c:if>

		<div class="center-align">
			<a href="${pageContext.request.contextPath}/register">新規登録</a> | <a
				href="${pageContext.request.contextPath}/password-reset">パスワードを忘れた場合</a>
		</div>
	</div>
	<script src="<c:url value='/js/materialize.min.js' />"></script>
</body>
</html>
