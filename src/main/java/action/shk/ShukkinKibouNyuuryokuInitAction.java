package action.shk;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Comparator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import business.dto.LoginUserDto;
import business.dto.shk.ShukkinKibouNyuuryokuDto;
import business.logic.comparator.MethodComparator;
import business.logic.shk.ShukkinKibouLogic;
import business.logic.utils.CheckUtils;
import business.logic.utils.ComboListUtilLogic;
import business.logic.utils.CommonUtils;
import constant.CommonConstant;
import constant.RequestSessionNameConstant;
import form.common.DateBean;
import form.shk.ShukkinKibouNyuuryokuBean;
import form.shk.ShukkinKibouNyuuryokuForm;

/**
 * 説明：月別シフト入力初期表示アクションクラス
 * @author naraki
 */
public class ShukkinKibouNyuuryokuInitAction extends ShukkinKibouAbstractAction{

    /**
     * 説明：月別シフト入力初期表示アクションクラス
     *
     * @param mapping アクションマッピング
     * @param form アクションフォーム
     * @param req リクエスト
     * @param res レスポンス
     * @return アクションフォワード
     * @author naraki
     */
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest req, HttpServletResponse res) throws Exception {

        log.info(new Throwable().getStackTrace()[0].getMethodName());

        // フォワードキー
        String forward = CommonConstant.SUCCESS;

        // セッション
        HttpSession session = req.getSession();

        // ログインユーザ情報をセッションより取得
        LoginUserDto loginUserDto = (LoginUserDto) session.getAttribute(RequestSessionNameConstant.SESSION_CMN_LOGIN_USER_INFO);
        
        // フォーム
        System.out.println(form.getClass().getName());
        ShukkinKibouNyuuryokuForm kibouNyuuryokuForm = (ShukkinKibouNyuuryokuForm) form;
       
        // 対象年月
        String yearMonth = CommonUtils.getFisicalDay(CommonConstant.yearMonthNoSl);

        // ロジック生成
        ShukkinKibouLogic ShukkinKibouLogic = new ShukkinKibouLogic();

        // 対象年月の月情報を取得する。
        List<DateBean> dateBeanList = CommonUtils.getDateBeanList(yearMonth);

        // シフトIDを取得する
        Map<String,List<ShukkinKibouNyuuryokuDto>> KibouNyuuryokuDtoMap = ShukkinKibouLogic.getShukkinKibouNyuuryokuDtoMap(yearMonth, true);

        List<ShukkinKibouNyuuryokuBean> KibouNyuuryokuBeanList = new ArrayList<ShukkinKibouNyuuryokuBean>();

        // セレクトボックスの取得
        ComboListUtilLogic comboListUtils = new ComboListUtilLogic();
        Map<String, String> shiftCmbMap = comboListUtils.getComboShift(true);
        Map<String, String> yearMonthCmbMap = comboListUtils.getComboYearMonth(CommonUtils.getFisicalDay(CommonConstant.yearMonthNoSl), 3, ComboListUtilLogic.KBN_YEARMONTH_NEXT, false);

        if (CheckUtils.isEmpty(KibouNyuuryokuDtoMap)) {
            // データなし
        	ShukkinKibouNyuuryokuBean kibouNyuuryokuBean = new ShukkinKibouNyuuryokuBean();
            kibouNyuuryokuBean.setShainId(loginUserDto.getShainId());
            kibouNyuuryokuBean.setShainName(loginUserDto.getShainName());
            kibouNyuuryokuBean.setRegistFlg(true);

            KibouNyuuryokuBeanList.add(kibouNyuuryokuBean);
        } else {
            // データあり
            KibouNyuuryokuBeanList = dtoToBean(KibouNyuuryokuDtoMap, loginUserDto);
        }

        // フォームにデータをセットする
        kibouNyuuryokuForm.setShiftCmbMap(shiftCmbMap);
        kibouNyuuryokuForm.setYearMonthCmbMap(yearMonthCmbMap);
        kibouNyuuryokuForm.setShukkinKibouNyuuryokuBeanList(KibouNyuuryokuBeanList);
        kibouNyuuryokuForm.setDateBeanList(dateBeanList);
        kibouNyuuryokuForm.setYearMonth(yearMonth);

        return mapping.findForward(forward);
    }

    /**
     * DtoからBeanへ変換する
     * @param KibouNyuuryokuDtoMap
     * @param loginUserDto
     * @return 一覧に表示するリスト
     * @author naraki
     * @throws InvocationTargetException
     * @throws IllegalAccessException
     * @throws IllegalArgumentException
     */
    private List<ShukkinKibouNyuuryokuBean> dtoToBean(Map<String, List<ShukkinKibouNyuuryokuDto>> KibouNyuuryokuDtoMap
                                                      , LoginUserDto loginUserDto)
                                                                        throws IllegalArgumentException,
                                                                        IllegalAccessException,
                                                                        InvocationTargetException {
        Collection<List<ShukkinKibouNyuuryokuDto>> collection = KibouNyuuryokuDtoMap.values();

        List<ShukkinKibouNyuuryokuBean> KibouNyuuryokuBeanList = new ArrayList<ShukkinKibouNyuuryokuBean>();

        for (List<ShukkinKibouNyuuryokuDto> ShukkinKibouNyuuryokuDtoList : collection) {

            // 実行するオブジェクトの生成
            ShukkinKibouNyuuryokuBean kibouNyuuryokuBean = new ShukkinKibouNyuuryokuBean();

            // メソッドの取得
            Method[] methods = kibouNyuuryokuBean.getClass().getMethods();

            // メソッドのソートを行う
            Comparator<Method> asc = new MethodComparator();
            Arrays.sort(methods, asc); // 配列をソート

            int index = 0;
            int listSize = ShukkinKibouNyuuryokuDtoList.size();

            String shainId = "";
            String shainName = "";

            for (int i = 0; i < methods.length; i++) {
                // "setShiftIdXX" のメソッドを動的に実行する
                if (methods[i].getName().startsWith("setShiftId") && listSize > index) {
                    ShukkinKibouNyuuryokuDto ShukkinKibouNyuuryokuDto = ShukkinKibouNyuuryokuDtoList.get(index);
                    // メソッド実行
                    methods[i].invoke(kibouNyuuryokuBean, ShukkinKibouNyuuryokuDto.getShiftId());

                    shainId = ShukkinKibouNyuuryokuDto.getShainId();
                    shainName = ShukkinKibouNyuuryokuDto.getShainName();

                    index ++;
                }
            }

            kibouNyuuryokuBean.setShainId(shainId);
            kibouNyuuryokuBean.setShainName(shainName);
            kibouNyuuryokuBean.setRegistFlg(false);

            KibouNyuuryokuBeanList.add(kibouNyuuryokuBean);

        }

        return KibouNyuuryokuBeanList;
    }
}

