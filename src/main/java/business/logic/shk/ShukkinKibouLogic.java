/**
 * ファイル名：ShukkinKibouLogic.java
 *
 * 変更履歴
 * 1.0  2010/10/06 Kazuya.Naraki
 */
package business.logic.shk;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import business.db.dao.shk.ShukkinKibouDao;
import business.db.dao.shk.ShukkinKibouNyuuryokuDao;
import business.dto.LoginUserDto;
import business.dto.shk.ShukkinKibouKakuninDto;
import business.dto.shk.ShukkinKibouNyuuryokuDto;

/**
 * 説明：希望出勤日入力処理のロジック
 * @author naraki
 *
 */
public class ShukkinKibouLogic {


	/**
	 * 出勤希望確認画面に表示するリストを取得する。
	 * 戻り値・・・社員分の希望シフトリストのリスト
	 * @param yearMonth 年月
	 * @return 出勤希望Dtoリストのリスト
	 * @author naraki
	 */
	public List<List<ShukkinKibouKakuninDto>> getShukkinKibouKakuninDtoList(String yearMonth) throws SQLException{

		/* 戻り値 */
		Map<String, List<ShukkinKibouNyuuryokuDto>> ShukkinKibouNyuuryokuDtoMap = new LinkedHashMap<String, List<ShukkinKibouNyuuryokuDto>>();

		// Dao
		ShukkinKibouDao dao = new ShukkinKibouDao();

		// シフト情報を取得する。
		List<List<ShukkinKibouKakuninDto>> kakuninDtoListList = dao.getShiftTblListList(yearMonth);

		return kakuninDtoListList;
	}
	public Map<String,List<ShukkinKibouNyuuryokuDto>> getShukkinKibouNyuuryokuDtoMap(String yearMonth, boolean shiftFlg) throws SQLException{
		/* 戻り値 */
		Map<String, List<ShukkinKibouNyuuryokuDto>> ShukkinKibouNyuuryokuDtoMap = new LinkedHashMap<String, List<ShukkinKibouNyuuryokuDto>>();
		// Dao
		ShukkinKibouNyuuryokuDao dao = new ShukkinKibouNyuuryokuDao();

		// シフト情報を取得する。
		List<ShukkinKibouNyuuryokuDto> ShukkinKibouNyuuryokuDtoList = dao.getShiftTblData(yearMonth, shiftFlg);

		String oldShainId = "";

		// 一時領域
		List<ShukkinKibouNyuuryokuDto> tmpList = new ArrayList<ShukkinKibouNyuuryokuDto>();
		return ShukkinKibouNyuuryokuDtoMap;

	}
	
    public void registKibouNyuuryoku(List<List<ShukkinKibouNyuuryokuDto>> KibouNyuuryokuDtoListList, LoginUserDto loginUserDto) throws SQLException {

        // Dao
        ShukkinKibouNyuuryokuDao dao = new ShukkinKibouNyuuryokuDao();
        // コネクション
        Connection connection = dao.getConnection();

        // トランザクション処理
        connection.setAutoCommit(false);

        try {
            for (List<ShukkinKibouNyuuryokuDto> KibouNyuuryokuDtoList : KibouNyuuryokuDtoListList) {
                // 人数分のループ
                for (ShukkinKibouNyuuryokuDto KibouNyuuryokuDto : KibouNyuuryokuDtoList) {
                    // 日数分ループ

                    // 社員ID
                    String shainId = KibouNyuuryokuDto.getShainId();
                    // 対象年月
                    String yearMonthDay = KibouNyuuryokuDto.getYearMonthDay();

                    // レコードの存在を確認する
                    boolean isData = dao.isData(shainId, yearMonthDay);

                    if (isData) {
                        // 更新
                        dao.updateShiftTbl(KibouNyuuryokuDto, loginUserDto);
                    } else {
                        // 登録
                        dao.registShiftTbl(KibouNyuuryokuDto, loginUserDto);
                    }

                }
            }

        } catch (SQLException e) {
            // ロールバック処理
            connection.rollback();
            // 切断
            connection.close();

            throw e;
        }

        // コミット
        connection.commit();
        // 切断
        connection.close();

    }
}
