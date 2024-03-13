<!-- tsukibetsuShiftNyuuryoku.jsp -->
<%@page import="constant.CommonConstant.DayOfWeek"%>
<%@page import="business.logic.utils.CheckUtils"%>
<%@page import="form.common.DateBean"%>
<%@page import="java.util.List"%>
<%@page import="form.mth.TsukibetsuShiftNyuuryokuForm"%>
<%
/**
 * ファイル名：tsukibetsuShiftNyuuryoku.jsp
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

<bean:size id="dateBeanListSize" name="tsukibetsuShiftNyuuryokuForm" property="dateBeanList"/>
<bean:size id="listSize" name="tsukibetsuShiftNyuuryokuForm" property="tsukibetsuShiftNyuuryokuBeanList"/>
<bean:define id="showLength" value="16" type="java.lang.String"/> <!-- value 16->12に変更（リン）テーブルが社員１２名まで表示 -->
<bean:define id="offset" name="tsukibetsuShiftNyuuryokuForm" property="offset" />
<bean:define id="color" value="" type="java.lang.String"/>
<bean:define id="cntPage" name="tsukibetsuShiftNyuuryokuForm" property="cntPage" type="java.lang.Integer"/>
<bean:define id="maxPage" name="tsukibetsuShiftNyuuryokuForm" property="maxPage" type="java.lang.Integer"/>

<%
final int heightSize = 22;

int intShowLength = Integer.parseInt(showLength);

// 表示しているリストサイズの調整
if (cntPage.intValue() == maxPage.intValue()) {
    listSize = listSize % intShowLength;
}

if (listSize > intShowLength) {
    listSize = intShowLength;
}

%>
<html>
  <head>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="Expires" content="Thu, 01 Dec 1994 16:00:00 GMT">
    <script type="text/javascript" src="/kikin/pages/js/common.js"></script>
    <script type="text/javascript" src="/kikin/pages/js/checkCommon.js"></script>
    <script type="text/javascript" src="/kikin/pages/js/message.js"></script>
    <script type="text/javascript" language="Javascript1.1">
    

    /**
     * 出勤希望反映
     */
    function submitShukkinKibou() {
        // サブミット
        doSubmit('/kikin/tsukibetsuShiftNyuuryokuShukkinKibou.do');
    }
    
    function submitShukkinKihon() {
        // サブミット
        doSubmit('/kikin/tsukibetsuShiftNyuuryokuShukkinKihon.do');
    }
    
    /**
     * 登録
     */
    function submitRegist() {
        // サブミット
        doSubmit('/kikin/tsukibetsuShiftNyuuryokuRegist.do');
    }

    /**
     * 検索
     */
    function submitSearch() {
        doSubmit('/kikin/tsukibetsuShiftNyuuryokuSearch.do');
    }

    /**
     * サブウィンドウを開く
     */
    function openWindow(){
        window.open("/kikin/shiftHanrei.do?param=", null, "menubar=no, toolbar=no, scrollbars=auto, resizable=yes, width=520px, height=650px");
    }
    
    </script>
    <title>月別シフト入力画面</title>

    <link href="/kikin/pages/css/common.css" rel="stylesheet" type="text/css" />
  </head>
  <body>
    <div id="wrapper">
      <div id="header">
        <table align="center"><!--No104. 3/13  valign="topalign="center"追加（リン） -->
          <tr>
            <td id="headLeft">
              <input value="戻る" type="button" class="smlButton"  onclick="doSubmit('/kikin/tsukibetsuShiftNyuuryokuBack.do')" />
            </td>
            <td id="headCenter">
              月別シフト入力
            </td>
            <td id="headRight">
              <input value="ログアウト" type="button" class="smlButton"  onclick="logout()" />
            </td>
          </tr>
        </table>
      </div>
      <div id="gymBody" style="overflow: hidden;"  > 
        <html:form action="/tsukibetsuShiftNyuuryokuInit" >
          <div ><!--No104. 3/13  <!--No104. 3/13  valign="topalign="center"削除（リン） -->
            <div style="height: 25px;margin-right:800px;" align="center"><!--No104. 3/13  margin-right:800px; & valign="topalign="center"追加（リン） -->
              表示年月：
              <bean:define id="sessionYearMonth" name="tsukibetsuShiftNyuuryokuForm" property="yearMonth" type="String"/>
              <html:select property="yearMonth" name="tsukibetsuShiftNyuuryokuForm"  onchange="submitSearch()">
              <html:optionsCollection name="tsukibetsuShiftNyuuryokuForm"
                                      property="yearMonthCmbMap"
                                      value="key"
                                      label="value"/>
              </html:select>
              <html:link href="/kikin/tsukibetsuShiftNyuuryokuPage.do?paging=back">前へ</html:link>
              <html:link href="/kikin/tsukibetsuShiftNyuuryokuPage.do?paging=next">次へ</html:link>
              <bean:write name="tsukibetsuShiftNyuuryokuForm" property="cntPage"/>/
              <bean:write name="tsukibetsuShiftNyuuryokuForm" property="maxPage"/>
            </div>
            <table width="1100px" cellpadding="0" cellspacing="0" align="center">
              <tr>
                <td width="150px" valign="top">
                  <table class="tblHeader" border="1" cellpadding="0" cellspacing="0" align="center"><!--No104. 3/13  valign="topalign="center"追加（リン） -->
                    <tr height="<%=heightSize %>px">
                      <td width="150px" align="center">
                        &nbsp;
                      </td>
                    </tr>
                    <tr height="<%=heightSize %>px">
                      <td width="150px" align="center">
                      社員名
                      </td>
                    </tr>
                    <logic:iterate offset="offset" length="<%=showLength%>"  id="tsukibetsuShiftNyuuryokuBeanList" name="tsukibetsuShiftNyuuryokuForm" property="tsukibetsuShiftNyuuryokuBeanList">
                      <tr height="<%=heightSize %>px">
                        <td width="150px" align="center">
                          <bean:write property="shainName" name="tsukibetsuShiftNyuuryokuBeanList"/><br>
                        </td>
                      </tr>
                    </logic:iterate>
                  </table>
                </td>
                <td valign="top">   <!-- valign="top"追加（リン） -->
                  <div style="overflow-x: auto;overflow-y: hidden; width:985px;height: <%=heightSize * (listSize + 2) + 95 %>px; text-align:center;"> <%-- 10->80に変更 （リン）/ 80→95へ修正（高橋） --%>
                    <table class="tblHeader" border="1" cellpadding="0" cellspacing="0">
                      <tr height="<%=heightSize %>px">
                        <td width="40px" align="center">
                          1
                        </td>
                        <td width="40px" align="center">
                          2
                        </td>
                        <td width="40px" align="center">
                          3
                        </td>
                        <td width="40px" align="center">
                          4
                        </td>
                        <td width="40px" align="center">
                          5
                        </td>
                        <td width="40px" align="center">
                          6
                        </td>
                        <td width="40px" align="center">
                          7
                        </td>
                        <td width="40px" align="center">
                          8
                        </td>
                        <td width="40px" align="center">
                          9
                        </td>
                        <td width="40px" align="center">
                          10
                        </td>
                        <td width="40px" align="center">
                          11
                        </td>
                        <td width="40px" align="center">
                          12
                        </td>
                        <td width="40px" align="center">
                          13
                        </td>
                        <td width="40px" align="center">
                          14
                        </td>
                        <td width="40px" align="center">
                          15
                        </td>
                        <td width="40px" align="center">
                          16
                        </td>
                        <td width="40px" align="center">
                          17
                        </td>
                        <td width="40px" align="center">
                          18
                        </td>
                        <td width="40px" align="center">
                          19
                        </td>
                        <td width="40px" align="center">
                          20
                        </td>
                        <td width="40px" align="center">
                          21
                        </td>
                        <td width="40px" align="center">
                          22
                        </td>
                        <td width="40px" align="center">
                          23
                        </td>
                        <td width="40px" align="center">
                          24
                        </td>
                        <td width="40px" align="center">
                          25
                        </td>
                        <td width="40px" align="center">
                          26
                        </td>
                        <td width="40px" align="center">
                          27
                        </td>
                        <% if (dateBeanListSize >= 28) { %>
                        <td width="40px" align="center">
                          28
                        </td>
                        <% } %>
                        <% if (dateBeanListSize >= 29) { %>
                        <td width="40px" align="center">
                          29
                        </td>
                        <% } %>
                        <% if (dateBeanListSize >= 30) { %>
                        <td width="40px" align="center">
                          30
                        </td>
                        <% } %>
                        <% if (dateBeanListSize == 31) { %>
                        <td width="40px" align="center">
                          31
                        </td>
                        <% } %>
                      </tr>
                      <tr height="<%=heightSize %>px">
                        <logic:iterate id="dateBeanList" name="tsukibetsuShiftNyuuryokuForm" property="dateBeanList">
                          <bean:define id="youbi" name="dateBeanList" property="youbi"/>
                           <bean:define id="shukujitsuFlg" name="dateBeanList" property="shukujitsuFlg"/>
                            <%
                            if (DayOfWeek.SATURDAY.getRyaku().equals(youbi)) {
                                color = "fontBlue";
                            } else if (DayOfWeek.SUNDAY.getRyaku().equals(youbi) || ((boolean)shukujitsuFlg)) {
                                color = "fontRed";
                            } else {
                                color = "fontBlack";
                            }
                            %>

                            <td width="40px" align="center" class="<%=color %>">
                              <bean:write property="youbi" name="dateBeanList"/><br>
                            </td>
                        </logic:iterate>
                      </tr>
                      <logic:iterate offset="offset" length="<%=showLength %>" id="tsukibetsuShiftNyuuryokuBeanList" name="tsukibetsuShiftNyuuryokuForm" property="tsukibetsuShiftNyuuryokuBeanList">
                        <html:hidden name="tsukibetsuShiftNyuuryokuBeanList" property="registFlg" value="true" indexed="true"/>
                        <tr height="26px"><%-- height="25.6px"→"26px"へ修正（高橋） --%>
                          <td width="30px" align="center" valign="middle">
                            <html:select property="shiftId01" name="tsukibetsuShiftNyuuryokuBeanList" indexed="true">
                            <html:optionsCollection name="tsukibetsuShiftNyuuryokuForm"
                                                    property="shiftCmbMap"
                                                    value="key"
                                                    label="value"/>
                            </html:select>
                          </td>
                          <!-- width="40px"->30pxに変更（リン） -->
                          <td width="30px" align="center" valign="middle">
                            <html:select property="shiftId02" name="tsukibetsuShiftNyuuryokuBeanList" indexed="true">
                            <html:optionsCollection name="tsukibetsuShiftNyuuryokuForm"
                                                    property="shiftCmbMap"
                                                    value="key"
                                                    label="value"/>
                            </html:select>
                          </td>
                          <td width="30px" align="center" valign="middle">
                            <html:select property="shiftId03" name="tsukibetsuShiftNyuuryokuBeanList" indexed="true">
                            <html:optionsCollection name="tsukibetsuShiftNyuuryokuForm"
                                                    property="shiftCmbMap"
                                                    value="key"
                                                    label="value"/>
                            </html:select>
                          </td>
                          <td width="30px" align="center" valign="middle">
                            <html:select property="shiftId04" name="tsukibetsuShiftNyuuryokuBeanList" indexed="true">
                            <html:optionsCollection name="tsukibetsuShiftNyuuryokuForm"
                                                    property="shiftCmbMap"
                                                    value="key"
                                                    label="value"/>
                            </html:select>
                          </td>
                          <td width="30px" align="center" valign="middle">
                            <html:select property="shiftId05" name="tsukibetsuShiftNyuuryokuBeanList" indexed="true">
                            <html:optionsCollection name="tsukibetsuShiftNyuuryokuForm"
                                                    property="shiftCmbMap"
                                                    value="key"
                                                    label="value"/>
                            </html:select>
                          </td>
                          <td width="30px" align="center" valign="middle">
                            <html:select property="shiftId06" name="tsukibetsuShiftNyuuryokuBeanList" indexed="true">
                            <html:optionsCollection name="tsukibetsuShiftNyuuryokuForm"
                                                    property="shiftCmbMap"
                                                    value="key"
                                                    label="value"/>
                            </html:select>
                          </td>
                          <td width="30px" align="center" valign="middle">
                            <html:select property="shiftId07" name="tsukibetsuShiftNyuuryokuBeanList" indexed="true">
                            <html:optionsCollection name="tsukibetsuShiftNyuuryokuForm"
                                                    property="shiftCmbMap"
                                                    value="key"
                                                    label="value"/>
                            </html:select>
                          </td>
                          <td width="30px" align="center" valign="middle">
                            <html:select property="shiftId08" name="tsukibetsuShiftNyuuryokuBeanList" indexed="true">
                            <html:optionsCollection name="tsukibetsuShiftNyuuryokuForm"
                                                    property="shiftCmbMap"
                                                    value="key"
                                                    label="value"/>
                            </html:select>
                          </td>
                          <td width="30px" align="center" valign="middle">
                            <html:select property="shiftId09" name="tsukibetsuShiftNyuuryokuBeanList" indexed="true">
                            <html:optionsCollection name="tsukibetsuShiftNyuuryokuForm"
                                                    property="shiftCmbMap"
                                                    value="key"
                                                    label="value"/>
                            </html:select>
                          </td>
                          <td width="30px" align="center" valign="middle">
                            <html:select property="shiftId10" name="tsukibetsuShiftNyuuryokuBeanList" indexed="true">
                            <html:optionsCollection name="tsukibetsuShiftNyuuryokuForm"
                                                    property="shiftCmbMap"
                                                    value="key"
                                                    label="value"/>
                            </html:select>
                          </td>
                          <td width="30px" align="center" valign="middle">
                            <html:select property="shiftId11" name="tsukibetsuShiftNyuuryokuBeanList" indexed="true">
                            <html:optionsCollection name="tsukibetsuShiftNyuuryokuForm"
                                                    property="shiftCmbMap"
                                                    value="key"
                                                    label="value"/>
                            </html:select>
                          </td>
                          <td width="30px" align="center" valign="middle">
                            <html:select property="shiftId12" name="tsukibetsuShiftNyuuryokuBeanList" indexed="true">
                            <html:optionsCollection name="tsukibetsuShiftNyuuryokuForm"
                                                    property="shiftCmbMap"
                                                    value="key"
                                                    label="value"/>
                            </html:select>
                          </td>
                          <td width="30px" align="center" valign="middle">
                            <html:select property="shiftId13" name="tsukibetsuShiftNyuuryokuBeanList" indexed="true">
                            <html:optionsCollection name="tsukibetsuShiftNyuuryokuForm"
                                                    property="shiftCmbMap"
                                                    value="key"
                                                    label="value"/>
                            </html:select>
                          </td>
                          <td width="30px" align="center" valign="middle">
                            <html:select property="shiftId14" name="tsukibetsuShiftNyuuryokuBeanList" indexed="true">
                            <html:optionsCollection name="tsukibetsuShiftNyuuryokuForm"
                                                    property="shiftCmbMap"
                                                    value="key"
                                                    label="value"/>
                            </html:select>
                          </td>
                          <td width="30px" align="center" valign="middle">
                            <html:select property="shiftId15" name="tsukibetsuShiftNyuuryokuBeanList" indexed="true">
                            <html:optionsCollection name="tsukibetsuShiftNyuuryokuForm"
                                                    property="shiftCmbMap"
                                                    value="key"
                                                    label="value"/>
                            </html:select>
                          </td>
                          <td width="30px" align="center" valign="middle">
                            <html:select property="shiftId16" name="tsukibetsuShiftNyuuryokuBeanList" indexed="true">
                            <html:optionsCollection name="tsukibetsuShiftNyuuryokuForm"
                                                    property="shiftCmbMap"
                                                    value="key"
                                                    label="value"/>
                            </html:select>
                          </td>
                          <td width="30px" align="center" valign="middle">
                            <html:select property="shiftId17" name="tsukibetsuShiftNyuuryokuBeanList" indexed="true">
                            <html:optionsCollection name="tsukibetsuShiftNyuuryokuForm"
                                                    property="shiftCmbMap"
                                                    value="key"
                                                    label="value"/>
                            </html:select>
                          </td>
                          <td width="30px" align="center" valign="middle">
                            <html:select property="shiftId18" name="tsukibetsuShiftNyuuryokuBeanList" indexed="true">
                            <html:optionsCollection name="tsukibetsuShiftNyuuryokuForm"
                                                    property="shiftCmbMap"
                                                    value="key"
                                                    label="value"/>
                            </html:select>
                          </td>
                          <td width="30px" align="center" valign="middle">
                            <html:select property="shiftId19" name="tsukibetsuShiftNyuuryokuBeanList" indexed="true">
                            <html:optionsCollection name="tsukibetsuShiftNyuuryokuForm"
                                                    property="shiftCmbMap"
                                                    value="key"
                                                    label="value"/>
                            </html:select>
                          </td>
                          <td width="30px" align="center" valign="middle">
                            <html:select property="shiftId20" name="tsukibetsuShiftNyuuryokuBeanList" indexed="true">
                            <html:optionsCollection name="tsukibetsuShiftNyuuryokuForm"
                                                    property="shiftCmbMap"
                                                    value="key"
                                                    label="value"/>
                            </html:select>
                          </td>
                          <td width="30px" align="center" valign="middle">
                            <html:select property="shiftId21" name="tsukibetsuShiftNyuuryokuBeanList" indexed="true">
                            <html:optionsCollection name="tsukibetsuShiftNyuuryokuForm"
                                                    property="shiftCmbMap"
                                                    value="key"
                                                    label="value"/>
                            </html:select>
                          </td>
                          <td width="30px" align="center" valign="middle">
                            <html:select property="shiftId22" name="tsukibetsuShiftNyuuryokuBeanList" indexed="true">
                            <html:optionsCollection name="tsukibetsuShiftNyuuryokuForm"
                                                    property="shiftCmbMap"
                                                    value="key"
                                                    label="value"/>
                            </html:select>
                          </td>
                          <td width="30px" align="center" valign="middle">
                            <html:select property="shiftId23" name="tsukibetsuShiftNyuuryokuBeanList" indexed="true">
                            <html:optionsCollection name="tsukibetsuShiftNyuuryokuForm"
                                                    property="shiftCmbMap"
                                                    value="key"
                                                    label="value"/>
                            </html:select>
                          </td>
                          <td width="30px" align="center" valign="middle">
                            <html:select property="shiftId24" name="tsukibetsuShiftNyuuryokuBeanList" indexed="true">
                            <html:optionsCollection name="tsukibetsuShiftNyuuryokuForm"
                                                    property="shiftCmbMap"
                                                    value="key"
                                                    label="value"/>
                            </html:select>
                          </td>
                          <td width="30px" align="center" valign="middle">
                            <html:select property="shiftId25" name="tsukibetsuShiftNyuuryokuBeanList" indexed="true">
                            <html:optionsCollection name="tsukibetsuShiftNyuuryokuForm"
                                                    property="shiftCmbMap"
                                                    value="key"
                                                    label="value"/>
                            </html:select>
                          </td>
                          <td width="30px" align="center" valign="middle">
                            <html:select property="shiftId26" name="tsukibetsuShiftNyuuryokuBeanList" indexed="true">
                            <html:optionsCollection name="tsukibetsuShiftNyuuryokuForm"
                                                    property="shiftCmbMap"
                                                    value="key"
                                                    label="value"/>
                            </html:select>
                          </td>
                          <td width="30px" align="center" valign="middle">
                            <html:select property="shiftId27" name="tsukibetsuShiftNyuuryokuBeanList" indexed="true">
                            <html:optionsCollection name="tsukibetsuShiftNyuuryokuForm"
                                                    property="shiftCmbMap"
                                                    value="key"
                                                    label="value"/>
                            </html:select>
                          </td>
                          <% if (dateBeanListSize >= 28) { %>
                          <td width="30px" align="center" valign="middle">
                            <html:select property="shiftId28" name="tsukibetsuShiftNyuuryokuBeanList" indexed="true">
                            <html:optionsCollection name="tsukibetsuShiftNyuuryokuForm"
                                                    property="shiftCmbMap"
                                                    value="key"
                                                    label="value"/>
                            </html:select>
                          </td>
                          <% } %>
                          <% if (dateBeanListSize >= 29) { %>
                          <td width="30px" align="center" valign="middle">
                            <html:select property="shiftId29" name="tsukibetsuShiftNyuuryokuBeanList" indexed="true">
                            <html:optionsCollection name="tsukibetsuShiftNyuuryokuForm"
                                                    property="shiftCmbMap"
                                                    value="key"
                                                    label="value"/>
                            </html:select>
                          </td>
                          <% } %>
                          <% if (dateBeanListSize >= 30) { %>
                          <td width="30px" align="center" valign="middle">
                            <html:select property="shiftId30" name="tsukibetsuShiftNyuuryokuBeanList" indexed="true">
                            <html:optionsCollection name="tsukibetsuShiftNyuuryokuForm"
                                                    property="shiftCmbMap"
                                                    value="key"
                                                    label="value"/>
                            </html:select>
                          </td>
                          <% } %>
                          <% if (dateBeanListSize >= 31) { %>
                          <td width="30px" align="center" valign="middle">
                            <html:select property="shiftId31" name="tsukibetsuShiftNyuuryokuBeanList" indexed="true">
                            <html:optionsCollection name="tsukibetsuShiftNyuuryokuForm"
                                                    property="shiftCmbMap"
                                                    value="key"
                                                    label="value"/>
                            </html:select>
                          </td>
                          <% } %>
                        </tr>
                      </logic:iterate>
                    </table>
                  </div>
                </td>
              </tr>
            </table>
          </div>
        </html:form>
        <div style="margin-right:450px;" align="center"> <!--No104. 3/13  style="margin-right:450px;" align="center"追加（リン） -->
          <input value="凡例表示" type="button" class="lngButton"  onclick="openWindow()" />
          <input value="基本シフト反映" type="button" class="lngButton" onclick = "submitShukkinKihon()" />
          <input value="出勤希望日反映" type="button" class="lngButton"  onclick="submitShukkinKibou()" />
        </div>
      </div> 
      <div id="footer">
        <table align="center"><!--No104. 3/13  valign="topalign="center"追加（リン） -->
          <tr>
            <td id="footLeft">
            </td>
            <td id="footCenter" style="text-align: right;">

            </td>
            <td id="footRight" style="display: flex;justify-content: flex-start;margin-left:200px;"><!--No104. 3/13 style="display: flex;justify-content: flex-start;margin-left:200px;"追加（リン） -->
              <input value="登録" type="button" class="smlButton"  onclick="submitRegist()" />
            </td>
          </tr>
        </table>
      </div>
    </div>
  </body>
</html>