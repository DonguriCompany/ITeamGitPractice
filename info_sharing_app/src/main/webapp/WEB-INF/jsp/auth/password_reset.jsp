<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>パスワードリセット</title>
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
		<h2>パスワードリセット</h2>

		<!-- パスワード不一致エラー -->
		<c:if test="${not empty passwordMatchError}">
			<div class="card-panel red lighten-2">
				<span class="white-text">${passwordMatchError}</span>
			</div>
		</c:if>

		<!-- ユーザーが存在しないエラー -->
		<c:if test="${not empty userExistenceError}">
			<div class="card-panel red lighten-2">
				<span class="white-text">${userExistenceError}</span>
			</div>
		</c:if>

		<form action="${pageContext.request.contextPath}/password-reset"
			method="post">
			<div class="input-field">
				<label for="username">ユーザー名</label> <input type="text" id="username"
					name="username" required />
			</div>

			<div class="input-field">
				<label for="newPassword">新しいパスワード</label> <input type="password"
					id="newPassword" name="newPassword" required />
			</div>

			<div class="input-field">
				<label for="confirmPassword">新しいパスワード（確認）</label> <input
					type="password" id="confirmPassword" name="confirmPassword"
					required />
			</div>

			<div class="buttons">
				<button type="submit" class="btn waves-effect waves-light">パスワードをリセット</button>
				<a href="/login" class="btn waves-effect waves-light blue">ログイン画面に戻る</a>
			</div>
		</form>
	</div>

	<!-- Materialize JS -->
	<script src="<c:url value='/js/materialize.min.js' />"></script>
</body>
</html>
