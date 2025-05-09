<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ja">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>削除完了</title>
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

.event-details p {
	margin: 10px 0;
}

.event-details .timestamp {
	font-size: 0.8rem;
	color: #888;
}

.btn {
	margin-top: 20px;
}

.center-align {
	text-align: center;
}
</style>
</head>

<body>

	<!-- ナビゲーションバー -->
	<nav>
		<div class="nav-wrapper teal lighten-2">
			<a href="#" class="brand-logo center">イベント管理</a>
		</div>
	</nav>

	<!-- 削除完了表示 -->
	<div class="container">
		<div class="card">
			<h5 class="card-title center-align">イベントの削除が完了しました</h5>

			<div class="event-details">
				<h6>
					<strong>削除したイベント情報</strong>
				</h6>
				
				<p>
					<strong>タイトル:</strong> ${event.title}
				</p>
				<p>
					<strong>開催日時:</strong> ${formattedDateTime}
				</p>
				<p>
					<strong>詳細:</strong> ${event.description}
				</p>
				<p class="timestamp">
					<strong>作成日時:</strong> ${formattedCreatedAt}
				</p>
				<p class="timestamp">
					<strong>更新日時:</strong> ${formattedUpdatedAt}
				</p>
			</div>

			<div class="center-align">
				<a href="/home" class="btn waves-effect waves-light teal">ホームへ戻る</a>
			</div>
		</div>
	</div>

	<!-- Materialize JS -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

</body>

</html>
