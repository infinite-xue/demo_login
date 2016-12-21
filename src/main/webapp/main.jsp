<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="BASE" value="${pageContext.request.contextPath }" />
<%
	if(session.getAttribute("loginUser") == null) {
		response.sendRedirect("index.jsp");
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>主页面</title>
		<link rel="stylesheet" type="text/css" href="${BASE }/bootstrap-3.3.5-dist/css/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" href="${BASE }/bootstrap-3.3.5-dist/css/bootstrap-theme.min.css">
		<script type="text/javascript" src="${BASE }/jquery-1.12.3/jquery-1.12.3.min.js"></script>
		<script type="text/javascript" src="${BASE }/bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>
		<script>
			function logout() {
				$.get("${BASE }/user/logout",
						function(result) {
							var result = eval("(" + result + ")");
							if(result.success) {
								window.location.href = "${BASE }/index.jsp";
							}else {
								alert("退出失败");
							}
				});
			}
		</script>
	</head>
	<body style="width: 90%; margin: auto;">
		<div class="page-header">
			<h1>登录成功</h1>
		</div>
		<div class="jumbotron">
			<h1>欢迎您:${sessionScope.loginUser.username }</h1>
			<p></p>
			<p>所属部门:${sessionScope.loginUser.depart.name }</p>
			<p>登录时间:${sessionScope.loginDate }</p>
		</div>
		<div class="form-group">
			<div class="col-md-12" style="text-align: center;">
				<button type="button" class="btn btn-primary" style="width: 100px;" onclick="logout()">退出</button>
			</div>
		</div>
	</body>
</html>