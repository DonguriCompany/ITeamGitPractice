<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ユーザー編集</title>
<!-- Materialize CSS -->
<link rel="stylesheet" href="<c:url value='/css/materialize.min.css' />">
</head>
<body>
	<div class="container">
		<h2 class="center-align">ユーザー編集</h2>
		<form action="/user-edit/${user.id}" method="post" class="row">
			<!-- ユーザー名 -->
			<div class="input-field col s12">
				<label for="username" class="active">ユーザー名</label> <input
					type="text" id="username" name="username" value="${user.username}"
					required>
			</div>

			<!-- メールアドレス -->
			<div class="input-field col s12">
				<label for="email" class="active">メールアドレス</label> <input
					type="email" id="email" name="email" value="${user.email}" required>
			</div>

			<!-- 管理者権限 -->
			<div class="col s12">
				<label> <input type="checkbox" id="isAdmin" name="isAdmin"
					${user.isAdmin ? 'checked' : ''}> <span>管理者権限</span>
				</label>
			</div>

			<!-- 更新ボタン -->
			<div class="col s12 center-align">
				<button type="submit" class="btn waves-effect waves-light blue">更新</button>
				<a href="/user-manage" class="btn waves-effect waves-light grey">キャンセル</a>
			</div>
		</form>
	</div>

	<!-- Materialize JavaScript -->
	<script src="${pageContext.request.contextPath}/js/materialize.min.js"></script>
</body>
</html>
