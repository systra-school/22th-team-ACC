<!-- hibetsuShift.jsp -->
<%@page import="business.logic.utils.CheckUtils"%>
<%@page import="form.common.DateBean"%>
<%@page import="java.util.List"%>
<%@page import="form.shk.ShukkinKibouKakuninForm"%>
<%
/**
 * ファイル名：hibetsuShift.jsp
 *
 * 変更履歴
 * 1.0  2010/09/13 Kazuya.Naraki
 */
%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="constant.RequestSessionNameConstant"%>
<%@ page import="constant.CommonConstant"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<bean:size id="hibetsuShiftBeanListSize" name="hibetsuShiftForm"  property="hibetsuShiftBeanList"/>
<%
    int bodyRightDivWidth = 0;
    int bodyRightDivHeight = 0;
    int bodyLeftDivHeight = 0;
    // ボディテーブルの td の幅
    int tdWidth = 150;
    // ボディテーブルの tr の縦
    int trHeight = 50;
    // 縦スクロールバーの幅
    int scrollBarSize = 20;
    if (hibetsuShiftBeanListSize < 6) {
        bodyRightDivWidth = hibetsuShiftBeanListSize * tdWidth + scrollBarSize;
        bodyRightDivHeight = 402;
        bodyLeftDivHeight = 402;
    } else {
        bodyRightDivWidth = 918;
        bodyRightDivHeight = 418;
        bodyLeftDivHeight = 402;
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
    <!--

    /**
     * 検索
     */
    function submitSearch() {
        doSubmit('/kikin/shukkinKibouKakuninShow.do');
    }

    /**
     * スクロールを同期させる
     */
    function onScroll() {
        headRightTbl.scrollLeft = bodyRightTbl.scrollLeft;
        bodyLeftTbl.scrollTop = bodyRightTbl.scrollTop;
    }
    -->
    </script>
    <title>日別シフト確認画面</title>

    <link href="/kikin/pages/css/common.css" rel="stylesheet" type="text/css" />
  </head>
  <body>
    <div id="wrapper">
      <div id="header">
        <table>
          <tr>
            <td id="headLeft">
              <input value="戻る" type="button" class="smlButton"  onclick="doSubmit('/kikin/hibetsuShiftBack.do')" />
            </td>
            <td id="headCenter">
              日別シフト確認画面
            </td>
            <td id="headRight">
              <input value="ログアウト" type="button" class="smlButton"  onclick="logout()" />
            </td>
          </tr>
        </table>
      </div>
      <div id="gymBody" style="overflow: hidden;">
        <div style="margin-left:80px;">
          <html:form>
            <div style="height: 20px">
              表示年月：
              <html:link href="/kikin/hibetsuShiftPage.do?paging=back">前日</html:link>
              <bean:write name="hibetsuShiftForm" property="yearMonthDayDisp"/>
              <html:link href="/kikin/hibetsuShiftPage.do?paging=next">翌日</html:link>
            </div>
            <!-- テーブルズレている修正（リン）
            元コード -->
            <!-- <table border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td width="154px" >
                  <div id="headLeftTbl" style="overflow-x: hidden;overflow-y: hidden;width: 154px;">
                    <table border="1" cellpadding="0" cellspacing="0" class="tblHeader">
                      <tr>
                        <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                        時間
                        </td>
                      </tr>
                    </table>
                  </div>
                </td>
                <td width="100%" valign="top">
                  <div id="headRightTbl" style="overflow-y: scroll;overflow-x: hidden;width: <%=bodyRightDivWidth%>px; ">
                    <table border="1" cellpadding="0" cellspacing="0" class="tblHeader">
                      <tr>
                        <logic:iterate id="hibetsuShiftBean" name="hibetsuShiftForm" property="hibetsuShiftBeanList">
                          <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                            <bean:write name="hibetsuShiftBean" property="shainName"/><br>
                          </td>
                        </logic:iterate>
                      </tr>
                    </table>
                  </div>
                </td>
              </tr>
            </table>
            <table border="0" cellpadding="0" cellspacing="0">
              <tr height="100%">
                <td valign="top">
                  <div id="bodyLeftTbl" style="overflow-x: auto;overflow-y: hidden;width: 154px;height:<%=bodyLeftDivHeight %>px; ">
                    <table border="1" cellpadding="0" cellspacing="0" class="tblBody">
                      <tr height="<%=trHeight %>px">
                        <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                        ００：００&#xFF5E;０１：００
                        </td>
                      </tr>
                      <tr height="<%=trHeight %>px">
                        <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                        ０１：００&#xFF5E;０２：００
                        </td>
                      </tr>
                      <tr height="<%=trHeight %>px">
                        <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                        ０２：００&#xFF5E;０３：００
                        </td>
                      </tr>
                      <tr height="<%=trHeight %>px">
                        <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                        ０３：００&#xFF5E;０<%=tdWidth %>０
                        </td>
                      </tr>
                      <tr height="<%=trHeight %>px">
                        <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                        ０４：００&#xFF5E;０５：００
                        </td>
                      </tr>
                      <tr height="<%=trHeight %>px">
                        <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                        ０５：００&#xFF5E;０６：００
                        </td>
                      </tr>
                      <tr height="<%=trHeight %>px">
                        <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                        ０６：００&#xFF5E;０７：００
                        </td>
                      </tr>
                      <tr height="<%=trHeight %>px">
                        <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                        ０７：００&#xFF5E;０８：００
                        </td>
                      </tr>
                      <tr height="<%=trHeight %>px">
                        <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                        ０８：００&#xFF5E;０９：００
                        </td>
                      </tr>
                      <tr height="<%=trHeight %>px">
                        <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                        ０９：００&#xFF5E;１０：００
                        </td>
                      </tr>
                      <tr height="<%=trHeight %>px">
                        <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                        １０：００&#xFF5E;１１：００
                        </td>
                      </tr>
                      <tr height="<%=trHeight %>px">
                        <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                        １１：００&#xFF5E;１２：００
                        </td>
                      </tr>
                      <tr height="<%=trHeight %>px">
                        <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                        １２：００&#xFF5E;１３：００
                        </td>
                      </tr>
                      <tr height="<%=trHeight %>px">
                        <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                        １３：００&#xFF5E;１４：００
                        </td>
                      </tr>
                      <tr height="<%=trHeight %>px">
                        <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                        １４：００&#xFF5E;１５：００
                        </td>
                      </tr>
                      <tr height="<%=trHeight %>px">
                        <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                        １５：００&#xFF5E;１６：００
                        </td>
                      </tr>
                      <tr height="<%=trHeight %>px">
                        <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                        １６：００&#xFF5E;１７：００
                        </td>
                      </tr>
                      <tr height="<%=trHeight %>px">
                        <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                        １７：００&#xFF5E;１８：００
                        </td>
                      </tr>
                      <tr height="<%=trHeight %>px">
                        <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                        １８：００&#xFF5E;１９：００
                        </td>
                      </tr>
                      <tr height="<%=trHeight %>px">
                        <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                        １９：００&#xFF5E;２０：００
                        </td>
                      </tr>
                      <tr height="<%=trHeight %>px">
                        <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                        ２０：００&#xFF5E;２１：００
                        </td>
                      </tr>
                      <tr height="<%=trHeight %>px">
                        <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                        ２１：００&#xFF5E;２２：００
                        </td>
                      </tr>
                      <tr height="<%=trHeight %>px">
                        <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                        ２２：００&#xFF5E;２３：００
                        </td>
                      </tr>
                      <tr height="<%=trHeight %>px">
                        <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                        ２３：００&#xFF5E;２４：００
                        </td>
                      </tr>
                    </table>
                  </div>
                </td>
                <td width="100%" valign="top">
                  <div id="bodyRightTbl"  style="overflow-x: auto;overflow-y: auto;width: <%=bodyRightDivWidth %>px;height:<%=bodyRightDivHeight %>px;" onScroll="onScroll();">
                    <table border="1" cellpadding="0" cellspacing="0" class="tblBody">
                      <tr height="<%=trHeight %>px">
                        <logic:iterate id="hibetsuShiftBean" name="hibetsuShiftForm" property="hibetsuShiftBeanList">
                          <logic:equal value="true" name="hibetsuShiftBean" property="boolTime00">
                          <% // 出勤予定の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center" bgcolor="LightPink">
                              <logic:empty name="hibetsuShiftBean" property="strTime00" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime00" >

                                <bean:write name="hibetsuShiftBean" property="strTime00"/>：

                                <logic:equal value="出勤" name="hibetsuShiftBean" property="strTime00">
                                  <bean:write name="hibetsuShiftBean" property="startTime"/>
                                  &#xFF5E;
                                  <bean:write name="hibetsuShiftBean" property="endTime"/>
                                  <br><bean:write name="hibetsuShiftBean" property="breakTime"/>
                                </logic:equal>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                          <logic:equal value="false" name="hibetsuShiftBean" property="boolTime00">
                          <% // 出勤予定外の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                              <logic:empty name="hibetsuShiftBean" property="strTime00" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime00" >
                                <bean:write name="hibetsuShiftBean" property="strTime00"/>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                        </logic:iterate>
                      </tr>

                      <tr height="<%=trHeight %>px">
                        <logic:iterate id="hibetsuShiftBean" name="hibetsuShiftForm" property="hibetsuShiftBeanList">
                          <logic:equal value="true" name="hibetsuShiftBean" property="boolTime01">
                          <% // 出勤予定の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center" bgcolor="LightPink">
                              <logic:empty name="hibetsuShiftBean" property="strTime01" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime01" >

                                <bean:write name="hibetsuShiftBean" property="strTime01"/>：

                                <logic:equal value="出勤" name="hibetsuShiftBean" property="strTime01">
                                  <bean:write name="hibetsuShiftBean" property="startTime"/>
                                  &#xFF5E;
                                  <bean:write name="hibetsuShiftBean" property="endTime"/>
                                  <br><bean:write name="hibetsuShiftBean" property="breakTime"/>
                                </logic:equal>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                          <logic:equal value="false" name="hibetsuShiftBean" property="boolTime01">
                          <% // 出勤予定外の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                              <logic:empty name="hibetsuShiftBean" property="strTime01" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime01" >
                                <bean:write name="hibetsuShiftBean" property="strTime01"/>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                        </logic:iterate>
                      </tr>

                      <tr height="<%=trHeight %>px">
                        <logic:iterate id="hibetsuShiftBean" name="hibetsuShiftForm" property="hibetsuShiftBeanList">
                          <logic:equal value="true" name="hibetsuShiftBean" property="boolTime02">
                          <% // 出勤予定の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center" bgcolor="LightPink">
                              <logic:empty name="hibetsuShiftBean" property="strTime02" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime02" >

                                <bean:write name="hibetsuShiftBean" property="strTime02"/>：

                                <logic:equal value="出勤" name="hibetsuShiftBean" property="strTime02">
                                  <bean:write name="hibetsuShiftBean" property="startTime"/>
                                  &#xFF5E;
                                  <bean:write name="hibetsuShiftBean" property="endTime"/>
                                  <br><bean:write name="hibetsuShiftBean" property="breakTime"/>
                                </logic:equal>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                          <logic:equal value="false" name="hibetsuShiftBean" property="boolTime02">
                          <% // 出勤予定外の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                              <logic:empty name="hibetsuShiftBean" property="strTime02" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime02" >
                                <bean:write name="hibetsuShiftBean" property="strTime02"/>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                        </logic:iterate>
                      </tr>

                      <tr height="<%=trHeight %>px">
                        <logic:iterate id="hibetsuShiftBean" name="hibetsuShiftForm" property="hibetsuShiftBeanList">
                          <logic:equal value="true" name="hibetsuShiftBean" property="boolTime03">
                          <% // 出勤予定の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center" bgcolor="LightPink">
                              <logic:empty name="hibetsuShiftBean" property="strTime03" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime03" >

                                <bean:write name="hibetsuShiftBean" property="strTime03"/>：

                                <logic:equal value="出勤" name="hibetsuShiftBean" property="strTime03">
                                  <bean:write name="hibetsuShiftBean" property="startTime"/>
                                  &#xFF5E;
                                  <bean:write name="hibetsuShiftBean" property="endTime"/>
                                  <br><bean:write name="hibetsuShiftBean" property="breakTime"/>
                                </logic:equal>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                          <logic:equal value="false" name="hibetsuShiftBean" property="boolTime03">
                          <% // 出勤予定外の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                              <logic:empty name="hibetsuShiftBean" property="strTime03" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime03" >
                                <bean:write name="hibetsuShiftBean" property="strTime03"/>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                        </logic:iterate>
                      </tr>

                      <tr height="<%=trHeight %>px">
                        <logic:iterate id="hibetsuShiftBean" name="hibetsuShiftForm" property="hibetsuShiftBeanList">
                          <logic:equal value="true" name="hibetsuShiftBean" property="boolTime04">
                          <% // 出勤予定の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center" bgcolor="LightPink">
                              <logic:empty name="hibetsuShiftBean" property="strTime04" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime04" >

                                <bean:write name="hibetsuShiftBean" property="strTime04"/>：

                                <logic:equal value="出勤" name="hibetsuShiftBean" property="strTime04">
                                  <bean:write name="hibetsuShiftBean" property="startTime"/>
                                  &#xFF5E;
                                  <bean:write name="hibetsuShiftBean" property="endTime"/>
                                  <br><bean:write name="hibetsuShiftBean" property="breakTime"/>
                                </logic:equal>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                          <logic:equal value="false" name="hibetsuShiftBean" property="boolTime04">
                          <% // 出勤予定外の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                              <logic:empty name="hibetsuShiftBean" property="strTime04" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime04" >
                                <bean:write name="hibetsuShiftBean" property="strTime04"/>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                        </logic:iterate>
                      </tr>

                      <tr height="<%=trHeight %>px">
                        <logic:iterate id="hibetsuShiftBean" name="hibetsuShiftForm" property="hibetsuShiftBeanList">
                          <logic:equal value="true" name="hibetsuShiftBean" property="boolTime05">
                          <% // 出勤予定の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center" bgcolor="LightPink">
                              <logic:empty name="hibetsuShiftBean" property="strTime05" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime05" >

                                <bean:write name="hibetsuShiftBean" property="strTime05"/>：

                                <logic:equal value="出勤" name="hibetsuShiftBean" property="strTime05">
                                  <bean:write name="hibetsuShiftBean" property="startTime"/>
                                  &#xFF5E;
                                  <bean:write name="hibetsuShiftBean" property="endTime"/>
                                  <br><bean:write name="hibetsuShiftBean" property="breakTime"/>
                                </logic:equal>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                          <logic:equal value="false" name="hibetsuShiftBean" property="boolTime05">
                          <% // 出勤予定外の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                              <logic:empty name="hibetsuShiftBean" property="strTime05" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime05" >
                                <bean:write name="hibetsuShiftBean" property="strTime05"/>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                        </logic:iterate>
                      </tr>

                      <tr height="<%=trHeight %>px">
                        <logic:iterate id="hibetsuShiftBean" name="hibetsuShiftForm" property="hibetsuShiftBeanList">
                          <logic:equal value="true" name="hibetsuShiftBean" property="boolTime06">
                          <% // 出勤予定の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center" bgcolor="LightPink">
                              <logic:empty name="hibetsuShiftBean" property="strTime06" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime06" >

                                <bean:write name="hibetsuShiftBean" property="strTime06"/>：

                                <logic:equal value="出勤" name="hibetsuShiftBean" property="strTime06">
                                  <bean:write name="hibetsuShiftBean" property="startTime"/>
                                  &#xFF5E;
                                  <bean:write name="hibetsuShiftBean" property="endTime"/>
                                  <br><bean:write name="hibetsuShiftBean" property="breakTime"/>
                                </logic:equal>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                          <logic:equal value="false" name="hibetsuShiftBean" property="boolTime06">
                          <% // 出勤予定外の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                              <logic:empty name="hibetsuShiftBean" property="strTime06" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime06" >
                                <bean:write name="hibetsuShiftBean" property="strTime06"/>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                        </logic:iterate>
                      </tr>

                      <tr height="<%=trHeight %>px">
                        <logic:iterate id="hibetsuShiftBean" name="hibetsuShiftForm" property="hibetsuShiftBeanList">
                          <logic:equal value="true" name="hibetsuShiftBean" property="boolTime07">
                          <% // 出勤予定の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center" bgcolor="LightPink">
                              <logic:empty name="hibetsuShiftBean" property="strTime07" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime07" >

                                <bean:write name="hibetsuShiftBean" property="strTime07"/>：

                                <logic:equal value="出勤" name="hibetsuShiftBean" property="strTime07">
                                  <bean:write name="hibetsuShiftBean" property="startTime"/>
                                  &#xFF5E;
                                  <bean:write name="hibetsuShiftBean" property="endTime"/>
                                  <br><bean:write name="hibetsuShiftBean" property="breakTime"/>
                                </logic:equal>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                          <logic:equal value="false" name="hibetsuShiftBean" property="boolTime07">
                          <% // 出勤予定外の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                              <logic:empty name="hibetsuShiftBean" property="strTime07" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime07" >
                                <bean:write name="hibetsuShiftBean" property="strTime07"/>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                        </logic:iterate>
                      </tr>

                      <tr height="<%=trHeight %>px">
                        <logic:iterate id="hibetsuShiftBean" name="hibetsuShiftForm" property="hibetsuShiftBeanList">
                          <logic:equal value="true" name="hibetsuShiftBean" property="boolTime08">
                          <% // 出勤予定の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center" bgcolor="LightPink">
                              <logic:empty name="hibetsuShiftBean" property="strTime08" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime08" >

                                <bean:write name="hibetsuShiftBean" property="strTime08"/>：

                                <logic:equal value="出勤" name="hibetsuShiftBean" property="strTime08">
                                  <bean:write name="hibetsuShiftBean" property="startTime"/>
                                  &#xFF5E;
                                  <bean:write name="hibetsuShiftBean" property="endTime"/>
                                  <br><bean:write name="hibetsuShiftBean" property="breakTime"/>
                                </logic:equal>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                          <logic:equal value="false" name="hibetsuShiftBean" property="boolTime08">
                          <% // 出勤予定外の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                              <logic:empty name="hibetsuShiftBean" property="strTime08" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime08" >
                                <bean:write name="hibetsuShiftBean" property="strTime08"/>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                        </logic:iterate>
                      </tr>

                      <tr height="<%=trHeight %>px">
                        <logic:iterate id="hibetsuShiftBean" name="hibetsuShiftForm" property="hibetsuShiftBeanList">
                          <logic:equal value="true" name="hibetsuShiftBean" property="boolTime09">
                          <% // 出勤予定の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center" bgcolor="LightPink">
                              <logic:empty name="hibetsuShiftBean" property="strTime09" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime09" >

                                <bean:write name="hibetsuShiftBean" property="strTime09"/>：

                                <logic:equal value="出勤" name="hibetsuShiftBean" property="strTime09">
                                  <bean:write name="hibetsuShiftBean" property="startTime"/>
                                  &#xFF5E;
                                  <bean:write name="hibetsuShiftBean" property="endTime"/>
                                  <br><bean:write name="hibetsuShiftBean" property="breakTime"/>
                                </logic:equal>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                          <logic:equal value="false" name="hibetsuShiftBean" property="boolTime09">
                          <% // 出勤予定外の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                              <logic:empty name="hibetsuShiftBean" property="strTime09" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime09" >
                                <bean:write name="hibetsuShiftBean" property="strTime09"/>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                        </logic:iterate>
                      </tr>

                      <tr height="<%=trHeight %>px">
                        <logic:iterate id="hibetsuShiftBean" name="hibetsuShiftForm" property="hibetsuShiftBeanList">
                          <logic:equal value="true" name="hibetsuShiftBean" property="boolTime10">
                          <% // 出勤予定の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center" bgcolor="LightPink">
                              <logic:empty name="hibetsuShiftBean" property="strTime10" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime10" >

                                <bean:write name="hibetsuShiftBean" property="strTime10"/>：

                                <logic:equal value="出勤" name="hibetsuShiftBean" property="strTime10">
                                  <bean:write name="hibetsuShiftBean" property="startTime"/>
                                  &#xFF5E;
                                  <bean:write name="hibetsuShiftBean" property="endTime"/>
                                  <br><bean:write name="hibetsuShiftBean" property="breakTime"/>
                                </logic:equal>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                          <logic:equal value="false" name="hibetsuShiftBean" property="boolTime10">
                          <% // 出勤予定外の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                              <logic:empty name="hibetsuShiftBean" property="strTime10" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime10" >
                                <bean:write name="hibetsuShiftBean" property="strTime10"/>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                        </logic:iterate>
                      </tr>

                      <tr height="<%=trHeight %>px">
                        <logic:iterate id="hibetsuShiftBean" name="hibetsuShiftForm" property="hibetsuShiftBeanList">
                          <logic:equal value="true" name="hibetsuShiftBean" property="boolTime11">
                          <% // 出勤予定の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center" bgcolor="LightPink">
                              <logic:empty name="hibetsuShiftBean" property="strTime11" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime11" >

                                <bean:write name="hibetsuShiftBean" property="strTime11"/>：

                                <logic:equal value="出勤" name="hibetsuShiftBean" property="strTime11">
                                  <bean:write name="hibetsuShiftBean" property="startTime"/>
                                  &#xFF5E;
                                  <bean:write name="hibetsuShiftBean" property="endTime"/>
                                  <br><bean:write name="hibetsuShiftBean" property="breakTime"/>
                                </logic:equal>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                          <logic:equal value="false" name="hibetsuShiftBean" property="boolTime11">
                          <% // 出勤予定外の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                              <logic:empty name="hibetsuShiftBean" property="strTime11" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime11" >
                                <bean:write name="hibetsuShiftBean" property="strTime11"/>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                        </logic:iterate>
                      </tr>

                      <tr height="<%=trHeight %>px">
                        <logic:iterate id="hibetsuShiftBean" name="hibetsuShiftForm" property="hibetsuShiftBeanList">
                          <logic:equal value="true" name="hibetsuShiftBean" property="boolTime12">
                          <% // 出勤予定の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center" bgcolor="LightPink">
                              <logic:empty name="hibetsuShiftBean" property="strTime12" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime12" >

                                <bean:write name="hibetsuShiftBean" property="strTime12"/>：

                                <logic:equal value="出勤" name="hibetsuShiftBean" property="strTime12">
                                  <bean:write name="hibetsuShiftBean" property="startTime"/>
                                  &#xFF5E;
                                  <bean:write name="hibetsuShiftBean" property="endTime"/>
                                  <br><bean:write name="hibetsuShiftBean" property="breakTime"/>
                                </logic:equal>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                          <logic:equal value="false" name="hibetsuShiftBean" property="boolTime12">
                          <% // 出勤予定外の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                              <logic:empty name="hibetsuShiftBean" property="strTime12" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime12" >
                                <bean:write name="hibetsuShiftBean" property="strTime12"/>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                        </logic:iterate>
                      </tr>

                      <tr height="<%=trHeight %>px">
                        <logic:iterate id="hibetsuShiftBean" name="hibetsuShiftForm" property="hibetsuShiftBeanList">
                          <logic:equal value="true" name="hibetsuShiftBean" property="boolTime13">
                          <% // 出勤予定の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center" bgcolor="LightPink">
                              <logic:empty name="hibetsuShiftBean" property="strTime13" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime13" >

                                <bean:write name="hibetsuShiftBean" property="strTime13"/>：

                                <logic:equal value="出勤" name="hibetsuShiftBean" property="strTime13">
                                  <bean:write name="hibetsuShiftBean" property="startTime"/>
                                  &#xFF5E;
                                  <bean:write name="hibetsuShiftBean" property="endTime"/>
                                  <br><bean:write name="hibetsuShiftBean" property="breakTime"/>
                                </logic:equal>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                          <logic:equal value="false" name="hibetsuShiftBean" property="boolTime13">
                          <% // 出勤予定外の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                              <logic:empty name="hibetsuShiftBean" property="strTime13" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime13" >
                                <bean:write name="hibetsuShiftBean" property="strTime13"/>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                        </logic:iterate>
                      </tr>

                      <tr height="<%=trHeight %>px">
                        <logic:iterate id="hibetsuShiftBean" name="hibetsuShiftForm" property="hibetsuShiftBeanList">
                          <logic:equal value="true" name="hibetsuShiftBean" property="boolTime14">
                          <% // 出勤予定の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center" bgcolor="LightPink">
                              <logic:empty name="hibetsuShiftBean" property="strTime14" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime14" >

                                <bean:write name="hibetsuShiftBean" property="strTime14"/>：

                                <logic:equal value="出勤" name="hibetsuShiftBean" property="strTime14">
                                  <bean:write name="hibetsuShiftBean" property="startTime"/>
                                  &#xFF5E;
                                  <bean:write name="hibetsuShiftBean" property="endTime"/>
                                  <br><bean:write name="hibetsuShiftBean" property="breakTime"/>
                                </logic:equal>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                          <logic:equal value="false" name="hibetsuShiftBean" property="boolTime14">
                          <% // 出勤予定外の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                              <logic:empty name="hibetsuShiftBean" property="strTime14" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime14" >
                                <bean:write name="hibetsuShiftBean" property="strTime14"/>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                        </logic:iterate>
                      </tr>

                      <tr height="<%=trHeight %>px">
                        <logic:iterate id="hibetsuShiftBean" name="hibetsuShiftForm" property="hibetsuShiftBeanList">
                          <logic:equal value="true" name="hibetsuShiftBean" property="boolTime15">
                          <% // 出勤予定の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center" bgcolor="LightPink">
                              <logic:empty name="hibetsuShiftBean" property="strTime15" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime15" >

                                <bean:write name="hibetsuShiftBean" property="strTime15"/>：

                                <logic:equal value="出勤" name="hibetsuShiftBean" property="strTime15">
                                  <bean:write name="hibetsuShiftBean" property="startTime"/>
                                  &#xFF5E;
                                  <bean:write name="hibetsuShiftBean" property="endTime"/>
                                  <br><bean:write name="hibetsuShiftBean" property="breakTime"/>
                                </logic:equal>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                          <logic:equal value="false" name="hibetsuShiftBean" property="boolTime15">
                          <% // 出勤予定外の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                              <logic:empty name="hibetsuShiftBean" property="strTime15" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime15" >
                                <bean:write name="hibetsuShiftBean" property="strTime15"/>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                        </logic:iterate>
                      </tr>

                      <tr height="<%=trHeight %>px">
                        <logic:iterate id="hibetsuShiftBean" name="hibetsuShiftForm" property="hibetsuShiftBeanList">
                          <logic:equal value="true" name="hibetsuShiftBean" property="boolTime16">
                          <% // 出勤予定の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center" bgcolor="LightPink">
                              <logic:empty name="hibetsuShiftBean" property="strTime16" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime16" >

                                <bean:write name="hibetsuShiftBean" property="strTime16"/>：

                                <logic:equal value="出勤" name="hibetsuShiftBean" property="strTime16">
                                  <bean:write name="hibetsuShiftBean" property="startTime"/>
                                  &#xFF5E;
                                  <bean:write name="hibetsuShiftBean" property="endTime"/>
                                  <br><bean:write name="hibetsuShiftBean" property="breakTime"/>
                                </logic:equal>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                          <logic:equal value="false" name="hibetsuShiftBean" property="boolTime16">
                          <% // 出勤予定外の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                              <logic:empty name="hibetsuShiftBean" property="strTime16" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime16" >
                                <bean:write name="hibetsuShiftBean" property="strTime16"/>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                        </logic:iterate>
                      </tr>

                      <tr height="<%=trHeight %>px">
                        <logic:iterate id="hibetsuShiftBean" name="hibetsuShiftForm" property="hibetsuShiftBeanList">
                          <logic:equal value="true" name="hibetsuShiftBean" property="boolTime17">
                          <% // 出勤予定の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center" bgcolor="LightPink">
                              <logic:empty name="hibetsuShiftBean" property="strTime17" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime17" >

                                <bean:write name="hibetsuShiftBean" property="strTime17"/>：

                                <logic:equal value="出勤" name="hibetsuShiftBean" property="strTime17">
                                  <bean:write name="hibetsuShiftBean" property="startTime"/>
                                  &#xFF5E;
                                  <bean:write name="hibetsuShiftBean" property="endTime"/>
                                  <br><bean:write name="hibetsuShiftBean" property="breakTime"/>
                                </logic:equal>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                          <logic:equal value="false" name="hibetsuShiftBean" property="boolTime17">
                          <% // 出勤予定外の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                              <logic:empty name="hibetsuShiftBean" property="strTime17" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime17" >
                                <bean:write name="hibetsuShiftBean" property="strTime17"/>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                        </logic:iterate>
                      </tr>

                      <tr height="<%=trHeight %>px">
                        <logic:iterate id="hibetsuShiftBean" name="hibetsuShiftForm" property="hibetsuShiftBeanList">
                          <logic:equal value="true" name="hibetsuShiftBean" property="boolTime18">
                          <% // 出勤予定の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center" bgcolor="LightPink">
                              <logic:empty name="hibetsuShiftBean" property="strTime18" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime18" >

                                <bean:write name="hibetsuShiftBean" property="strTime18"/>：

                                <logic:equal value="出勤" name="hibetsuShiftBean" property="strTime18">
                                  <bean:write name="hibetsuShiftBean" property="startTime"/>
                                  &#xFF5E;
                                  <bean:write name="hibetsuShiftBean" property="endTime"/>
                                  <br><bean:write name="hibetsuShiftBean" property="breakTime"/>
                                </logic:equal>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                          <logic:equal value="false" name="hibetsuShiftBean" property="boolTime18">
                          <% // 出勤予定外の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                              <logic:empty name="hibetsuShiftBean" property="strTime18" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime18" >
                                <bean:write name="hibetsuShiftBean" property="strTime18"/>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                        </logic:iterate>
                      </tr>

                      <tr height="<%=trHeight %>px">
                        <logic:iterate id="hibetsuShiftBean" name="hibetsuShiftForm" property="hibetsuShiftBeanList">
                          <logic:equal value="true" name="hibetsuShiftBean" property="boolTime19">
                          <% // 出勤予定の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center" bgcolor="LightPink">
                              <logic:empty name="hibetsuShiftBean" property="strTime19" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime19" >

                                <bean:write name="hibetsuShiftBean" property="strTime19"/>：

                                <logic:equal value="出勤" name="hibetsuShiftBean" property="strTime19">
                                  <bean:write name="hibetsuShiftBean" property="startTime"/>
                                  &#xFF5E;
                                  <bean:write name="hibetsuShiftBean" property="endTime"/>
                                  <br><bean:write name="hibetsuShiftBean" property="breakTime"/>
                                </logic:equal>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                          <logic:equal value="false" name="hibetsuShiftBean" property="boolTime19">
                          <% // 出勤予定外の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                              <logic:empty name="hibetsuShiftBean" property="strTime19" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime19" >
                                <bean:write name="hibetsuShiftBean" property="strTime19"/>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                        </logic:iterate>
                      </tr>

                      <tr height="<%=trHeight %>px">
                        <logic:iterate id="hibetsuShiftBean" name="hibetsuShiftForm" property="hibetsuShiftBeanList">
                          <logic:equal value="true" name="hibetsuShiftBean" property="boolTime20">
                          <% // 出勤予定の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center" bgcolor="LightPink">
                              <logic:empty name="hibetsuShiftBean" property="strTime20" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime20" >

                                <bean:write name="hibetsuShiftBean" property="strTime20"/>：

                                <logic:equal value="出勤" name="hibetsuShiftBean" property="strTime20">
                                  <bean:write name="hibetsuShiftBean" property="startTime"/>
                                  &#xFF5E;
                                  <bean:write name="hibetsuShiftBean" property="endTime"/>
                                  <br><bean:write name="hibetsuShiftBean" property="breakTime"/>
                                </logic:equal>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                          <logic:equal value="false" name="hibetsuShiftBean" property="boolTime20">
                          <% // 出勤予定外の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                              <logic:empty name="hibetsuShiftBean" property="strTime20" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime20" >
                                <bean:write name="hibetsuShiftBean" property="strTime20"/>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                        </logic:iterate>
                      </tr>

                      <tr height="<%=trHeight %>px">
                        <logic:iterate id="hibetsuShiftBean" name="hibetsuShiftForm" property="hibetsuShiftBeanList">
                          <logic:equal value="true" name="hibetsuShiftBean" property="boolTime21">
                          <% // 出勤予定の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center" bgcolor="LightPink">
                              <logic:empty name="hibetsuShiftBean" property="strTime21" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime21" >

                                <bean:write name="hibetsuShiftBean" property="strTime21"/>：

                                <logic:equal value="出勤" name="hibetsuShiftBean" property="strTime21">
                                  <bean:write name="hibetsuShiftBean" property="startTime"/>
                                  &#xFF5E;
                                  <bean:write name="hibetsuShiftBean" property="endTime"/>
                                  <br><bean:write name="hibetsuShiftBean" property="breakTime"/>
                                </logic:equal>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                          <logic:equal value="false" name="hibetsuShiftBean" property="boolTime21">
                          <% // 出勤予定外の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                              <logic:empty name="hibetsuShiftBean" property="strTime21" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime21" >
                                <bean:write name="hibetsuShiftBean" property="strTime21"/>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                        </logic:iterate>
                      </tr>

                      <tr height="<%=trHeight %>px">
                        <logic:iterate id="hibetsuShiftBean" name="hibetsuShiftForm" property="hibetsuShiftBeanList">
                          <logic:equal value="true" name="hibetsuShiftBean" property="boolTime22">
                          <% // 出勤予定の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center" bgcolor="LightPink">
                              <logic:empty name="hibetsuShiftBean" property="strTime22" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime22" >

                                <bean:write name="hibetsuShiftBean" property="strTime22"/>：

                                <logic:equal value="出勤" name="hibetsuShiftBean" property="strTime22">
                                  <bean:write name="hibetsuShiftBean" property="startTime"/>
                                  &#xFF5E;
                                  <bean:write name="hibetsuShiftBean" property="endTime"/>
                                  <br><bean:write name="hibetsuShiftBean" property="breakTime"/>
                                </logic:equal>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                          <logic:equal value="false" name="hibetsuShiftBean" property="boolTime22">
                          <% // 出勤予定外の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                              <logic:empty name="hibetsuShiftBean" property="strTime22" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime22" >
                                <bean:write name="hibetsuShiftBean" property="strTime22"/>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                        </logic:iterate>
                      </tr>

                      <tr height="<%=trHeight %>px">
                        <logic:iterate id="hibetsuShiftBean" name="hibetsuShiftForm" property="hibetsuShiftBeanList">
                          <logic:equal value="true" name="hibetsuShiftBean" property="boolTime23">
                          <% // 出勤予定の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center" bgcolor="LightPink">
                              <logic:empty name="hibetsuShiftBean" property="strTime23" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime23" >

                                <bean:write name="hibetsuShiftBean" property="strTime23"/>：

                                <logic:equal value="出勤" name="hibetsuShiftBean" property="strTime23">
                                  <bean:write name="hibetsuShiftBean" property="startTime"/>
                                  &#xFF5E;
                                  <bean:write name="hibetsuShiftBean" property="endTime"/>
                                  <br><bean:write name="hibetsuShiftBean" property="breakTime"/>
                                </logic:equal>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                          <logic:equal value="false" name="hibetsuShiftBean" property="boolTime23">
                            <% // 出勤予定外の時間帯 %>
                            <td width="<%=tdWidth %>px" nowrap="nowrap" align="center">
                              <logic:empty name="hibetsuShiftBean" property="strTime23" >
                                <br>
                              </logic:empty>
                              <logic:notEmpty name="hibetsuShiftBean" property="strTime23" >
                                <bean:write name="hibetsuShiftBean" property="strTime23"/>
                              </logic:notEmpty>
                            </td>
                          </logic:equal>
                        </logic:iterate>
                      </tr>
                    </table>
                  </div>
                </td>
              </tr>
            </table> -->
            <!-- テーブルズレている修正（リン）
            新コード -->
            <table border="0" cellpadding="0" cellspacing="0">
              <tbody><tr>
                <td width="180px">
                  <div id="headLeftTbl" style="overflow-x: hidden;overflow-y: hidden;width: 180px;">
                    <table border="1" cellpadding="0" cellspacing="0" class="tblHeader">
                      <tbody><tr>
                        <td width="180px" nowrap="nowrap" align="center">
                        時間
                        </td>
                      </tr>
                    </tbody></table>
                  </div>
                </td>
                <td width="100%" valign="top">
                  <div id="headRightTbl" style="overflow-y: scroll;overflow-x: hidden;width: 320px; ">
                    <table border="1" cellpadding="0" cellspacing="0" class="tblHeader">
                      <tbody><tr>
                        
                          <td width="150px" nowrap="nowrap" align="center">
                            社員2<br>
                          </td>
                        
                          <td width="150px" nowrap="nowrap" align="center">
                            社員3<br>
                          </td>
                        
                      </tr>
                    </tbody></table>
                  </div>
                </td>
              </tr>
            <tr height="100%">
                <td valign="top">
                  <div id="bodyLeftTbl" style="overflow-x:hidden;overflow-y: hidden;width: 180px;height:450px; ">
                    <table border="1" cellpadding="0" cellspacing="0" class="tblBody">
                      <tbody><tr height="50px">
                        <td width="180px" nowrap="nowrap" align="center">
                        ００：００～０１：００
                        </td>
                      </tr>
                      <tr height="50px">
                        <td width="“180px”" nowrap="nowrap" align="center">
                        ０１：００～０２：００
                        </td>
                      </tr>
                      <tr height="50px">
                        <td width="“180px”" nowrap="nowrap" align="center">
                        ０２：００～０３：００
                        </td>
                      </tr>
                      <tr height="50px">
                        <td width="“180px”" nowrap="nowrap" align="center">
                        ０３：００～０４：００
                        </td>
                      </tr>
                      <tr height="50px">
                        <td width="“180px”" nowrap="nowrap" align="center">
                        ０４：００～０５：００
                        </td>
                      </tr>
                      <tr height="50px">
                        <td width="“180px”" nowrap="nowrap" align="center">
                        ０５：００～０６：００
                        </td>
                      </tr>
                      <tr height="50px">
                        <td width="“180px”" nowrap="nowrap" align="center">
                        ０６：００～０７：００
                        </td>
                      </tr>
                      <tr height="50px">
                        <td width="“180px”" nowrap="nowrap" align="center">
                        ０７：００～０８：００
                        </td>
                      </tr>
                      <tr height="50px">
                        <td width="“180px”" nowrap="nowrap" align="center">
                        ０８：００～０９：００
                        </td>
                      </tr>
                      <tr height="50px">
                        <td width="“180px”" nowrap="nowrap" align="center">
                        ０９：００～１０：００
                        </td>
                      </tr>
                      <tr height="50px">
                        <td width="“180px”" nowrap="nowrap" align="center">
                        １０：００～１１：００
                        </td>
                      </tr>
                      <tr height="50px">
                        <td width="“180px”" nowrap="nowrap" align="center">
                        １１：００～１２：００
                        </td>
                      </tr>
                      <tr height="50px">
                        <td width="“180px”" nowrap="nowrap" align="center">
                        １２：００～１３：００
                        </td>
                      </tr>
                      <tr height="50px">
                        <td width="“180px”" nowrap="nowrap" align="center">
                        １３：００～１４：００
                        </td>
                      </tr>
                      <tr height="50px">
                        <td width="“180px”" nowrap="nowrap" align="center">
                        １４：００～１５：００
                        </td>
                      </tr>
                      <tr height="50px">
                        <td width="“180px”" nowrap="nowrap" align="center">
                        １５：００～１６：００
                        </td>
                      </tr>
                      <tr height="50px">
                        <td width="“180px”" nowrap="nowrap" align="center">
                        １６：００～１７：００
                        </td>
                      </tr>
                      <tr height="50px">
                        <td width="“180px”" nowrap="nowrap" align="center">
                        １７：００～１８：００
                        </td>
                      </tr>
                      <tr height="50px">
                        <td width="“180px”" nowrap="nowrap" align="center">
                        １８：００～１９：００
                        </td>
                      </tr>
                      <tr height="50px">
                        <td width="“180px”" nowrap="nowrap" align="center">
                        １９：００～２０：００
                        </td>
                      </tr>
                      <tr height="50px">
                        <td width="“180px”" nowrap="nowrap" align="center">
                        ２０：００～２１：００
                        </td>
                      </tr>
                      <tr height="50px">
                        <td width="“180px”" nowrap="nowrap" align="center">
                        ２１：００～２２：００
                        </td>
                      </tr>
                      <tr height="50px">
                        <td width="“180px”" nowrap="nowrap" align="center">
                        ２２：００～２３：００
                        </td>
                      </tr>
                      <tr height="50px">
                        <td width="“180px”" nowrap="nowrap" align="center">
                        ２３：００～２４：００
                        </td>
                      </tr>
                    </tbody>
</table>
                  </div>
                </td>
                <td width="100%" valign="top">
                  <div id="bodyRightTbl" style="overflow-x:hidden;overflow-y: auto;width: 320px;height:450px;" onscroll="onScroll();">
                    <table border="1" cellpadding="0" cellspacing="0" class="tblBody">
                      <tbody><tr height="50px">
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                      </tr>
                      <tr height="50px">
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                      </tr>
                      <tr height="50px">
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                      </tr>
                      <tr height="50px">
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                      </tr>
                      <tr height="50px">
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                      </tr>
                      <tr height="50px">
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                      </tr>
                      <tr height="50px">
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                      </tr>
                      <tr height="50px">
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                      </tr>
                      <tr height="50px">
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                      </tr>
                      <tr height="50px">
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                      </tr>
                      <tr height="50px">
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                      </tr>
                      <tr height="50px">
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                      </tr>
                      <tr height="50px">
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                      </tr>
                      <tr height="50px">
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                      </tr>
                      <tr height="50px">
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                      </tr>
                      <tr height="50px">
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                      </tr>
                      <tr height="50px">
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                      </tr>
                      <tr height="50px">
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                      </tr>
                      <tr height="50px">
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                      </tr>
                      <tr height="50px">
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                      </tr>
                      <tr height="50px">
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                      </tr>
                      <tr height="50px">
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                      </tr>
                      <tr height="50px">
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                      </tr>
                      <tr height="50px">
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                            <td width="150px" nowrap="nowrap" align="center">
                                <br>
                            </td>
                      </tr>
                    </tbody></table>
                  </div>
                </td>
              </tr></tbody></table>
          </html:form>
        </div>
      </div>
      <div id="footer">
        <table>
          <tr>
            <td id="footLeft">
              　
            </td>
            <td id="footCenter">
              　
            </td>
            <td id="footRight">
              　
            </td>
          </tr>
        </table>
      </div>
    </div>
  </body>
</html>