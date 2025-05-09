<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>イベント編集</title>
<!-- Materialize CSS -->
<link rel="stylesheet" href="<c:url value='/css/materialize.min.css' />">
<!-- Flatpickr CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
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

.btn {
	margin-top: 20px;
}

.btn-back {
	background-color: #e0e0e0;
	color: #424242;
	margin-left: 10px;
}
</style>
</head>
<body>
	<!-- ナビゲーションバー -->
	<nav>
		<div class="nav-wrapper teal lighten-2">
			<a href="#" class="brand-logo center">イベント編集</a>
		</div>
	</nav>

	<!-- 編集フォーム -->
	<div class="container">
		<div class="card">
			<h5 class="card-title">イベント編集フォーム</h5>
			<form action="/event-edit" method="post">
				<input type="hidden" name="id" value="${event.id}" />

				<!-- タイトル -->
				<div class="input-field">
					<label for="title">タイトル</label> <input id="title" type="text"
						name="title" value="${event.title}" required />
				</div>

				<!-- 開催日時 -->
				<div class="input-field">
					<label for="dateTime">開催日時</label> <input id="dateTime" type="text"
						name="dateTime" value="${formattedDateTime}" required />
				</div>

				<!-- 詳細 -->
				<div class="input-field">
					<label for="description">詳細</label>
					<textarea id="description" class="materialize-textarea"
						name="description" required>${event.description}</textarea>
				</div>

				<!-- ボタン -->
				<div>
					<button type="submit"
						class="btn waves-effect waves-light teal lighten-2">更新</button>
					<a href="/event-detail/${event.id}"
						class="btn btn-back waves-effect">イベント詳細へ戻る</a>
				</div>
			</form>
		</div>
	</div>

	<!-- Materialize JS -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
	<!-- Flatpickr JS -->
	<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
	<script>
        // Flatpickr 初期化
        flatpickr("#dateTime", {
            enableTime: true,
            dateFormat: "Y-m-d\\TH:i", // HTML datetime-local 互換形式
            defaultDate: "${formattedDateTime}" // 初期値を設定
        });
    </script>
</body>
</html>
