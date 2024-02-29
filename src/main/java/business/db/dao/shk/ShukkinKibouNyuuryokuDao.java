/**
 * ファイル名：ShukkinKibouDao.java
 *
 * 変更履歴
 * 1.0  2010/10/06 Kazuya.Naraki
 */
package business.db.dao.shk;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import business.db.dao.AbstractDao;
import business.dto.shk.ShukkinKibouKakuninDto;
import business.dto.shk.ShukkinKibouNyuuryokuDto;
import business.logic.utils.CommonUtils;
import constant.DbConstant.M_shain;
import constant.DbConstant.M_shift;
import constant.DbConstant.T_Shift;

/**
 * 説明：出勤希望処理のDao
 * @author naraki
 *
 */
public class ShukkinKibouNyuuryokuDao extends AbstractDao{

	// ログ出力クラス
	private Log log = LogFactory.getLog(this.getClass());

	/**
	 * シフトテーブルのデータを指定した条件で検索する。
	 * @param shainId 検索対象の社員ID
	 * @param yearMonth 検索対象年月
	 * @return 出勤希望Dtoリスト
	 * @author Kazuya.Naraki
	 */
	public List<ShukkinKibouNyuuryokuDto> getShiftTblData(String yearMonth, boolean shiftFlg) throws SQLException {
		// 戻り値
		List<ShukkinKibouNyuuryokuDto> ShukkinKibouNyuuryokuDtoList = new ArrayList<ShukkinKibouNyuuryokuDto>();


		try {
			// コネクション接続
			this.connect();

			 StringBuffer strSql = new StringBuffer();
	            strSql.append("SELECT ");
	            strSql.append("    MSHAIN.SHAIN_ID, ");
	            strSql.append("    MSHAIN.SHAIN_NAME, ");
	            strSql.append("    TSHIFT.YEAR_MONTH_DAY, ");

	            if (shiftFlg) {
	                strSql.append("    TSHIFT.SHIFT_ID AS SHIFT_ID, ");
	            } else {
	                strSql.append("    TSHIFT.KIBOU_SHIFT_ID AS SHIFT_ID, ");
	            }
	            strSql.append("(SELECT M.SYMBOL FROM M_SHIFT M WHERE M.SHIFT_ID = TSHIFT.SHIFT_ID) AS SYMBOL ");
	            strSql.append("FROM ");
	            strSql.append("    M_SHAIN MSHAIN LEFT OUTER JOIN  ");
	            strSql.append("    (SELECT * FROM T_SHIFT WHERE     SUBSTRING(YEAR_MONTH_DAY, 1, 6) = ?)  ");
	            strSql.append("    TSHIFT ON MSHAIN.SHAIN_ID = TSHIFT.SHAIN_ID ");
	            strSql.append("ORDER BY ");
	            strSql.append("    SHAIN_ID, ");
	            strSql.append("    YEAR_MONTH_DAY ");
			PreparedStatement ps = connection.prepareStatement(strSql.toString());

			ps.setString(1, yearMonth);

			// ログ出力
			log.info(ps);

			// SQLを実行する
			ResultSet rs = ps.executeQuery();

			// 取得結果セット
            while (rs.next()) {
                ShukkinKibouNyuuryokuDto dto = new ShukkinKibouNyuuryokuDto();
                dto.setShainId(rs.getString(M_shain.SHAIN_ID.getName()));
                dto.setShainName(rs.getString(M_shain.SHAIN_NAME.getName()));
                dto.setYearMonthDay(rs.getString(T_Shift.YEAR_MONTH_DAY.getName()));
                dto.setShiftId(rs.getString(T_Shift.SHIFT_ID.getName()));
                dto.setSymbol(rs.getString(M_shift.SYMBOL.getName()));

                ShukkinKibouNyuuryokuDtoList.add(dto);
            }
		} catch (SQLException e) {
			// 例外発生
			throw e;
		} finally {
			// コネクション切断
			disConnect();
		}
		return ShukkinKibouNyuuryokuDtoList;
	}

	/**
	 * 社員分の希望シフトリストのリストを取得する。
	 * @param yearMonth 検索対象年月
	 * @return 出勤希望Dtoリスト
	 * @author Kazuya.Naraki
	 */
	public List<List<ShukkinKibouKakuninDto>> getShiftTblListList(String yearMonth) throws SQLException {
		// 戻り値
		List<List<ShukkinKibouKakuninDto>> shukkinKibouKakuninDtoListList = new ArrayList<List<ShukkinKibouKakuninDto>>();
		List<ShukkinKibouKakuninDto> shukkinKibouKakuninDtoList = new ArrayList<ShukkinKibouKakuninDto>();

		try {
			// コネクション接続
			this.connect();

			StringBuffer strSql = new StringBuffer();
			strSql.append("SELECT ");
			strSql.append("MSHAIN.SHAIN_ID, ");
			strSql.append("MSHAIN.SHAIN_NAME, ");
			strSql.append("TSHIFT.YEAR_MONTH_DAY, ");
			strSql.append("TSHIFT.KIBOU_SHIFT_ID, ");
			strSql.append("TSHIFT.SYMBOL ");
			strSql.append("FROM ");
			strSql.append("M_SHAIN MSHAIN ");
			strSql.append("LEFT OUTER JOIN ");
			strSql.append("(SELECT ");
			strSql.append("SHAIN_ID, ");
			strSql.append("KIBOU_SHIFT_ID, ");
			strSql.append("MSHIFT.SYMBOL, ");
			strSql.append("YEAR_MONTH_DAY ");
			strSql.append("FROM ");
			strSql.append("T_SHIFT TSHIFT RIGHT OUTER JOIN ");
			strSql.append("M_SHIFT MSHIFT ON ");
			strSql.append("TSHIFT.KIBOU_SHIFT_ID = ");
			strSql.append("MSHIFT.SHIFT_ID ");
			strSql.append("WHERE ");
			strSql.append("SUBSTRING(YEAR_MONTH_DAY, 1, 6) = ?) TSHIFT  ON ");
			strSql.append("MSHAIN.SHAIN_ID = TSHIFT.SHAIN_ID ");
			strSql.append("ORDER BY ");
			strSql.append("SHAIN_ID,");
			strSql.append("YEAR_MONTH_DAY");

			PreparedStatement ps = connection.prepareStatement(strSql.toString());

			ps.setString(1, yearMonth);

			// ログ出力
			log.info(ps);

			// SQLを実行する
			ResultSet rs = ps.executeQuery();

			String shainId = "";

			// 取得結果セット
			while (rs.next()) {

				ShukkinKibouKakuninDto dto = new ShukkinKibouKakuninDto();
				String newShainId = rs.getString(M_shain.SHAIN_ID.getName());
				if ("".equals(shainId)) {
					// 初回
					shainId = newShainId;
				} else if (newShainId.equals(shainId)) {
					// 同一社員のデータ
					// 特になにもしない
				} else {
					// 別の社員のデータに切り替わる場合

					// 戻り値のリストに前の社員分のリストを追加する。
					shukkinKibouKakuninDtoListList.add(shukkinKibouKakuninDtoList);

					// 比較対象を入れ替える。
					shainId = newShainId;

					shukkinKibouKakuninDtoList = new ArrayList<ShukkinKibouKakuninDto>();

				}

				dto.setShainId(newShainId);
				dto.setShainName(rs.getString(M_shain.SHAIN_NAME.getName()));
				dto.setYearMonthDay(rs.getString(T_Shift.YEAR_MONTH_DAY.getName()));
				dto.setKibouShiftId(rs.getString(T_Shift.KIBOU_SHIFT_ID.getName()));
				dto.setKibouShiftSymbol(CommonUtils.changeNullToHyphen(rs.getString(M_shift.SYMBOL.getName())));
				// 取得した値を戻り値のリストにセットする。
				shukkinKibouKakuninDtoList.add(dto);
			}
		} catch (SQLException e) {
			// 例外発生
			throw e;
		} finally {
			// コネクション切断
			disConnect();
		}

		// 最後の社員分のリストを追加する
		shukkinKibouKakuninDtoListList.add(shukkinKibouKakuninDtoList);

		return shukkinKibouKakuninDtoListList;
	}

}
