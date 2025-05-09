<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>新規登録</title>
<!-- Materialize CSS -->
<link rel="stylesheet" href="<c:url value='/css/materialize.min.css' />">
<style>
body {
	padding: 20px;
}

.container {
	max-width: 500px;
	margin: auto;
}

h2 {
	text-align: center;
	margin-bottom: 30px;
}

.input-field input:focus {
	border-bottom: 2px solid #26a69a;
	box-shadow: 0 1px 0 0 #26a69a;
}

.input-field label {
	color: #26a69a;
}

.buttons {
	display: flex;
	justify-content: space-around;
	padding: 20px;
}
</style>
</head>
<body>
	<div class="container">
		<h2>新規登録</h2>

		<!-- ユーザー名エラー -->
		<c:if test="${not empty usernameError}">
			<div class="card-panel red lighten-2">
				<span class="white-text">${usernameError}</span>
			</div>
		</c:if>

		<!-- メールアドレスエラー -->
		<c:if test="${not empty emailError}">
			<div class="card-panel red lighten-2">
				<span class="white-text">${emailError}</span>
			</div>
		</c:if>

		<!-- パスワード不一致エラー -->
		<c:if test="${not empty passwordMatchError}">
			<div class="card-panel red lighten-2">
				<span class="white-text">${passwordMatchError}</span>
			</div>
		</c:if>

		<form action="${pageContext.request.contextPath}/register"
			method="POST">
			<div class="input-field">
				<input type="text" id="username" name="username" required> <label
					for="username">ユーザー名</label>
			</div>

			<div class="input-field">
				<input type="email" id="email" name="email" required> <label
					for="email">メールアドレス</label>
			</div>

			<div class="input-field">
				<input type="password" id="password" name="password" required>
				<label for="password">パスワード</label>
			</div>

			<div class="input-field">
				<input type="password" id="confirmPassword" name="confirmPassword"
					required> <label for="confirmPassword">パスワード確認</label>
			</div>

			<div class="buttons">
				<button type="submit" class="btn waves-effect waves-light">登録</button>
				<a href="/login" class="btn waves-effect waves-light blue">ログイン画面に戻る</a>
			</div>
		</form>
	</div>

	<!-- Materialize JS -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
</body>
</html>