<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ユーザー削除完了</title>
<!-- Materialize CSS -->
<link rel="stylesheet" href="<c:url value='/css/materialize.min.css' />">
</head>
<body>
	<div class="container">
		<h2 class="center-align">ユーザー削除が完了しました</h2>
		<p class="center-align">以下の内容のユーザーを削除しました。</p>

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
					<td>ユーザーID</td>
					<td>${deletedUser.id}</td>
				</tr>
				<tr>
					<td>ユーザー名</td>
					<td>${deletedUser.username}</td>
				</tr>
				<tr>
					<td>メールアドレス</td>
					<td>${deletedUser.email}</td>
				</tr>
				<tr>
					<td>権限</td>
					<td>${deletedUser.isAdmin ? '管理者' : '一般'}</td>
				</tr>
				<tr>
					<td>作成日時</td>
					<td><fmt:formatDate value="${createdAtDate}"
							pattern="yyyy-MM-dd HH:mm" /></td>
				</tr>
				<tr>
					<td>更新日時</td>
					<td><fmt:formatDate value="${updatedAtDate}"
							pattern="yyyy-MM-dd HH:mm" /></td>
				</tr>
			</tbody>
		</table>

		<!-- 戻るボタン -->
		<div class="center-align" style="margin-top: 20px;">
			<a href="/user-list"
				class="btn waves-effect waves-light teal darken-3">ユーザー一覧に戻る</a>
		</div>
	</div>

	<!-- Materialize JavaScript -->
	<script src="${pageContext.request.contextPath}/js/materialize.min.js"></script>
</body>
</html>
