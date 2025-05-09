<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>パスワードリセット完了</title>
<!-- Materialize CSS -->
<link rel="stylesheet" href="<c:url value='/css/materialize.min.css' />">
<style>
body {
	padding: 20px;
	font-family: Arial, sans-serif;
}

.container {
	max-width: 600px;
	margin: auto;
}

h1 {
	text-align: center;
	color: #26a69a;
}

table {
	width: 100%;
	margin: 20px 0;
	border-collapse: collapse;
}

th, td {
	padding: 10px;
	text-align: left;
}

th {
	background-color: #f0f0f0;
}

td {
	border-bottom: 1px solid #ddd;
}

.btn {
	background-color: #26a69a;
}

.btn:hover {
	background-color: #00796b;
}

#togglePassword {
	background: none;
	border: none;
	font-size: 18px;
	cursor: pointer;
}
</style>
<script>
        function togglePasswordVisibility() {
            const passwordField = document.getElementById('password');
            const icon = document.getElementById('togglePassword');
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                icon.textContent = 'パスワードを非表示🙈';
            } else {
                passwordField.type = 'password';
                icon.textContent = 'パスワードを表示👁️';
            }
        }
    </script>
</head>
<body>
	<div class="container">
		<h1>パスワードリセットが完了しました</h1>
		<p>以下の内容でリセットされました：</p>
		<table>
			<tr>
				<th>ユーザー名</th>
				<td>${user.username}</td>
			</tr>
			<tr>
				<th>新しいパスワード</th>
				<td><input type="password" id="password"
					value="${user.passwordHash}" readonly>
					<button type="button" id="togglePassword"
						onclick="togglePasswordVisibility()">パスワードを表示👁️</button></td>
			</tr>
		</table>
		<div class="center-align">
			<a href="${pageContext.request.contextPath}/login"
				class="btn waves-effect waves-light blue">ログイン画面へ</a>
		</div>
	</div>
</body>
</html>
