//
// CreatedAt: 2025/03/23 dg. JIQ

import 'package:ld_wbench4/03_core/ld_widget.dart';
import 'package:ld_wbench4/08_streams/ld_stream_envelope.dart';
import 'package:ld_wbench4/10_widgets/ld_app_bar/ld_appbar_widget.dart';

class LdAppbarState 
extends LdWidgetState<LdStreamEnvelope, LdAppbarCtrl, LdAppbarState> {
  // 📝 ESTÀTICS -----------------------
  static const String className = "LdAppbarState";
  
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
    emitData(pSrcTag: tag, pTgtTag: tag);
  }

  // 🌥️ 'LdWidgetState' -------------
  @override
  Future<LdStreamEnvelope?> dataProcess({ String? pSrcTag, String? pTgtTag }) {
    throw UnimplementedError();
  }
  
  @override
  String get baseTag => "LdAppbarState";
}
