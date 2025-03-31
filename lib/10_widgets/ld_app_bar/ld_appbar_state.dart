//
// CreatedAt: 2025/03/23 dg. JIQ

import 'package:ld_wbench4/03b_core/ld_widget.dart';
import 'package:ld_wbench4/07_models/ld_model.dart';
import 'package:ld_wbench4/08_streams/ld_stream_envelope.dart';
import 'package:ld_wbench4/10_widgets/ld_app_bar/ld_appbar_widget.dart';

class LdAppbarState<E extends LdStreamEnvelope<LdModel>>
extends LdWidgetState<LdAppbar, E> {
  // 📝 ESTÀTICS -----------------------
  
  // 🧩 MEMBRES ------------------------
  String  _title;
  String? _subTitle;

  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdAppbarState({
    required super.pTag,
    required String pTitle,
    String? pSubtitle,
  }):
    _title = pTitle,
    _subTitle = pSubtitle;

  @override
  void dispose() {
    super.dispose();
  }

  // 📥 GETTERS/SETTERS ----------------
  String  get title    => _title;
  String? get subTitle => _subTitle;
  void setTitles(String pTitle, String pSubtitle) {
    _title = pTitle;
    _subTitle = pSubtitle;
    emitData(pSrcTag: tag, pTgtTags: [ tag ]);
  }

  // 🌥️ 'LdWidgetState' -------------
  @override
  Future<E> dataProcess({ String? pSrcTag, List<String>? pTgtTags }) {
    throw UnimplementedError();
  }
  
  @override
  String get baseTag => "LdAppbarState";
}
