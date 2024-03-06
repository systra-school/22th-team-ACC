/**
 * ファイル名：ShukkinKibouNyuuryokuDao.java
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
import business.dto.LoginUserDto;
import business.dto.shk.ShukkinKibouNyuuryokuDto;
import constant.DbConstant.M_shain;
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
			 strSql.append("    TSHIFT.KIBOU_SHIFT_ID , ");
			 strSql.append("    TSHIFT.YEAR_MONTH_DAY, ");
			 

			 if (shiftFlg) {
			     strSql.append("    TSHIFT.SHIFT_ID AS SHIFT_ID, ");
			 } else {
			     strSql.append("    TSHIFT.KIBOU_SHIFT_ID AS SHIFT_ID, ");
			 }

			 strSql.append("(SELECT M.SYMBOL FROM M_SHIFT M WHERE M.SHIFT_ID = TSHIFT.SHIFT_ID) AS SYMBOL ");
			 strSql.append("FROM ");
			 strSql.append("    M_SHAIN MSHAIN LEFT OUTER JOIN  ");
			 strSql.append("    (SELECT * FROM T_SHIFT WHERE SUBSTRING(YEAR_MONTH_DAY, 1, 6) = ?) TSHIFT ON MSHAIN.SHAIN_ID = TSHIFT.SHAIN_ID ");
			 strSql.append("ORDER BY ");
			 strSql.append("    MSHAIN.SHAIN_ID, ");
			 strSql.append("    TSHIFT.YEAR_MONTH_DAY ");
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
                dto.setYearMonthDay(rs.getString(T_Shift.YEAR_MONTH_DAY.getName()));
                dto.setKibouShiftId(rs.getString(T_Shift.KIBOU_SHIFT_ID.getName()));
                

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
	

    public void updateKibouShiftTbl(ShukkinKibouNyuuryokuDto KibouNyuuryokuDto, LoginUserDto loginUserDto) throws SQLException{

        try {

            StringBuffer strSql = new StringBuffer();
            strSql.append("UPDATE ");
            strSql.append("T_SHIFT ");
            strSql.append("SET ");
            strSql.append("KIBOU_SHIFT_ID = ?, ");
            strSql.append("UPDATE_SHAIN_ID = ?, ");
            strSql.append("UPDATE_DT = current_timestamp() ");
            strSql.append("WHERE ");
            strSql.append("SHAIN_ID = ? ");
            strSql.append("AND ");
            strSql.append("YEAR_MONTH_DAY = ? ");

            PreparedStatement ps = connection.prepareStatement(strSql.toString());

            ps.setString(1, KibouNyuuryokuDto.getKibouShiftId());
            ps.setString(2, loginUserDto.getShainId());
            ps.setString(3, KibouNyuuryokuDto.getShainId());
            ps.setString(4, KibouNyuuryokuDto.getYearMonthDay());

            // ログ出力
            log.info(ps);

            // SQLを実行する
            ps.executeUpdate();

        } catch (SQLException e) {
            // 例外発生
            throw e;
        }
    }

    public boolean isData(String shainId, String yearMonthDay) throws SQLException {
        try {
            StringBuffer strSql = new StringBuffer();
            strSql.append("SELECT ");
            strSql.append("    * ");
            strSql.append("FROM ");
            strSql.append("    T_SHIFT ");
            strSql.append("WHERE ");
            strSql.append("    SHAIN_ID = ? AND ");
            strSql.append("    YEAR_MONTH_DAY = ? ");


            PreparedStatement ps = connection.prepareStatement(strSql.toString());

            ps.setString(1, shainId);
            ps.setString(2, yearMonthDay);

            // ログ出力
            log.info(ps);

            // 実行
            ResultSet rs = ps.executeQuery();

            // 取得結果セット
            if (rs.next()) {
                return true;
            } else {
                return false;
            }
        } catch (SQLException e) {
            // 例外発生
            throw e;
        }
    }
    public void registKibouShiftTbl(ShukkinKibouNyuuryokuDto kibouNyuuryokuDto, LoginUserDto loginUserDto) throws SQLException{

        try {

            StringBuffer strSql = new StringBuffer();
            strSql.append("INSERT INTO ");
            strSql.append("T_SHIFT ");
            strSql.append(" ( ");
            strSql.append("SHAIN_ID,");
            strSql.append("YEAR_MONTH_DAY,");
            strSql.append("KIBOU_SHIFT_ID,");
            strSql.append("CREATE_SHAIN_ID,");
            strSql.append("CREATE_DT,");
            strSql.append("UPDATE_SHAIN_ID,");
            strSql.append("UPDATE_DT");
            strSql.append(") ");
            strSql.append("VALUES ");
            strSql.append(" ( ");
            strSql.append("? ");
            strSql.append(",? ");
            strSql.append(",? ");
            strSql.append(",? ");
            strSql.append(", current_timestamp()");
            strSql.append(",? ");
            strSql.append(", current_timestamp()");
            strSql.append(") ");

            PreparedStatement ps = connection.prepareStatement(strSql.toString());

            ps.setString(1, kibouNyuuryokuDto.getShainId());
            ps.setString(2, kibouNyuuryokuDto.getYearMonthDay());
            ps.setString(3, kibouNyuuryokuDto.getKibouShiftId());
            ps.setString(4, loginUserDto.getShainId());
            ps.setString(5, loginUserDto.getShainId());

            // ログ出力
            log.info(ps);

            // SQLを実行する
            ps.executeUpdate();

        } catch (SQLException e) {
            // 例外発生
            throw e;
        }
    }

}
