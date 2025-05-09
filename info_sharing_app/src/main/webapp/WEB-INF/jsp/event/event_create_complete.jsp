<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ja">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>イベント登録完了</title>
<!-- Materialize CSS -->
<link rel="stylesheet" href="<c:url value='/css/materialize.min.css' />">

<style>
.container {
	margin-top: 50px;
}

.card {
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.card-title {
	font-size: 1.5rem;
	font-weight: bold;
}

.event-info {
	margin-bottom: 20px;
}

.event-info p {
	margin: 10px 0;
}

.btn {
	margin-top: 20px;
}
</style>
</head>

<body>

	<!-- ナビゲーションバー -->
	<nav>
		<div class="nav-wrapper teal">
			<a href="#" class="brand-logo center">イベント作成</a>
		</div>
	</nav>

	<!-- イベント登録完了画面 -->
	<div class="container">
		<div class="card">
			<h5 class="card-title center-align">イベント登録完了</h5>
			<div class="event-info">
				<p>
					<strong>イベント名:</strong> ${event.title}
				</p>
				<p>
					<strong>開催日時:</strong>
					<fmt:formatDate value="${event.getDateTimeAsDate()}"
						pattern="yyyy-MM-dd HH:mm" />
				</p>
				<p>
					<strong>詳細:</strong> ${event.description}
				</p>
			</div>

			<!-- ホームに戻るボタン -->
			<div class="center-align">
				<a href="/home" class="btn waves-effect waves-light teal">ホームに戻る</a>
			</div>
		</div>
	</div>

	<!-- Materialize JS -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
</body>

</html>
