/**
 * ファイル名：TsukibetsuShiftNyuuryokuAbstractAction.java
 *
 * 変更履歴
 * 1.0  2010/09/04 Kazuya.Naraki
 */
package action.mth;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts.action.Action;

/**
 * 説明：月別シフト入力抽象クラス
 * @author naraki
 */
public abstract class TsukibetsuShiftNyuuryokuAbstractAction extends Action{

    // ログ出力クラス
    protected Log log = LogFactory.getLog(this.getClass());

    // 表示データ数
    protected final int SHOW_LENGTH =16; //16->12変更（リン）

}
