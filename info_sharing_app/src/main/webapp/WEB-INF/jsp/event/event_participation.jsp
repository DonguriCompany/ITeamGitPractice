<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>イベント出欠選択</title>
<!-- Materialize CSS -->
<link rel="stylesheet" href="<c:url value='/css/materialize.min.css' />">
<style>
body {
	padding: 20px;
}

.container {
	max-width: 600px;
	margin: 0 auto;
}

.card {
	padding: 20px;
	margin-bottom: 20px;
}

.card-title {
	font-size: 1.8rem;
}

.btn {
	width: 100%;
}
</style>
</head>
<body>

	<div class="container">
		<!-- イベント詳細 -->
		<div class="card">
			<h2 class="card-title">イベント出欠選択</h2>

			<h5>${event.title}</h5>
			<p>
				<strong>説明:</strong> ${event.description}
			</p>
			<p>
				<strong>日時:</strong> ${event.dateTime}
			</p>
		</div>

		<!-- 出欠選択フォーム -->
		<form
			action="${pageContext.request.contextPath}/event-participation/${event.id}"
			method="post">
			<div class="card">
				<h5>参加の可否を選択してください</h5>

				<!-- 参加ラジオボタン -->
				<p>
					<label> <input type="radio" name="attendance_status"
						value="attending"
						${participant != null && participant.attendanceStatus == 'attending' ? 'checked' : ''}>
						<span>参加</span>
					</label>
				</p>

				<!-- 不参加ラジオボタン -->
				<p>
					<label> <input type="radio" name="attendance_status"
						value="not_attending"
						${participant != null && participant.attendanceStatus == 'not_attending' ? 'checked' : ''}>
						<span>不参加</span>
					</label>
				</p>

				<!-- 未定ラジオボタン -->
				<p>
					<label> <input type="radio" name="attendance_status"
						value="maybe"
						${participant != null && participant.attendanceStatus == 'maybe' ? 'checked' : ''}>
						<span>未定</span>
					</label>
				</p>

				<br>

				<!-- 送信ボタン -->
				<button type="submit" class="btn waves-effect waves-light blue">送信</button>
			</div>
		</form>
	</div>

	<!-- Materialize JS -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
</body>
</html>
