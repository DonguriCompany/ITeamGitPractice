<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ログアウト完了</title>
<!-- Materialize CSS -->
<link rel="stylesheet" href="<c:url value='/css/materialize.min.css' />">
</head>
<body>
	<div class="container">
		<h2 class="center-align">ログアウトが完了しました。</h2>

		<div class="card-panel orange center-align">
			<span class="white-text">ログアウトが正常に完了しました。</span>
		</div>

		<div class="center-align">
			<a href="${pageContext.request.contextPath}/login"
				class="btn waves-effect waves-light blue">ログイン画面に戻る</a>
		</div>
	</div>

	<!-- Materialize JS -->
	<script src="<c:url value='/js/materialize.min.js' />"></script>
</body>
</html>
