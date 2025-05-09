<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>出欠確認完了</title>
<!-- Materialize CSS -->
<link rel="stylesheet" href="<c:url value='/css/materialize.min.css' />">
<style>
body {
	padding: 20px;
}

.container {
	max-width: 800px;
	margin: 0 auto;
}

.card {
	padding: 20px;
}

.card-title {
	font-size: 1.8rem;
}

table {
	width: 100%;
	margin-top: 20px;
}

th, td {
	padding: 12px;
	text-align: center;
}

.btn {
	margin-top: 20px;
}
</style>
</head>
<body>

	<div class="container">
		<!-- 出欠確認完了メッセージ -->
		<div class="card">
			<h2 class="card-title">イベント出欠確認完了</h2>
			<h3>${event.title}</h3>

			<!-- 出欠状況テーブル -->
			<h4>参加者の出欠状況</h4>
			<table class="striped">
				<thead>
					<tr>
						<th>ユーザー名</th>
						<th>出欠ステータス</th>
						<th>更新日時</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="participant" items="${participants}">
						<tr>
							<td>${participant.username}</td>
							<td>${participant.attendanceStatus}</td>
							<td><fmt:formatDate value="${participant.updatedAt}"
									pattern="yyyy-MM-dd HH:mm" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<!-- イベント一覧ページへのリンク -->
			<a href="${pageContext.request.contextPath}/event-list"
				class="btn waves-effect waves-light blue">イベント一覧へ戻る</a>
		</div>
	</div>

	<!-- Materialize JSの読み込み -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
</body>
</html>
