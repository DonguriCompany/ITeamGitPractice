<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ユーザー管理</title>
<!-- Materialize CSS -->
<link rel="stylesheet" href="<c:url value='/css/materialize.min.css' />">
<script>
        document.addEventListener('DOMContentLoaded', function() {
            var elems = document.querySelectorAll('.modal');
            var instances = M.Modal.init(elems);
        });

        function setDeleteInfo(username, userId) {
            document.getElementById("deleteUserName").textContent = username;
            document.getElementById("deleteForm").action = "/user-delete/" + userId;
        }
    </script>
</head>
<body>
	<div class="container">
		<h2 class="center-align">ユーザー管理</h2>

		<table class="highlight responsive-table">
			<thead>
				<tr>
					<th>ユーザーID</th>
					<th>ユーザー名</th>
					<th>メールアドレス</th>
					<th>作成日時</th>
					<th>更新日時</th>
					<th>権限</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="user" items="${users}">
					<tr>
						<td>${user.id}</td>
						<td>${user.username}</td>
						<td>${user.email}</td>
						<td>${user.createdAt}</td>
						<td>${user.updatedAt}</td>
						<td>${user.isAdmin ? '管理者' : '一般'}</td>
						<td><a href="/user-edit/${user.id}"
							class="btn waves-effect waves-light blue">編集</a> <!-- 削除ボタン -->
							<button class="btn waves-effect waves-light red modal-trigger"
								data-target="deleteModal"
								onclick="setDeleteInfo('${user.username}', ${user.id});">
								削除</button></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		<div class="center-align">
			<a href="/user-list" class="btn waves-effect waves-light teal">ユーザー一覧に戻る</a>
		</div>
	</div>

	<!-- 削除確認モーダル -->
	<div id="deleteModal" class="modal">
		<div class="modal-content">
			<h4>確認</h4>
			<p>
				<span id="deleteUserName"></span> を削除しますか？この操作は元に戻せません。
			</p>
		</div>
		<div class="modal-footer">
			<form id="deleteForm" method="post">
				<button type="submit" class="btn waves-effect waves-light red">削除</button>
				<a href="#!" class="modal-close btn waves-effect waves-light grey">キャンセル</a>
			</form>
		</div>
	</div>

	<!-- Materialize JavaScript -->
	<script src="${pageContext.request.contextPath}/js/materialize.min.js"></script>
</body>
</html>
