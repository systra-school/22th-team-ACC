package action.mth;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import business.dto.LoginUserDto;
import business.dto.bse.KihonShiftDto;
import business.logic.bse.KihonShiftLogic;
import business.logic.comparator.MethodComparator;
import business.logic.utils.CheckUtils;
import business.logic.utils.ComboListUtilLogic;
import business.logic.utils.CommonUtils;
import constant.CommonConstant;
import constant.RequestSessionNameConstant;
import form.common.DateBean;
import form.mth.TsukibetsuShiftNyuuryokuBean;
import form.mth.TsukibetsuShiftNyuuryokuForm;

public class TsukibetsuShiftNyuuryokuKihonHaneiAction extends TsukibetsuShiftNyuuryokuAbstractAction {

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest req,
			HttpServletResponse res) throws Exception {

		log.info(new Throwable().getStackTrace()[0].getMethodName());

		// フォワードキー
		String forward = CommonConstant.SUCCESS;

		// セッション
		HttpSession session = req.getSession();

		// ログインユーザー情報をセッションより取得
		LoginUserDto loginUserDto = (LoginUserDto) session
				.getAttribute(RequestSessionNameConstant.SESSION_CMN_LOGIN_USER_INFO);

		// フォーム
		TsukibetsuShiftNyuuryokuForm tsukibetsuShiftForm = (TsukibetsuShiftNyuuryokuForm) form;

		// 対象年月
		String yearMonth = tsukibetsuShiftForm.getYearMonth();
		
		// セレクトボックスの取得
		ComboListUtilLogic comboListUtils = new ComboListUtilLogic();
		Map<String, String> shiftCmbMap = comboListUtils.getComboShift(true);
		Map<String, String> yearMonthCmbMap = comboListUtils.getComboYearMonth(
				CommonUtils.getFisicalDay(CommonConstant.yearMonthNoSl), 3, ComboListUtilLogic.KBN_YEARMONTH_NEXT,
				false);

		// ロジック
		KihonShiftLogic kihonShiftLogic = new KihonShiftLogic();

		// 対象年月の月情報を取得する
		List<DateBean> dateBeanList = CommonUtils.getDateBeanList(yearMonth);

		// 社員分の基本シフトマスターデータを取得する
		Map<String, KihonShiftDto> tsukibetsuShiftDtoMap = kihonShiftLogic.getKihonShiftData();

		// 社員ID、社員名、シンボル01～31、登録フラグを格納したリストを作成
		List<TsukibetsuShiftNyuuryokuBean> tsukibetsuShiftBeanList = getMonthlyData(dateBeanList,
				tsukibetsuShiftDtoMap);

		if (CheckUtils.isEmpty(tsukibetsuShiftDtoMap)) {
			// データなし
			TsukibetsuShiftNyuuryokuBean tsukibetsuShiftBean = new TsukibetsuShiftNyuuryokuBean();
			tsukibetsuShiftBean.setShainId(loginUserDto.getShainId());
			tsukibetsuShiftBean.setShainName(loginUserDto.getShainName());
			tsukibetsuShiftBean.setRegistFlg(true);

			tsukibetsuShiftBeanList.add(tsukibetsuShiftBean);
		} else {
			// データあり
			tsukibetsuShiftBeanList = getMonthlyData(dateBeanList, tsukibetsuShiftDtoMap);
		}

		// フォームにデータをセットする
		tsukibetsuShiftForm.setShiftCmbMap(shiftCmbMap);
		tsukibetsuShiftForm.setYearMonthCmbMap(yearMonthCmbMap);
		tsukibetsuShiftForm.setTsukibetsuShiftNyuuryokuBeanList(tsukibetsuShiftBeanList);
		tsukibetsuShiftForm.setDateBeanList(dateBeanList);
		tsukibetsuShiftForm.setYearMonth(yearMonth);

		// ページング
		tsukibetsuShiftForm.setMaxPage(CommonUtils.getMaxPage(tsukibetsuShiftDtoMap.size(), SHOW_LENGTH));

		return mapping.findForward(forward);

	}

	// 社員ID、社員名、シンボル01～31、登録フラグを格納したリストを返す
	private List<TsukibetsuShiftNyuuryokuBean> getMonthlyData(List<DateBean> dateBeanList,
			Map<String, KihonShiftDto> tsukibetsuShiftDtoMap) throws Exception {
		// 月の初日の曜日を取得
		String youbi = dateBeanList.get(0).getYoubi();

		// 基本シフトデータをもとに配列を作成する
		Map<String, String[]> kihonShiftDataMap = new HashMap<String, String[]>();

		// マップからリストへ変換
		Collection<KihonShiftDto> collection = tsukibetsuShiftDtoMap.values();
		ArrayList<KihonShiftDto> kihonShiftDtoList = new ArrayList<>(collection);

		// 社員名と曜日配列を作成するためのループ
		for (int i = 0; i < kihonShiftDtoList.size(); i++) {

			// 社員名
			String shainName = kihonShiftDtoList.get(i).getShainName();

			// 曜日ごとのシフトIDを配列に設定(土曜～金曜の７日間)
			String[] youbiArray = new String[7];
			youbiArray[0] = kihonShiftDtoList.get(i).getShiftIdOnSaturday();
			youbiArray[1] = kihonShiftDtoList.get(i).getShiftIdOnSunday();
			youbiArray[2] = kihonShiftDtoList.get(i).getShiftIdOnMonday();
			youbiArray[3] = kihonShiftDtoList.get(i).getShiftIdOnTuesday();
			youbiArray[4] = kihonShiftDtoList.get(i).getShiftIdOnWednesday();
			youbiArray[5] = kihonShiftDtoList.get(i).getShiftIdOnThursday();
			youbiArray[6] = kihonShiftDtoList.get(i).getShiftIdOnFriday();

			// 社員名と曜日配列をマップに入れる
			kihonShiftDataMap.put(shainName, youbiArray);
		} // end of for

		// 各社員の基本シフトデータをもとに１か月分のシフトデータを作成する
		// リストを生成
		List<TsukibetsuShiftNyuuryokuBean> tsukibetsuShiftList = new ArrayList<TsukibetsuShiftNyuuryokuBean>();

		String shainId = "";
		String shainName = "";


		// 社員ID、社員名、シンボル01～31、登録フラグをセットする
		// 各社員分回す
		for (int i = 0; i < kihonShiftDtoList.size(); i++) {
			
			// 曜日保存用index
			int index = 0;

			//初日の曜日の判断をする
			switch (youbi) {
			case "土":
				index = 0;
				break;

			case "日":
				index = 1;
				break;

			case "月":
				index = 2;
				break;

			case "火":
				index = 3;
				break;

			case "水":
				index = 4;
				break;

			case "木":
				index = 5;
				break;

			case "金":
				index = 6;
				break;
			default:
				break;
			}
			
			// 最終的に格納するinstanceをnewする
			TsukibetsuShiftNyuuryokuBean tmpBean = new TsukibetsuShiftNyuuryokuBean();

			// 社員
			shainId = kihonShiftDtoList.get(i).getShainId();
			shainName = kihonShiftDtoList.get(i).getShainName();

			// 上の社員の週間シフト
			String[] weeklyshiftId = kihonShiftDataMap.get(shainName);

			//TsukibetsuShiftNyuuryokuBean内のメソッドの取得
			Method[] methods = tmpBean.getClass().getMethods();

			//TsukibetsuShiftNyuuryokuBean内のメソッドのソートを行う
			Comparator<Method> asc = new MethodComparator();
			Arrays.sort(methods, asc);

			/*
			 * 一か月の日数分まわす マップで設定した週間シフトを設定するためのfor 
			 * "setShiftIdXX"をする
			 * "setShiftIdXX"は1～31まである
			 */
			for (int j = 0; j < methods.length; j++) {
				
				//"setShiftId"のみを取り出すためのif
				//上でメソッドのソートを行っているため1～31の順番で実行できる
				if (methods[j].getName().startsWith("setShiftId")) {
					methods[j].invoke(tmpBean, weeklyshiftId[index]);

					index++;

					if (index == 7) {
						index = 0;
					}
				}
			}

			// 社員ID、社員名、登録フラグ(false)をセットする
			tmpBean.setShainId(shainId);
			tmpBean.setShainName(shainName);
			tmpBean.setRegistFlg(false);

			// リストにセットする
			tsukibetsuShiftList.add(tmpBean);
		}
		
		return tsukibetsuShiftList;

	}
}
