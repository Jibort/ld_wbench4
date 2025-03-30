// abstracció de l'estat de dades d'una vista.
// CreatedAt: 2025/03/18 dt. 

import 'package:ld_wbench4/03_core/ld_state.dart';
import 'package:ld_wbench4/03_core/ld_view.dart';
import 'package:ld_wbench4/08_streams/ld_stream_envelope.dart';

abstract class LdViewState<
  T extends LdStreamEnvelope,
  C extends LdViewCtrl<T, dynamic, dynamic>,
  V extends LdView<T, dynamic>
> extends LdState<T, C> {
  // 📝 ESTÀTICS -----------------------
  
  // 🧩 MEMBRES ------------------------
  String  _title;
  String? _subTitle;

  // 📥 GETTERS/SETTERS ----------------
  String  get title    => _title;
  String? get subTitle => _subTitle;
  void setTitles(String pTitle, String pSubtitle) {
    _title = pTitle;
    _subTitle = pSubtitle;
    emitData(pSrcTag: tag, pTgtTag: ctrl.tag);
  }

  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdViewState({ required String pTitle, String? pSubtitle, super.pTag })
  : _title = pTitle,
    _subTitle = pSubtitle;

  @override
  void dispose() {
    super.dispose();
  }
}