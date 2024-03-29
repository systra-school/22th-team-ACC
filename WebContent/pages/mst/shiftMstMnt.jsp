<!-- shiftMstMnt.jsp -->
<%@page import="business.logic.utils.CheckUtils"%>
<%@page import="form.mst.ShiftMstMntBean"%>
<%@page import="java.util.List"%>
<%@page import="form.mst.ShiftMstMntForm"%>
<%
/**
 * ファイル名：shiftMstMnt.jsp
 *
 * 変更履歴
 * 1.0  2010/09/13 Kazuya.Naraki
 */
%>
<%@page contentType="text/html; charset=Shift_JIS" pageEncoding="Shift_JIS"%>
<%@ page import="constant.RequestSessionNameConstant"%>
<%@ page import="constant.CommonConstant"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@taglib uri="http://struts.apache.org/tags-html" prefix="html"%>

<bean:size id="beanListSize" name="shiftMstMntForm" property="shiftMstMntBeanList"/>
<html>
  <head>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="Expires" content="Thu, 01 Dec 1994 16:00:00 GMT">
    <script type="text/javascript" src="/kikin/pages/js/common.js"></script>
    <script type="text/javascript" src="/kikin/pages/js/checkCommon.js"></script>
    <script type="text/javascript" src="/kikin/pages/js/message.js"></script>
    <script type="text/javascript" language="Javascript1.1">
    <!--
    /**
     * チェックボックスがチェックされたら true、されていなければ false
     * param index 対象行番号
     */
     function checkDeleteFlg(index) {
         var deleteShiftId = document.forms[0].elements.deleteShiftId;
         var isCheck = false;

         if (deleteShiftId.length > 1) {
             isCheck = document.forms[0].elements.deleteShiftId[index].checked;
         } else {
             isCheck = deleteShiftId.checked;
         }

         document.forms[0].elements.namedItem('shiftMstMntBeanList['+ index +'].deleteFlg').value = isCheck;
     }

    /**
     * 新規登録画面へ
     */
    function shiftMstMntRegistInit() {
        document.forms[0].action = "/kikin/shiftMstMntRegistInit.do";
        document.forms[0].submit();
    }

    /**
     * 更新処理を行う
     */
    function shiftMstMntUpdate() {

        // 一覧のサイズ
        var listSize = <%= beanListSize %>;
        
      	// 3/5　この後にシフト名とシフトシンボルエラーメッセージ追加(高橋)
      	// シフト名エラーメッセージ
        var shiftNameErrMsg = '';
      	// シンボルエラーメッセージ
        var symbolErrMsg = '';
        // 開始時間エラーメッセージ
        var startTimeErrMsg = '';
        // 終了時間エラーメッセージ
        var endTimeErrMsg = '';
        // 休憩時間エラーメッセージ
        var breakTimeErrMsg = '';
        // From - To エラーメッセージ
        var fromToErrMsg = '';
        // エラーメッセージ
        var errorMsg = '';


        with(document.forms[0].elements) {

            for (var i = 0; i < listSize; i++) {
            	
            	// 3/5　この後にシフト名とシンボル取得を追加(高橋)
                // シフト名を取得する。
            	var shiftName = namedItem('shiftMstMntBeanList['+ i +'].shiftName').value;
                // シンボルを取得する。
            	var symbol = namedItem('shiftMstMntBeanList['+ i +'].symbol').value;
                // 開始時間を取得する。
                var startTime = namedItem('shiftMstMntBeanList['+ i +'].startTime').value;
                // 終了時間を取得する。
                var endTime = namedItem('shiftMstMntBeanList['+ i +'].endTime').value;
                // 休憩時間を取得する。
                var breakTime = namedItem('shiftMstMntBeanList['+ i +'].breakTime').value;

                // 背景色をクリアする	　3/5 シフト名とシンボルも追加(高橋)
                namedItem('shiftMstMntBeanList['+ i +'].shiftName').style.backgroundColor = 'white';
                namedItem('shiftMstMntBeanList['+ i +'].symbol').style.backgroundColor = 'white';
                namedItem('shiftMstMntBeanList['+ i +'].startTime').style.backgroundColor = 'white';
                namedItem('shiftMstMntBeanList['+ i +'].endTime').style.backgroundColor = 'white';
                namedItem('shiftMstMntBeanList['+ i +'].breakTime').style.backgroundColor = 'white';

              //3/4　この後にシフト名とシンボルの空白チェックを追加(高橋)
            	// シフト名チェック
            	if (!shiftNameErrMsg) {
                    if (!checkRequired(shiftName)) {
                        var strArr = ['シフト名'];
                        shiftNameErrMsg = getMessage('E-MSG-000006', strArr);
                        namedItem('shiftMstMntBeanList['+ i +'].shiftName').style.backgroundColor = 'red';
                    }
                }
              
            	// シンボルチェック
            	if (!symbolErrMsg) {
                    if (!checkRequired(symbol)) {
                        var strArr = ['シンボル'];
                        symbolErrMsg = getMessage('E-MSG-000006', strArr);
                        namedItem('shiftMstMntBeanList['+ i +'].symbol').style.backgroundColor = 'red';
                    }
                }

                // 時間チェック
                if (!startTimeErrMsg) {
                    if (!checkTime(startTime)) {
                        var strArr = ['開始時間'];
                        startTimeErrMsg = getMessage('E-MSG-000004', strArr);
                        namedItem('shiftMstMntBeanList['+ i +'].startTime').style.backgroundColor = 'red';
                    }
                }
                if (!endTimeErrMsg) {
                    if (!checkTime(endTime)) {
                        var strArr = ['終了時間'];
                        endTimeErrMsg = getMessage('E-MSG-000004', strArr);
                        namedItem('shiftMstMntBeanList['+ i +'].endTime').style.backgroundColor = 'red';
                    }
                }
                if (!breakTimeErrMsg) {
                    if (!checkTime(breakTime)) {
                        var strArr = ['休憩時間'];
                        breakTimeErrMsg = getMessage('E-MSG-000004', strArr);
                        namedItem('shiftMstMntBeanList['+ i +'].breakTime').style.backgroundColor = 'red';
                    }
                }

                // from - to のチェック
                if (!checkTimeCompare(startTime, endTime)) {
                  if (checkTime(startTime) && checkTime(endTime)) {
                      fromToErrMsg = getMessageCodeOnly('E-MSG-000005');
                      namedItem('shiftMstMntBeanList['+ i +'].startTime').style.backgroundColor = 'red';
                      namedItem('shiftMstMntBeanList['+ i +'].endTime').style.backgroundColor = 'red';
                  }
                }

            }
        }

        // エラーメッセージ	3/5 シフト名とシンボルのエラーメッセージ追加(高橋)
        errorMsg = symbolErrMsg + symbolErrMsg + startTimeErrMsg + endTimeErrMsg + breakTimeErrMsg + fromToErrMsg;

        if (errorMsg) {
            alert(errorMsg);
            // エラー
            return false;
        }

        document.forms[0].submit();
    }

    -->
    </script>

    <title>シフトマスタメンテナンス画面</title>

    <link href="/kikin/pages/css/tatewaki.css" rel="stylesheet" type="text/css" />
  </head>
  <body  style="background-image: url('./pages/images/SftMstMnt.jpg')">
    <div id="wrapper">
      <div id="header">
        <table align="center"> <!-- 3/12 No.103全体がいつでも画面の真ん中にあるように修正（リン） align="center"追加 -->
          <tr>
            <td id="headLeft">
              <input value="戻る" type="button" class="smlButton"  onclick="doSubmit('/kikin/shiftMstMntBack.do')" />
            </td>
            <td id="headCenter" style="color: red;">
              シフトマスタメンテナンス
            </td>
            <td id="headRight">
              <input value="ログアウト" type="button" class="smlButton"  onclick="logout()" />
            </td>
          </tr>
        </table>
      </div>
      <!--  <div id="gymBody">
        <html:form action="/shiftMstMntUpdate">
          <div style="width: 600px; margin-left:300px;">
            <table class="tblHeader" border="1" cellpadding="0" cellspacing="0">
              <tr>
                <td width="100px" align="center">
                  シフト名
                </td>
                <td width="70px" align="center">
                  シンボル
                </td>
                <td width="230px" align="center">
                  時間
                </td>
                <td width="100px" align="center">
                  休憩
                </td>
                <td width="70px" align="center">
                  削除
                </td>
              </tr>
            </table>
          </div>
          <div style="overflow: auto; height: 80%; width: 600px; margin-left:300px;">
            <table class="tblBody" border="1" cellpadding="0" cellspacing="0">
              <logic:iterate indexId="idx" id="shiftMstMntBeanList" name="shiftMstMntForm"  property="shiftMstMntBeanList">
              <bean:define id="shiftId" name= "shiftMstMntBeanList" property="shiftId" type="java.lang.String"/>
                <tr>
                  <td width="100px"  align="center">
                    <html:text property="shiftName" name="shiftMstMntBeanList" size="10" maxlength="10" indexed="true"/>
                    <html:hidden property="shiftId" name="shiftMstMntBeanList" indexed="true"/>
                  </td>
                  <td width="70px"  align="center">
                    <html:text property="symbol" name="shiftMstMntBeanList"  size="2" maxlength="2" indexed="true"/>
                  </td>
                  <td width="230px"  align="center">
                    <table width="100%" >
                      <tr>
                        <td align="center">
                          <html:text property="startTime" name="shiftMstMntBeanList"  size="10" maxlength="5" indexed="true"/>
                        </td>
                        <td align="center">
                            &#xFF5E;
                        </td>
                        <td align="center">
                          <html:text property="endTime" name="shiftMstMntBeanList"  size="10" maxlength="5" indexed="true"/>
                        </td>
                      </tr>
                    </table>
                  </td>
                  <td width="100px"  align="center">
                    <html:text property="breakTime" name="shiftMstMntBeanList"  size="10" maxlength="5" indexed="true"/>
                  </td>

                  <td width="70px"  align="center">
                    <html:checkbox property="deleteShiftId" name="shiftMstMntBeanList"  value="<%= shiftId %>"  onchange='<%="checkDeleteFlg(" + idx + ")" %>'></html:checkbox>
                    <html:hidden property="deleteFlg" name="shiftMstMntBeanList" value="false" indexed="true"/>
                  </td>
                </tr>
              </logic:iterate>
            </table>
          </div>
        </html:form>
      </div>-->
      <div id="gymBody"  style="position:relative; padding-bottom:200px; "><!-- 3/12 No.103全体がいつでも画面の真ん中にあるように修正（リン） style="position:relative; padding-bottom:200px; "追加 -->
        <html:form action="/shiftMstMntUpdate">
          <div  align="center"><!-- 3/12 No.103全体がいつでも画面の真ん中にあるように修正（リン） align="center"追加 -->          
            <table  border="1" cellpadding="0" cellspacing="0" >               
            <tr class="tblHeader" >
                <td width="100px" align="center">
                  シフト名
                </td>
                <td width="70px" align="center">
                  シンボル
                </td>
                <td width="230px" align="center">
                  時間
                </td>
                <td width="100px" align="center">
                  休憩
                </td>
                <td width="70px" align="center">
                  削除
                </td>
              </tr>
              <logic:iterate indexId="idx" id="shiftMstMntBeanList" name="shiftMstMntForm"  property="shiftMstMntBeanList">
              <bean:define id="shiftId" name= "shiftMstMntBeanList" property="shiftId" type="java.lang.String"/>
                <tr class="tblBody">
                  <td width="100px"  align="center">
                    <html:text property="shiftName" name="shiftMstMntBeanList" size="10" maxlength="10" indexed="true"/>
                    <html:hidden property="shiftId" name="shiftMstMntBeanList" indexed="true"/>
                  </td>
                  <td width="70px"  align="center">
                    <html:text property="symbol" name="shiftMstMntBeanList"  size="2" maxlength="2" indexed="true"/>
                  </td>
                  <td width="230px"  align="center">
                    <table width="100%" >
                      <tr>
                        <td align="center">
                          <html:text property="startTime" name="shiftMstMntBeanList"  size="10" maxlength="5" indexed="true"/>
                        </td>
                        <td align="center">
                            &#xFF5E;
                        </td>
                        <td align="center">
                          <html:text property="endTime" name="shiftMstMntBeanList"  size="10" maxlength="5" indexed="true"/>
                        </td>
                      </tr>
                    </table>
                  </td>
                  <td width="100px"  align="center">
                    <html:text property="breakTime" name="shiftMstMntBeanList"  size="10" maxlength="5" indexed="true"/>
                  </td>

                  <td width="70px"  align="center">
                    <html:checkbox property="deleteShiftId" name="shiftMstMntBeanList"  value="<%= shiftId %>"  onchange='<%="checkDeleteFlg(" + idx + ")" %>'></html:checkbox>
                    <html:hidden property="deleteFlg" name="shiftMstMntBeanList" value="false" indexed="true"/>
                  </td>
                </tr>
              </logic:iterate>
            </table>
          </div>
        </html:form>
      </div>
      <div id="footer" style="position:absolute;  height:200px; "><!-- 3/12 No.103全体がいつでも画面の真ん中にあるように修正（リン）style="position:absolute;  height:200px; 追加 -->
        <table align="center"> <!-- 3/12 No.103全体がいつでも画面の真ん中にあるように修正（リン） align="center"追加 -->
          <tr>
            <td id="footLeft">              
            </td>
            <td id="footCenter">              
            </td>
            <td id="footRight" style="display: flex;justify-content: flex-start;"> <!-- 3/12 No.103全体がいつでも画面の真ん中にあるように修正（リン）style="display: flex;justify-content: flex-start;"追加 -->
              <input value="新規登録" type="button" class="smlButton"  onclick="shiftMstMntRegistInit()" />
              　
              <input value="更新" type="button" class="smlButton"  onclick="shiftMstMntUpdate()" />
            </td>
          </tr>
        </table>
      </div>
    </div>
  </body>
</html>