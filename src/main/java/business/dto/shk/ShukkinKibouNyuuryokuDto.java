/**
 * ファイル名：ShukkinKibouNyuuryokuDto.java
 *
 * 変更履歴
 * 1.0  2010/10/06 Kazuya.Naraki
 */
package business.dto.shk;

/**
 * 説明：出勤希望日入力Dto
 * @author naraki
 *
 */
public class ShukkinKibouNyuuryokuDto {
    /** 社員ID */
    private String shainId;
	/* 社員名 */
    private String shainName;
    /** 年月日 */
    private String yearMonthDay;
    /** 希望シフト */
    private String kibouShiftId;
    /** 登録フラグ */
    private boolean registFlg;
    /** シフトID */
    private String shiftId;
    /** シンボル */
    private String symbol;


    /**
     * @return shainId
     */
    public String getShainId() {
        return shainId;
    }
    /**
     * @param shainId をセットする
     */
    public void setShainId(String shainId) {
        this.shainId = shainId;
    }
    /**
     * @return yearMonthDay
     */
    public String getYearMonthDay() {
        return yearMonthDay;
    }
    /**
     * @param yearMonthDay をセットする
     */
    public void setYearMonthDay(String yearMonthDay) {
        this.yearMonthDay = yearMonthDay;
    }
    /**
     * @return kibouShiftId
     */
    public String getKibouShiftId() {
        return kibouShiftId;
    }
    /**
     * @param kibouShiftId をセットする
     */
    public void setKibouShiftId(String kibouShiftId) {
        this.kibouShiftId = kibouShiftId;
    }
    /**
     * @return registFlg
     */
    public boolean getRegistFlg() {
        return registFlg;
    }
    /**
     * @param registFlg をセットする
     */
    public void setRegistFlg(boolean registFlg) {
        this.registFlg = registFlg;
    }
	public String getShiftId() {
		return shiftId;
	}
	public void setShiftId(String shiftId) {
		this.shiftId = shiftId;
	}
	public String getSymbol() {
		return symbol;
	}
	public void setSymbol(String symbol) {
		this.symbol = symbol;
	}
	public String getShainName() {
		return shainName;
	}
	public void setShainName(String shainName) {
		this.shainName = shainName;
	}


}
