<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ユーザー編集完了</title>
<!-- Materialize CSS -->
<link rel="stylesheet" href="<c:url value='/css/materialize.min.css' />">
</head>
<body>
	<div class="container">
		<h2 class="center-align">ユーザー編集完了</h2>
		<p class="center-align">以下の内容でユーザー情報を更新しました。</p>

		<!-- テーブル -->
		<table class="highlight centered">
			<thead>
				<tr>
					<th>項目</th>
					<th>内容</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>ユーザー名</td>
					<td>${updatedUser.username}</td>
				</tr>
				<tr>
					<td>メールアドレス</td>
					<td>${updatedUser.email}</td>
				</tr>
				<tr>
					<td>権限</td>
					<td>${updatedUser.isAdmin ? '管理者' : '一般'}</td>
				</tr>
			</tbody>
		</table>

		<!-- ボタン -->
		<div class="center-align" style="margin-top: 20px;">
			<a href="/user-list" class="btn waves-effect waves-light blue">ユーザー一覧に戻る</a>
		</div>
	</div>

	<!-- Materialize JavaScript -->
	<script src="${pageContext.request.contextPath}/js/materialize.min.js"></script>
</body>
</html>
