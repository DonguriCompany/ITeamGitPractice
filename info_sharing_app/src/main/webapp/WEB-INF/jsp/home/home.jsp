<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ホーム</title>
<!-- Materialize CSS -->
<link rel="stylesheet" href="<c:url value='/css/materialize.min.css' />">
<!-- FullCalendar CSS -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.2.0/fullcalendar.min.css"
	rel="stylesheet" />
<style>
body {
	display: flex;
	flex-direction: column;
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

#calendar {
	margin: 20px auto;
	transform: scale(0.9);
    transform-origin: top center;
}
.page-footer {
	position: fixed;
	bottom: 0;
	width: 100%;
}
</style>
</head>
<body>
	<!-- ヘッダー -->
	<header>
		<nav>
			<div class="nav-wrapper teal">
				<a href="#" class="brand-logo">InfoSharingApp</a>
				<ul id="nav-mobile" class="right hide-on-med-and-down">
					<!-- 管理者かどうかをチェックしてリンクを表示 -->
					<c:if test="${sessionScope.isAdmin}">
						<li><a href="${pageContext.request.contextPath}/event-create">イベント新規作成</a></li>
					</c:if>
					<li><a href="${pageContext.request.contextPath}/event-list">イベント一覧</a></li>
					<li><a href="${pageContext.request.contextPath}/user-list">ユーザー一覧</a></li>
					<li><a href="${pageContext.request.contextPath}/logout">ログアウト</a></li>
				</ul>
			</div>
		</nav>
	</header>


	<!-- メインコンテンツ -->
	<main class="container">
		<div class="row">
			<div class="col s12">
				<h5 class="header-title teal-text">ようこそ、${sessionScope.username}さん</h5>
			</div>
		</div>
		<div class="row">
			<div class="col s12">
				<div id="calendar"></div>
			</div>
		</div>
	</main>

	<!-- フッター -->
	<footer class="page-footer teal">
		<div class="container">
			<div class="row">
				<div class="col s12 center">
					<p>© 2024 InfoSharingApp</p>
				</div>
			</div>
		</div>
	</footer>

	<!-- 必要なJavaScriptライブラリ -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.2.0/fullcalendar.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.2.0/locale/ja.js"></script>
	<script src="<c:url value='/js/materialize.min.js' />"></script>

	<script>
    $(document).ready(function() {
        // コントローラーから渡されたJSONデータをJavaScriptオブジェクトとして扱う
        var events = JSON.parse('${eventsJson}');

        // FullCalendarの設定
        $('#calendar').fullCalendar({
            events: events,
            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month,agendaWeek,agendaDay'
            },
            locale: 'ja',
            firstDay: 0,
            timeFormat: 'HH:mm',
            height: 700,
            eventClick: function(event) {
                var eventId = event.id;
                if (eventId) {
                    window.location.href = '${pageContext.request.contextPath}/event-detail/' + eventId;
                }
            },
            views: {
                agenda: {
                    timeFormat: 'HH:mm'  // Agendaビューの時間表記も24時間に設定
                }
            }
        });
    });
    </script>
</body>
</html>
