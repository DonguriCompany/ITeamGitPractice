<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ja">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>イベント詳細</title>
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

.event-details {
	margin-bottom: 20px;
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

.share-buttons {
	display: flex;
	text-align: center;
	justify-content: space-around;
}

.action-buttons {
	display: flex;
	justify-content: center;
	padding: 20px;
}

.action-buttons .btn {
    min-width: 150px;
    margin: 0 10px;
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

	<!-- 管理者向けオプション -->
	<c:if test="${isAdmin}">
		<div class="action-buttons">
			<a href="/event-edit/${event.id}"
				class="btn waves-effect waves-light orange">編集</a>
			<form action="/event-delete/${event.id}" method="POST"
				onsubmit="return confirm('本当に削除しますか？');">
				<button type="submit" class="btn waves-effect waves-light red">削除</button>
			</form>
		</div>
	</c:if>

	<!-- イベント詳細表示 -->
	<div class="container">
		<div class="card">
			<h5 class="card-title center-align">イベント詳細</h5>
			<div class="event-details">
				<p>
					<strong>タイトル:</strong> ${event.title}
				</p>
				<p>
					<strong>開催日時:</strong>
					<fmt:formatDate value="${event.dateTimeAsDate}"
						pattern="yyyy-MM-dd HH:mm" />
				</p>
				<p>
					<strong>詳細:</strong> ${event.description}
				</p>
				<p class="timestamp">
					<strong>作成日時:</strong>
					<fmt:formatDate value="${event.createdAtAsDate}"
						pattern="yyyy-MM-dd HH:mm" />
				</p>
				<p class="timestamp">
					<strong>更新日時:</strong>
					<fmt:formatDate value="${event.updatedAtAsDate}"
						pattern="yyyy-MM-dd HH:mm" />
				</p>
			</div>

			<!-- 出欠選択ボタン -->
			<div class="center-align">
				<a href="/event-participation/${event.id}"
					class="btn waves-effect waves-light red lighten-2">出欠を選択</a>
				<a href="/event-participation-complete/${event.id}"
					class="btn waves-effect waves-light blue lighten-2">出欠を確認</a>
			</div>

			<div class="share-buttons">
				<!-- LINE共有ボタン -->
				<a href="https://line.me/R/msg/text/?イベント詳細%0Aタイトル: ${event.title}%0A開催日時: ${event.dateTime}%0A詳細ページ: ${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/event-detail/${event.id}"
					target="_blank" class="btn waves-effect waves-light green">
					LINEで共有 </a>
				<!-- 情報をコピーするボタン -->
				<button type="button" onclick="copyToClipboard()"
					class="btn waves-effect waves-light blue">情報をコピーする</button>
			</div>
		</div>
	</div>

	<!-- ホームへ戻るボタン -->
	<div class="center-align">
		<a href="/home" class="btn waves-effect waves-light">ホームへ戻る</a>
	</div>

	<!-- Materialize JS -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

	<script>
        function copyToClipboard() {
            const title = "タイトル: ${event.title}";
            const dateTime = "開催日時: ${event.dateTime}";
            const url = "詳細ページ: ${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/event-detail/${event.id}";
            const textToCopy = title + "\n" + dateTime + "\n" + url;

            navigator.clipboard.writeText(textToCopy).then(() => {
                alert("イベント情報をコピーしました！\n\n" + textToCopy);
            }).catch(err => {
                alert("コピーに失敗しました。ブラウザ設定をご確認ください。\n" + err);
            });
        }
    </script>

</body>

</html>
