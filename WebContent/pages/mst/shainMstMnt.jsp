<!-- shainMstMnt.jsp -->
<%
/**
 * ファイル名：shainMstMnt.jsp
 *
 * 変更履歴
 * 1.0  2010/09/13 Kazuya.Naraki
 */
%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@page import="business.logic.utils.CheckUtils"%>
<%@page import="form.mst.ShainMstMntForm"%>
<%@page import="java.util.List"%>
<%@page import="form.mst.ShainMstMntBean"%>
<%@page contentType="text/html; charset=Shift_JIS" pageEncoding="Shift_JIS"%>
<%@ page import="constant.RequestSessionNameConstant"%>
<%@ page import="constant.CommonConstant"%>

<bean:size id="shainMstMntBeanListSize" name="shainMstMntForm" property="shainMstMntBeanList"/>
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
        var deleteShainId = document.forms[0].elements.deleteShainId;
        var isCheck = false;

        if (deleteShainId.length > 1) {
            isCheck = document.forms[0].elements.deleteShainId[index].checked;
        } else {
            isCheck = deleteShainId.checked;
        }

        document.forms[0].elements.namedItem('shainMstMntBeanList['+ index +'].deleteFlg').value = isCheck;
    }

    /**
     * 新規登録画面へ
     */
    function shainMstMntRegistInit() {
        document.forms[0].action = "/kikin/shainMstMntRegistInit.do";
        document.forms[0].submit();
    }

    /**
     * 更新処理を行う
     */
     /* 3/4 社員名（必須項目）設定の追加（高橋） */
    function shainMstMntUpdate() {
        // 一覧のサイズ
        var listSize = <%= shainMstMntBeanListSize %>;

        // パスワードエラーメッセージ
        var passwordErrorMsg = '';
     	// 社員名エラーメッセージ
        var shainNameErrorMsg = '';
        // 社員名カナエラーメッセージ
        var shainmeiKanaErrorMsg = '';
        var errorMsg = '';

        with(document.forms[0].elements) {
            for (var i = 0; i < listSize; i++) {
                // パスワードを取得する。
                var password = namedItem('shainMstMntBeanList['+ i +'].password').value;
             	// 社員名を取得する。
                var shainName = namedItem('shainMstMntBeanList['+ i +'].shainName').value;
                // 社員名カナを取得する。
                var shainNameKana = namedItem('shainMstMntBeanList['+ i +'].shainNameKana').value;

                // 背景色をクリアする
                namedItem('shainMstMntBeanList['+ i +'].password').style.backgroundColor = 'white';
                namedItem('shainMstMntBeanList['+ i +'].shainName').style.backgroundColor = 'white';
                namedItem('shainMstMntBeanList['+ i +'].shainNameKana').style.backgroundColor = 'white';

                // パスワードチェック
                if (!passwordErrorMsg) {
                    if (!checkRequired(password)) {
                        var strArr = ['パスワード'];
                        passwordErrorMsg = getMessage('E-MSG-000001', strArr);
                        namedItem('shainMstMntBeanList['+ i +'].password').style.backgroundColor = 'red';
                    }
                }
             	// 社員名チェック
                if (!shainNameErrorMsg) {
                    if (!checkRequired(shainName)) {
                        var strArr = ['社員名'];
                        shainNameErrorMsg = getMessage('E-MSG-000001', strArr);
                        namedItem('shainMstMntBeanList['+ i +'].shainName').style.backgroundColor = 'red';
                    }
                }
                // 社員名カナチェック
                if (!shainmeiKanaErrorMsg) {
                    if (!checkHankakuKana(shainNameKana)) {
                        var strArr = ['社員名カナ'];
                        shainmeiKanaErrorMsg = getMessage('E-MSG-000003', strArr);
                        namedItem('shainMstMntBeanList['+ i +'].shainNameKana').style.backgroundColor = 'red';
                    }
                }

                if (passwordErrorMsg && shainNameErrorMsg && shainmeiKanaErrorMsg) {
                    // パスワード、社員名、社員名カナが共にエラーの場合
                    break;
                }
            }
        }
        // エラーメッセージ
        errorMsg = passwordErrorMsg + shainNameErrorMsg + shainmeiKanaErrorMsg;

        if (errorMsg) {
            alert(errorMsg);
            // エラー
            return false;
        }

        document.forms[0].submit();
    }

    -->
    </script>

    <title>社員マスタメンテナンス画面</title>

    <link href="/kikin/pages/css/common.css" rel="stylesheet" type="text/css" />
  </head>
  <body>
  
  	<div id="wrapper2">
		<canvas id="canvas"></canvas>
	</div>
    <div id="wrapper">
      <div id="header">
        <table align="center"> <!-- 3/12　全体は画面の真ん中にあるように修正（リン）align="center"追加 -->
          <tr>
            <td id="headLeft">
              <input value="戻る" type="button" class="smlButton"  onclick="doSubmit('/kikin/shainMstMntBack.do')" />
            </td>
            <td id="headCenter">
              社員マスタメンテナンス
            </td>
            <td id="headRight">
              <input value="ログアウト" type="button" class="smlButton"  onclick="logout()" />
            </td>
          </tr>
        </table>
      </div>
      <div id="gymBody" align="center"> <!-- 3/12　全体は画面の真ん中にあるように修正（リン）align="center"追加 -->
        <html:form action="/shainMstMntUpdate">      
        <!--テーブルがズレているのを修正、１つテーブルにまとめ（リン）
        元コード↓-->
           <!--<div style="overflow: auto;width:1030px; margin-left:100px "> 
            <table class="tblHeader" border="1"   cellpadding="0" cellspacing="0">
              <tr>
                <td width="200px" align="center">
                  社員ＩＤ
                </td>
                <td width="200px" align="center">
                  パスワード
                </td>
                <td width="200px" align="center">
                  社員名
                </td>
                <td width="200px" align="center">
                  社員名カナ
                </td>
                <td width="100px" align="center">
                  権限
                </td>
                <td width="100px" align="center">
                  削除
                </td>
              </tr>
            </table>
          </div>
          <div style="overflow: auto; height:440px; width:1030px; margin-left:100px ">
            <table class="tblBody" border="1"  cellpadding="0" cellspacing="0" >
              <logic:iterate indexId="idx" id="shainMstMntBeanList" name="shainMstMntForm"  property="shainMstMntBeanList">
                <bean:define id="shainId" name= "shainMstMntBeanList" property="shainId" type="java.lang.String"/>
                <bean:define id="selectKengenId" name= "shainMstMntBeanList" property="kengenId" type="java.lang.String"/>
                <tr>
                  <td width="200px"  align="center">
                    <bean:write property="shainId" name="shainMstMntBeanList"/>
                    <html:hidden property="shainId" name="shainMstMntBeanList" indexed="true"/>
                  </td>
                  <td width="200px"  align="center">
                    <html:password property="password" name="shainMstMntBeanList"  size="10" maxlength="6" indexed="true" />
                  </td>
                  <td width="200px"  align="center">
                    <html:text property="shainName" name="shainMstMntBeanList" size="20" maxlength="10" indexed="true" />
                  </td>
                  <td width="200px"  align="center">
                    <html:text property="shainNameKana" name="shainMstMntBeanList"  size="20" maxlength="10" indexed="true" />
                  </td>
                  <td width="100px"  align="center">
                    <html:select property="kengenId" name="shainMstMntBeanList" value="<%= selectKengenId %>" indexed="true">
                      <html:optionsCollection name="shainMstMntForm"
                                              property="kengenCmbMap"
                                              value="key"
                                              label="value"/>
                    </html:select>
                  </td>
                  <td width="100px"  align="center">
                    <html:checkbox property="deleteShainId" name="shainMstMntBeanList" value="<%= shainId %>" onchange='<%="checkDeleteFlg(" + idx + ")" %>' ></html:checkbox>
                    <html:hidden property="deleteFlg" name="shainMstMntBeanList" value="false" indexed="true"/>
                  </td>
                </tr>
              </logic:iterate>
            </table>
          </div>-->
          <!-- 新コード↓ -->
          
    <table border="1" cellpadding="0" cellspacing="0">
         <tr class="tblHeader" style=" top: 0;position: sticky;z-index:1;" > <!--3/8 テーブルの一行目固定修正 ２１８〜２４０（リン） -->
            <th width="200px" align="center">
                社員ＩＤ
            </th>
            <th style="position: sticky;"  width="200px" align="center">
                パスワード
            </th>
            <th style="position: sticky;"  width="200px" align="center">
                社員名
            </th>
            <th style="position: sticky;"  width="200px" align="center">
                社員名カナ
            </th>
            <th style="position: sticky;"  width="100px" align="center">
                権限
            </th>
            <th style="position: sticky;"  width="100px" align="center">
                削除
            </th>
        </tr>
        <div style="overflow-y: auto;width:1030px; margin-left:100px ">
        <logic:iterate indexId="idx" id="shainMstMntBeanList" name="shainMstMntForm" property="shainMstMntBeanList">
            <bean:define id="shainId" name= "shainMstMntBeanList" property="shainId" type="java.lang.String"/>
            <bean:define id="selectKengenId" name= "shainMstMntBeanList" property="kengenId" type="java.lang.String"/>
            <tr class="tblBody">
                <td width="200px" align="center">
                    <bean:write property="shainId" name="shainMstMntBeanList"/>
                    <html:hidden property="shainId" name="shainMstMntBeanList" indexed="true"/>
                </td>
                <td width="200px" align="center">
                    <html:password property="password" name="shainMstMntBeanList" size="10" maxlength="6" indexed="true" />
                </td>
                <td width="200px" align="center">
                    <html:text property="shainName" name="shainMstMntBeanList" size="20" maxlength="10" indexed="true" />
                </td>
                <td width="200px" align="center">
                    <html:text property="shainNameKana" name="shainMstMntBeanList" size="20" maxlength="10" indexed="true" />
                </td>
                <td width="100px" align="center">
                    <html:select property="kengenId" name="shainMstMntBeanList" value="<%= selectKengenId %>" indexed="true">
                        <html:optionsCollection name="shainMstMntForm" property="kengenCmbMap" value="key" label="value"/>
                    </html:select>
                </td>
                <td width="100px" align="center">
                    <html:checkbox property="deleteShainId" name="shainMstMntBeanList" value="<%= shainId %>" onchange='<%="checkDeleteFlg(" + idx + ")" %>' ></html:checkbox>
                    <html:hidden property="deleteFlg" name="shainMstMntBeanList" value="false" indexed="true"/>
                </td>
            </tr>
        </logic:iterate>
    </table>
</div>
        </html:form>
      </div>
      <div id="footer">
        <table align="center"> <!-- 3/12 全体は画面の真ん中にあるように修正（リン）align="center"追加 -->
          <tr>
            <td id="footLeft">
              　
            </td>
            <td id="footCenter">
              　
            </td>
            <td id="footRight">
              <input value="新規登録" type="button" class="smlButton"  onclick="shainMstMntRegistInit()" />
              <input value="更新" type="button" class="smlButton"  onclick="shainMstMntUpdate()" />
            </td>
          </tr>
        </table>
      </div>
    </div>
     
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script type="text/javascript" src="/kikin/pages/js/haikei.js"></script>
    
  </body>
</html>