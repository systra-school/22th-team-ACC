<!-- kinmuJissekiNyuryokuKakunin.jsp -->
<%@page import="constant.CommonConstant.DayOfWeek"%>
<%@page import="business.logic.utils.CheckUtils"%>
<%@page import="form.common.DateBean"%>
<%@page import="java.util.List"%>
<%@page import="form.act.KinmuJissekiNyuryokuKakuninForm"%>
<%
/**
 * ファイル名：kinmuJissekiNyuryokuKakunin.jsp
 *
 * 変更履歴
 * 1.0  2010/09/13 Kazuya.Naraki
 */
%>
<%@page contentType="text/html; charset=Shift_JIS"
	pageEncoding="Shift_JIS"%>
<%@ page import="constant.RequestSessionNameConstant"%>
<%@ page import="constant.CommonConstant"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<bean:define id="color" value="" type="java.lang.String" />
<bean:size id="dateBeanListSize" name="kinmuJissekiNyuryokuKakuninForm"
	property="dateBeanList" />
<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="Thu, 01 Dec 1994 16:00:00 GMT">
<script type="text/javascript" src="/kikin/pages/js/common.js"></script>
<script type="text/javascript" src="/kikin/pages/js/checkCommon.js"></script>
<script type="text/javascript" src="/kikin/pages/js/message.js"></script>
<script type="text/javascript" language="Javascript1.1">
	function regist() {
		var listSize =
<%=dateBeanListSize%>
	;
		// エラーメッセージ
		var errorMsg = '';
		var startTimeErrMsg = '';
		var endTimeErrMsg = '';
		var breakTimeErrMsg = '';
		var fromToErrMsg = '';
		with (document.forms[0].elements) {
			for (var i = 0; i < listSize; i++) {
				var startTime = namedItem('kinmuJissekiNyuryokuKakuninList['
						+ i + '].startTime').value;
				var endTime = namedItem('kinmuJissekiNyuryokuKakuninList[' + i
						+ '].endTime').value;
				var breakTime = namedItem('kinmuJissekiNyuryokuKakuninList['
						+ i + '].breakTime').value;

				namedItem('kinmuJissekiNyuryokuKakuninList[' + i
						+ '].startTime').style.backgroundColor = 'white';
				namedItem('kinmuJissekiNyuryokuKakuninList[' + i + '].endTime').style.backgroundColor = 'white';
				namedItem('kinmuJissekiNyuryokuKakuninList[' + i
						+ '].breakTime').style.backgroundColor = 'white';
				
				if(startTime || endTime || breakTime){
					// 時間チェック
					if (!startTimeErrMsg) {
						if (!checkTime(startTime)) {
							var strArr = [ '開始時間' ];
							startTimeErrMsg = getMessage('E-MSG-000004', strArr);
							namedItem('kinmuJissekiNyuryokuKakuninList[' + i
									+ '].startTime').style.backgroundColor = 'red';
						}
					}
					if (!endTimeErrMsg) {
						if (!checkTime(endTime)) {
							var strArr = [ '終了時間' ];
							endTimeErrMsg = getMessage('E-MSG-000004', strArr);
							namedItem('kinmuJissekiNyuryokuKakuninList[' + i
									+ '].endTime').style.backgroundColor = 'red';
						}
					}
					if (!breakTimeErrMsg) {
						if (!checkTime(breakTime)) {
							var strArr = [ '休憩時間' ];
							breakTimeErrMsg = getMessage('E-MSG-000004', strArr);
							namedItem('kinmuJissekiNyuryokuKakuninList[' + i
									+ '].breakTime').style.backgroundColor = 'red';
						}
					}
					if (!checkTimeCompare(startTime, endTime)) {
						if (checkTime(startTime) && checkTime(endTime)) {
							fromToErrMsg = getMessageCodeOnly('E-MSG-000005');
							namedItem('kinmuJissekiNyuryokuKakuninList[' + i
									+ '].startTime').style.backgroundColor = 'red';
							namedItem('kinmuJissekiNyuryokuKakuninList[' + i
									+ '].endTime').style.backgroundColor = 'red';
						}
					}
				}

			}

			// エラーメッセージ	3/5 シフト名とシンボルのエラーメッセージ追加(高橋)
		}
		errorMsg = startTimeErrMsg + endTimeErrMsg + breakTimeErrMsg
				+ fromToErrMsg;

		if (errorMsg) {
			alert(errorMsg);
			// エラー
			return false;
		}

		document.forms[0].submit();

	}

	/**
	 * 検索
	 */
	function submitSearch() {
		doSubmit('/kikin/kinmuJissekiNyuryokuKakuninSearch.do');
	}
</script>
<title>勤務実績入力画面</title>

<link href="/kikin/pages/css/common.css" rel="stylesheet"
	type="text/css" />
</head>
<body>
	<div id="wrapper">
		<div id="header">
			<table width="100%">
				<tr>
					<td id="headLeft"><input value="戻る" type="button"
						class="smlButton"
						onclick="doSubmit('/kikin/kinmuJissekiNyuryokuKakuninBack.do')" />
					</td>
					<td id="headCenter">勤務実績入力</td>
					<td id="headRight"><input value="ログアウト" type="button"
						class="smlButton" onclick="logout()" />
						<div style="width: 284px; text-align: right;">
							社員ID&nbsp;
							<bean:write name="kinmuJissekiNyuryokuKakuninForm"
								property="shainId" />
							：社員名&nbsp;
							<bean:write name="kinmuJissekiNyuryokuKakuninForm"
								property="shainName" />
						</div></td>
				</tr>
			</table>
		</div>
		<div id="gymBody" style="overflow: auto;">
			
			<html:form action="/kinmuJissekiNyuryokuKakuninRegist">

				<div>
					<div style="overflow: hidden; width: 1080px; margin-left: 80px;">
						<div class="parent" style="width: 100%;">
							<div style="width: 804px; text-align: left;">
								表示年月：
								<html:select name="kinmuJissekiNyuryokuKakuninForm"
									property="yearMonth" onchange="submitSearch()">
									<html:optionsCollection name="kinmuJissekiNyuryokuKakuninForm"
										property="yearMonthCmbMap" value="key" label="value" />
								</html:select>
							</div>

							<br>
						</div>
						<table class="tblHeader" border="1" cellpadding="0"
							cellspacing="0">
							<tr>
								<td width="80px" align="center">日付</td>
								<td width="50px" align="center">曜</td>
								<td width="100px" align="center">シフト</td>
								<td width="100px" align="center">開始時刻</td>
								<td width="100px" align="center">終了時刻</td>
								<td width="100px" align="center">休憩</td>
								<td width="100px" align="center">実働時間</td>
								<td width="100px" align="center">時間外</td>
								<td width="100px" align="center">休日</td>
								<td width="220px" align="center">備考</td>
							</tr>
						</table>
					</div>
					<div
						style="overflow: auto; height: 400px; width: 1088px; margin-left: 80px;">
						<logic:iterate id="kinmuJissekiNyuryokuKakuninList"
							name="kinmuJissekiNyuryokuKakuninForm"
							property="kinmuJissekiNyuryokuKakuninList" indexId="idx">
							<table class="tblBody" border="1" cellpadding="0" cellspacing="0">
								<tr>
									<html:hidden name="kinmuJissekiNyuryokuKakuninList"
										property="shainId" />
									<td width="80px" align="center"><bean:write
											name="kinmuJissekiNyuryokuKakuninList"
											property="kadouDayDisp" /><br></td>
									<bean:define id="youbi" name="kinmuJissekiNyuryokuKakuninList"
										property="youbi" />
									<bean:define id="shukujitsuFlg"
										name="kinmuJissekiNyuryokuKakuninList"
										property="shukujitsuFlg" />

									<%
									if (DayOfWeek.SATURDAY.getRyaku().equals(youbi)) {
										color = "fontBlue";
									} else if (DayOfWeek.SUNDAY.getRyaku().equals(youbi) || ((boolean) shukujitsuFlg)) {
										color = "fontRed";
									} else {
										color = "fontBlack";
									}
									%>

									<td width="50px" align="center" class="<%=color%>"><bean:write
											name="kinmuJissekiNyuryokuKakuninList" property="youbi" /><br>
									</td>
									<td width="100px" align="center"><bean:write
											name="kinmuJissekiNyuryokuKakuninList" property="symbol" /><br>
									<td width="100px" align="center"><html:text
											style="text-align:center" size="5" maxlength="5"
											name="kinmuJissekiNyuryokuKakuninList" property="startTime"
											indexed="true"></html:text><br></td>
									<td width="100px" align="center"><html:text
											style="text-align:center" size="5" maxlength="5"
											name="kinmuJissekiNyuryokuKakuninList" property="endTime"
											indexed="true"></html:text><br></td>
									<td width="100px" align="center"><html:text
											style="text-align:center" size="5" maxlength="5"
											name="kinmuJissekiNyuryokuKakuninList" property="breakTime"
											indexed="true"></html:text><br></td>
									<td width="100px" align="center"><bean:write
											name="kinmuJissekiNyuryokuKakuninList"
											property="jitsudouTime" /><br></td>
									<td width="100px" align="center"><bean:write
											name="kinmuJissekiNyuryokuKakuninList"
											property="jikangaiTime" /><br></td>
									<td width="100px" align="center"><bean:write
											name="kinmuJissekiNyuryokuKakuninList"
											property="kyuujitsuTime" /><br></td>
									<td width="220px" align="left"><html:text
											style="text-align:left" size="25"
											name="kinmuJissekiNyuryokuKakuninList" property="bikou"
											indexed="true"></html:text><br></td>
								</tr>
							</table>
						</logic:iterate>
					</div>
				</div>
			</html:form>
		</div>
		<div id="footer">
			<table>
				<tr>
					<td id="footLeft"></td>
					<td id="footCenter"></td>
					<td id="footRight"><input value="登録" type="button"
						class="smlButton" onclick="regist()" /></td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>