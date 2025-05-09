<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>イベント登録</title>
<!-- Materialize CSS -->
<link rel="stylesheet" href="<c:url value='/css/materialize.min.css' />">
<!-- Flatpickr CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<style>
body {
	display: flex;
	flex-direction: column;
	min-height: 100vh;
}

main {
	flex: 1;
}

.header-title {
	margin: 0;
	padding: 20px 0;
}

.nav-wrapper {
	padding: 0 20px;
}

.input-field {
	margin-bottom: 20px;
}

.buttons {
	display: flex;
	justify-content: space-around;
	padding: 20px;
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

	<!-- 登録フォーム -->
	<main class="container">
		<div class="row">
			<div class="col s12">
				<h4 class="header-title teal-text">イベント登録</h4>
			</div>
		</div>
		<div class="row">
			<div class="col s12 m6 offset-m3">
				<form action="/event-create" method="post">
					<!-- イベント名 -->
					<div class="input-field">
						<label for="title">イベント名</label> <input type="text" id="title"
							name="title" required>
					</div>

					<!-- 開催日時 -->
					<div class="input-field">
						<label for="dateTime">開催日時</label> <input type="text"
							id="dateTime" name="dateTime" required>
					</div>

					<!-- 詳細 -->
					<div class="input-field">
						<label for="description">詳細</label>
						<textarea id="description" name="description"
							class="materialize-textarea" required></textarea>
					</div>

					<!-- 登録ボタン -->
					<div class="buttons">
						<button type="submit" class="btn waves-effect waves-light">登録</button>
						<a href="/home" class="btn waves-effect waves-light teal">ホーム画面に戻る</a>
					</div>
				</form>
			</div>
		</div>
	</main>

	<!-- 必要なJavaScriptライブラリ -->
	<script src="<c:url value='/js/materialize.min.js' />"></script>
	<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
	<!-- Flatpicker用のスクリプト -->
	<script>
		document.addEventListener('DOMContentLoaded', function() {
			flatpickr("#dateTime", {
				enableTime : true,
				dateFormat : "Y-m-d H:i",
				time_24hr : true, // 24時間形式
				minuteIncrement : 1
			// 分の選択は1分単位
			});
		});
	</script>
</body>
</html>
