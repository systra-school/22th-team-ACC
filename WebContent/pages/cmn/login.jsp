<!-- login.jsp -->
<%@page contentType="text/html; charset=Shift_JIS"
	pageEncoding="Shift_JIS"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@taglib uri="http://struts.apache.org/tags-html" prefix="html"%>

<html>

<head>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="Thu, 01 Dec 1994 16:00:00 GMT">
<html:javascript formName="loginForm" />

<script type="text/javascript" src="/kikin/pages/js/common.js"></script>
<script type="text/javascript" src="/kikin/pages/js/checkCommon.js"></script>
<script type="text/javascript" src="/kikin/pages/js/message.js"></script>
<script type="text/javascript" language="Javascript1.1">

window.onload = function() {
    var error = '<%=request.getAttribute("error")%>';

		if (error && error.toLowerCase() === 'true') {
			alert(getMessageCodeOnly("E-MSG-000002"));
		}
	}
</script>
<title>ログイン画面Login</title>
<link href="/kikin/pages/css/common.css" rel="stylesheet"
	type="text/css" />
</head>
<body>


	<div id="wrapper2">
		<canvas id="canvas"></canvas>
	</div>
	
	<div id="wrapper">
		<div id="header">
			<table align="center">
				<!-- 3/12「ログイン」はいつでも真ん中にあるように修正（リン） align="center"追加-->
				<tr>
					<td id="headLeft"></td>
					<td id="headCenter">ログイン</td>
					<td id="headRight"></td>
				</tr>
			</table>
		</div>


		<div id="gymBody">
			<div align="center">
				<div>ID・パスワードを入力してください。</div>
				<html:form action="/login" onsubmit="return validateLoginForm(this)">
					<html:text property="shainId" size="16" />
					<br />
					<html:password property="password" size="16" redisplay="false" />
					<br />
					<br />
					<html:submit property="submit" value="送信" />
					<html:reset value="リセット" />
				</html:form>
			</div>
		</div>
		<div id="footer">
			<table>
				<tr>
					<td id="footLeft"></td>
					<td id="footCenter"></td>
					<td id="footRight"></td>
				</tr>
			</table>
		</div>

	</div>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script type="text/javascript" src="/kikin/pages/js/haikei.js"></script>
	
</body>


</html>
