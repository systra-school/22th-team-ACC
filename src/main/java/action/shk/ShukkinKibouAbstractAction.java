/**
 * ファイル名：ShukkinKibouAbstractAction.java
 *
 * 変更履歴
 * 1.0  2010/11/22 Kazuya.Naraki
 */
package action.shk;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts.action.Action;

/**
 * 説明：ログイン処理のロジック
 * @author naraki
 *
 */
public abstract class ShukkinKibouAbstractAction extends Action {
    // ログ出力クラス
    protected Log log = LogFactory.getLog(this.getClass());
    // 表示データ数		3/8 SHOW_LENGTH = 18 → 19へ修正（高橋）
    protected final int SHOW_LENGTH = 19;
}
