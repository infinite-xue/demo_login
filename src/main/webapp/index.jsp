<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="javax.servlet.http.Cookie"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="BASE" value="${pageContext.request.contextPath }" />
<%
	String username = "";
	String password = "";
	Cookie[] cookies = request.getCookies();
	if (cookies != null) {
		for (Cookie c : cookies) {
			if (c.getName().equals("cpeam")) {
				username = c.getValue().split("-")[0];
				password = c.getValue().split("-")[1];
			}
		}
	}
	pageContext.setAttribute("username", username);
	pageContext.setAttribute("password", password);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>登录页面</title>
		<link rel="stylesheet" type="text/css" href="${BASE }/bootstrap-3.3.5-dist/css/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" href="${BASE }/bootstrap-3.3.5-dist/css/bootstrap-theme.min.css">
		<script type="text/javascript" src="${BASE }/jquery-1.12.3/jquery-1.12.3.min.js"></script>
		<script type="text/javascript" src="${BASE }/bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>
		<script>
			function checkLoginForm() {
				var username = $("#username").val();
				var password = $("#password").val();
				var remember = $("#remember").val();
				if (username == null || username == "") {
					$("#errorInfo").html("用户名不能为空");
					return false;
				}
				if (password == null || password == "") {
					$("#errorInfo").html("密码不能为空");
					return false;
				}
				$.post("${BASE }/user/login",
						{username: username, password: password, remember: remember},
						function(result) {
							var result = eval("(" + result + ")");
							if(result.success) {
								window.location.href = "${BASE }/main.jsp";
							}else {
								$("#errorInfo").html(result.errorInfo);
							}
						});
			}
			
			function reset() {
				$("#username").val("");
				$("#password").val("");
			}
			
			$(document).ready(function() {
				$("#username").val("${pageScope.username }");
				$("#password").val("${pageScope.password }");
				$("#username").on("blur", function(){
					var username = $("#username").val();
					if(username == null || username == "") {
						return false;
					}else {
						$.get("${BASE }/user/findByName",
								{username: username},
								function(result) {
									var result = eval("(" + result + ")");
									if(!result.success) {
										$("#errorInfo").html(result.errorInfo);
									}else {
										$("#errorInfo").html("");
									}
								});
					}
				});
			});
		</script>
	</head>
	<body style="width: 90%; margin: auto;">
		<div class="page-header">
			<h1>登录页面</h1>
		</div>
		<form class="form-horizontal" role="form">
			<div class="form-group">
				<label class="col-md-4 control-label">用户名</label>
				<div class="col-md-5">
				 	<input type="text" class="form-control" id="username" placeholder="请输入用户名...">
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-4 control-label">密&nbsp;&nbsp;&nbsp;码</label>
				<div class="col-md-5">
				 	<input type="password" class="form-control" id="password" placeholder="请输入密码..." onkeydown="if(event.keyCode == 13) {checkLoginForm();}">
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-6 control-label">记住我</label>
				<div class="col-md-1">
				 	<input type="checkbox" class="form-control" id="remember" value="remember">
				</div>
			</div>
			<div class="form-group">
				<div class="col-md-12" style="text-align: center;">
					<button type="button" class="btn btn-primary" style="width: 100px;" onclick="checkLoginForm()">登录</button>
					&nbsp;&nbsp;&nbsp;
					<button type="button" class="btn btn-default" style="width: 100px;" onclick="reset()">重置</button>
					<div style="margin-top: 10px; height: 30px;">
						<span id="errorInfo" style="color: red;"></span>
					</div>
				</div>
			</div>
		</form>
	</body>
</html>