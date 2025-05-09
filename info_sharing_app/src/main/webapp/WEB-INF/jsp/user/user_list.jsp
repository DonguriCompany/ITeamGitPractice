<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ユーザー一覧</title>
<!-- Materialize CSS -->
<link rel="stylesheet" href="<c:url value='/css/materialize.min.css' />">
<style>
.admin-actions {
	position: absolute;
	right: 20px;
}

.nav-wrapper {
	padding: 0 20px;
}
</style>
</head>
<body>

	<!-- ナビゲーションバー -->
	<nav>
		<div class="nav-wrapper teal darken-3">
			<a href="#" class="brand-logo center">ユーザー一覧</a>
		</div>
	</nav>

	<div class="row">
		<div class="col s12">
			<!-- ユーザー一覧のテーブル -->
			<table class="highlight responsive-table">
				<thead>
					<tr>
						<th>ユーザー名</th>
						<c:if test="${isAdmin}">
							<th>メールアドレス</th>
							<th>権限</th>
						</c:if>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="user" items="${users}">
						<tr>
							<td>${user.username}</td>
							<c:if test="${isAdmin}">
								<td>${user.email}</td>
								<td>${user.isAdmin ? '管理者' : '一般'}</td>
							</c:if>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>

	<!-- ホームに戻るリンク -->
	<div class="center-align">
		<a href="/home" class="btn waves-effect waves-light">ホームに戻る</a>
	</div>

	<!-- 管理者用アクション -->
	<c:if test="${isAdmin}">
		<div class="admin-actions">
			<a href="/user-manage"
				class="btn-large waves-effect waves-light teal">ユーザー管理画面</a>
		</div>
	</c:if>
	</div>

	<!-- Materialize JavaScript -->
	<script src="${pageContext.request.contextPath}/js/materialize.min.js"></script>

</body>
</html>