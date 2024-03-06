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

public class ShukinnKibouNyuuryokuRegistAction extends ShukkinKibouAbstractAction{
	/**
     * 説明：月別シフト入力登録アクションクラス
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



        // セッション
        HttpSession session = req.getSession();

        // ログインユーザ情報をセッションより取得
        LoginUserDto loginUserDto = (LoginUserDto) session.getAttribute(RequestSessionNameConstant.SESSION_CMN_LOGIN_USER_INFO);

        // フォーム
        ShukkinKibouNyuuryokuForm KibouNyuuryoku = (ShukkinKibouNyuuryokuForm) form;
        log.info(KibouNyuuryoku);

        // 画面のリスト情報
        List<ShukkinKibouNyuuryokuBean> KibouNyuuryokuBeanList = KibouNyuuryoku.getShukkinKibouNyuuryokuBeanList();

        // 対象年月
        String yearMonth = CommonUtils.getFisicalDay(CommonConstant.yearMonthNoSl);

        // ロジック生成
        ShukkinKibouLogic KibouNyuuryokuLogic = new ShukkinKibouLogic();

        // 対象年月の月情報を取得する。
        List<DateBean> dateBeanList = CommonUtils.getDateBeanList(yearMonth);

        // フォームデータをDtoに変換する
        List<List<ShukkinKibouNyuuryokuDto>> KibouNyuuryokuDtoListList = this.formToDto(KibouNyuuryokuBeanList, dateBeanList);

        // 登録・更新処理
        KibouNyuuryokuLogic.registKibouNyuuryoku(KibouNyuuryokuDtoListList, loginUserDto);

        // シフトIDを取得する
        Map<String,List<ShukkinKibouNyuuryokuDto>> ShukkinKibouNyuuryokuDtoMap = KibouNyuuryokuLogic.getShukkinKibouNyuuryokuDtoMap(yearMonth, true);

        // セレクトボックスの取得
        ComboListUtilLogic comboListUtils = new ComboListUtilLogic();
        Map<String, String> shiftCmbMap = comboListUtils.getComboShift(true);
        Map<String, String> yearMonthCmbMap = comboListUtils.getComboYearMonth(CommonUtils.getFisicalDay(CommonConstant.yearMonthNoSl), 3, ComboListUtilLogic.KBN_YEARMONTH_NEXT, false);

        if (CheckUtils.isEmpty(ShukkinKibouNyuuryokuDtoMap)) {
            // データなし
            ShukkinKibouNyuuryokuBean kibouNyuuryokuBean = new ShukkinKibouNyuuryokuBean();
            kibouNyuuryokuBean.setShainId(loginUserDto.getShainId());
            kibouNyuuryokuBean.setShainName(loginUserDto.getShainName());
            kibouNyuuryokuBean.setRegistFlg(true);

            KibouNyuuryokuBeanList.add(kibouNyuuryokuBean);
        } else {
            // データあり
            KibouNyuuryokuBeanList = dtoToBean(ShukkinKibouNyuuryokuDtoMap, loginUserDto);
        }

        // フォームにデータをセットする
        KibouNyuuryoku.setShiftCmbMap(shiftCmbMap);
        KibouNyuuryoku.setYearMonthCmbMap(yearMonthCmbMap);
        KibouNyuuryoku.setShukkinKibouNyuuryokuBeanList(KibouNyuuryokuBeanList);
        KibouNyuuryoku.setDateBeanList(dateBeanList);
        KibouNyuuryoku.setYearMonth(yearMonth);
        
        // フォワードキー
        String forward = CommonConstant.SUCCESS;

        return mapping.findForward(forward);
    }

    /**
     * DtoからBeanへ変換する
     * @param ShukkinKibouNyuuryokuDtoMap
     * @param loginUserDto
     * @return 一覧に表示するリスト
     * @author naraki
     * @throws InvocationTargetException
     * @throws IllegalAccessException
     * @throws IllegalArgumentException
     */
    private List<ShukkinKibouNyuuryokuBean> dtoToBean(Map<String, List<ShukkinKibouNyuuryokuDto>> ShukkinKibouNyuuryokuDtoMap
                                                      , LoginUserDto loginUserDto)
                                                                        throws IllegalArgumentException,
                                                                        IllegalAccessException,
                                                                        InvocationTargetException {
        Collection<List<ShukkinKibouNyuuryokuDto>> collection = ShukkinKibouNyuuryokuDtoMap.values();

        List<ShukkinKibouNyuuryokuBean> KibouNyuuryokuBeanList = new ArrayList<ShukkinKibouNyuuryokuBean>();

        for (List<ShukkinKibouNyuuryokuDto> ShukkinKibouNyuuryokuDtoList : collection) {

            // 実行するオブジェクトの生成
            ShukkinKibouNyuuryokuBean KibounyuuryokuBean = new ShukkinKibouNyuuryokuBean();

            // メソッドの取得
            Method[] methods = KibounyuuryokuBean.getClass().getMethods();

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
                    methods[i].invoke(KibounyuuryokuBean, ShukkinKibouNyuuryokuDto.getKibouShiftId());

                    shainId = ShukkinKibouNyuuryokuDto.getShainId();

                    index ++;
                }
            }

            KibounyuuryokuBean.setShainId(shainId);
            KibounyuuryokuBean.setShainName(shainName);
            KibounyuuryokuBean.setRegistFlg(false);

            KibouNyuuryokuBeanList.add(KibounyuuryokuBean);

        }

        return KibouNyuuryokuBeanList;
    }

    /**
     * DtoからBeanへ変換する
     * @param KibouNyuuryokuBeanList
     * @return DtoList
     * @author naraki
     * @throws InvocationTargetException
     * @throws IllegalAccessException
     * @throws IllegalArgumentException
     */
    private List<List<ShukkinKibouNyuuryokuDto>> formToDto(List<ShukkinKibouNyuuryokuBean> KibouNyuuryokuBeanList
                                                      , List<DateBean> dateBeanList) throws IllegalArgumentException,
                                                                        IllegalAccessException,
                                                                        InvocationTargetException {
        // 戻り値
        List<List<ShukkinKibouNyuuryokuDto>> KibouNyuuryokuDtoListList = new ArrayList<List<ShukkinKibouNyuuryokuDto>>();

        for (ShukkinKibouNyuuryokuBean ShukkinKibouNyuuryokuBean : KibouNyuuryokuBeanList) {

            List<ShukkinKibouNyuuryokuDto> ShukkinKibouNyuuryokuDtoList = new ArrayList<ShukkinKibouNyuuryokuDto>();

            // 登録フラグ
            boolean registFlg = ShukkinKibouNyuuryokuBean.getRegistFlg();

            if (!registFlg) {
                continue;
            }

            // メソッドの取得
            Method[] methods = ShukkinKibouNyuuryokuBean.getClass().getMethods();

            // ソートを行う
            Comparator<Method> asc = new MethodComparator();
            Arrays.sort(methods, asc); // 配列をソート

            int listSize = dateBeanList.size();

            int index = 0;

            for (int i = 0; i < methods.length; i++) {
                // "getShiftIdXX" のメソッドを動的に実行する
                if (methods[i].getName().startsWith("getShiftId") && index < listSize) {
                    String yearMonthDay = "";

                    // 対象年月取得
                    yearMonthDay = dateBeanList.get(index).getYearMonthDay();

                    ShukkinKibouNyuuryokuDto ShukkinKibouNyuuryokuDto = new ShukkinKibouNyuuryokuDto();
                    String KibouShiftId = (String) methods[i].invoke(ShukkinKibouNyuuryokuBean);

                    if (CommonConstant.BLANK_ID.equals(KibouShiftId)) {
                        // 空白が選択されている場合
                    	KibouShiftId = null;
                    }

                    ShukkinKibouNyuuryokuDto.setKibouShiftId(KibouShiftId);
                    ShukkinKibouNyuuryokuDto.setShainId(ShukkinKibouNyuuryokuBean.getShainId());
                    ShukkinKibouNyuuryokuDto.setYearMonthDay(yearMonthDay);
                    ShukkinKibouNyuuryokuDtoList.add(ShukkinKibouNyuuryokuDto);

                    index++;
                }
            }

            KibouNyuuryokuDtoListList.add(ShukkinKibouNyuuryokuDtoList);

        }

        return KibouNyuuryokuDtoListList;
    }
}
