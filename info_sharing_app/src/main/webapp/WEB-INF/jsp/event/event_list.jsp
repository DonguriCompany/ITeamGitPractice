<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ja">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>イベント一覧</title>
<!-- Materialize CSS -->
<link rel="stylesheet" href="<c:url value='/css/materialize.min.css' />">
<style>
.container {
	margin-top: 50px;
}

.filter-section {
	margin-bottom: 20px;
}

.table-title {
	font-size: 1.2rem;
	font-weight: bold;
}

.btn {
	margin-top: 20px;
}
</style>
</head>

<body>

	<!-- ナビゲーションバー -->
	<nav>
		<div class="nav-wrapper teal lighten-2">
			<a href="#" class="brand-logo center">イベント一覧</a>
		</div>
	</nav>

	<div class="container">
		<!-- フィルタリング -->
		<div class="filter-section">
			<form action="/event-list" method="get" class="input-field">
				<label for="month"></label> <select name="month" id="month"
					class="browser-default" onchange="this.form.submit()">
					<option value="">すべて</option>
					<c:forEach var="month" items="${months}">
						<option value="${month}"
							${selectedMonth == month ? 'selected' : ''}>${month}</option>
					</c:forEach>
				</select>
			</form>
		</div>

		<!-- イベント一覧 -->
		<table class="highlight responsive-table">
			<thead>
				<tr>
					<th class="table-title">タイトル</th>
					<th class="table-title">日時</th>
					<th class="table-title">説明</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="event" items="${events}" varStatus="status">
					<tr>
						<td><a href="/event-detail/${event.id}">${event.title}</a></td>
						<td><c:out value="${formattedDates[status.index]}" /></td>
						<td>${event.description}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		<!-- ボタン -->
		<div class="center-align">
			<a href="/home" class="btn waves-effect waves-light">ホームに戻る</a>
		</div>
	</div>

	<!-- Materialize JS -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

</body>

</html>
