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

public class ShukkinkibouNyuuryokuSearchAction extends ShukkinKibouAbstractAction{
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest req, HttpServletResponse res) throws Exception {

		log.info(new Throwable().getStackTrace()[0].getMethodName());

		/* フォワードキー */
		String forward = CommonConstant.SUCCESS;
		// セッション
		HttpSession session = req.getSession();

		// ログインユーザ情報をセッションより取得
		LoginUserDto loginUserDto = (LoginUserDto) session.getAttribute(RequestSessionNameConstant.SESSION_CMN_LOGIN_USER_INFO);

		// フォーム
		ShukkinKibouNyuuryokuForm kibouNyuuryokuForm = (ShukkinKibouNyuuryokuForm) form;

		// 対象年月
		String yearMonth = kibouNyuuryokuForm.getYearMonth();

		// ロジック生成
		ShukkinKibouLogic kibouSyuukinLogic = new ShukkinKibouLogic();

		// 対象年月の月情報を取得する。
		List<DateBean> dateBeanList = CommonUtils.getDateBeanList(yearMonth);

		// 出勤希望日を取得する
		Map<String,List<ShukkinKibouNyuuryokuDto>> kibouNyuuryokuDtoMap = kibouSyuukinLogic.getShukkinKibouNyuuryokuDtoMap(yearMonth, true);

		List<ShukkinKibouNyuuryokuBean> kibouNyuuryokuBeanList = new ArrayList<ShukkinKibouNyuuryokuBean>();

		// セレクトボックスの取得
		ComboListUtilLogic comboListUtils = new ComboListUtilLogic();
		Map<String, String> shiftCmbMap = comboListUtils.getComboShift(true);
		Map<String, String> yearMonthCmbMap = comboListUtils.getComboYearMonth(CommonUtils.getFisicalDay(CommonConstant.yearMonthNoSl), 3, ComboListUtilLogic.KBN_YEARMONTH_NEXT, false);

		if (CheckUtils.isEmpty(kibouNyuuryokuDtoMap)) {
			// データなし
			ShukkinKibouNyuuryokuBean kibouNyuuryokuBean = new ShukkinKibouNyuuryokuBean();
			kibouNyuuryokuBean.setShainId(loginUserDto.getShainId());
			kibouNyuuryokuBean.setShainName(loginUserDto.getShainName());
			kibouNyuuryokuBean.setRegistFlg(true);

			kibouNyuuryokuBeanList.add(kibouNyuuryokuBean);
		} else {
			// データあり
			kibouNyuuryokuBeanList = dtoToBean(kibouNyuuryokuDtoMap, loginUserDto);
		}

		// フォームにデータをセットする
		kibouNyuuryokuForm.setShiftCmbMap(shiftCmbMap);
		kibouNyuuryokuForm.setYearMonthCmbMap(yearMonthCmbMap);
		kibouNyuuryokuForm.setShukkinKibouNyuuryokuBeanList(kibouNyuuryokuBeanList);
		kibouNyuuryokuForm.setDateBeanList(dateBeanList);
		kibouNyuuryokuForm.setYearMonth(yearMonth);

		return mapping.findForward(forward);
	}
	
	
	private List<ShukkinKibouNyuuryokuBean> dtoToBean(Map<String, List<ShukkinKibouNyuuryokuDto>> ShukkinKibouNyuuryokuDtoMap
			, LoginUserDto loginUserDto)
					throws IllegalArgumentException,
					IllegalAccessException,
					InvocationTargetException {
		Collection<List<ShukkinKibouNyuuryokuDto>> collection = ShukkinKibouNyuuryokuDtoMap.values();

		List<ShukkinKibouNyuuryokuBean> kibouNyuuryokuBeanList = new ArrayList<ShukkinKibouNyuuryokuBean>();

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
					methods[i].invoke(kibouNyuuryokuBean, ShukkinKibouNyuuryokuDto.getKibouShiftId());

					shainId = ShukkinKibouNyuuryokuDto.getShainId();

					index ++;
				}
			}

			kibouNyuuryokuBean.setShainId(shainId);
			kibouNyuuryokuBean.setShainName(shainName);
			kibouNyuuryokuBean.setRegistFlg(false);

			kibouNyuuryokuBeanList.add(kibouNyuuryokuBean);

		}

		return kibouNyuuryokuBeanList;
	}
}
