//
// CreatedAt: 2025/03/23 dg. CLA[JIQ].

import 'package:ld_wbench4/03_core/ld_widget_state.dart';
import 'package:ld_wbench4/08_streams/ld_stream_envelope.dart';
import 'package:ld_wbench4/10_widgets/ld_scaffold/ld_scaffold_widget.dart';

class LdScaffoldState
extends LdWidgetState<LdStreamEnvelope, LdScaffoldCtrl, LdScaffoldState> {
  // 📝 ESTÀTICS -----------------------
  static const String className = "LdScaffoldState";

  // 🧩 MEMBRES ------------------------
  String _title;
  String? _subTitle;

  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdScaffoldState({
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
  String get title => _title;
  String? get subTitle => _subTitle;

  // 🌥️ 'LdWidgetState' -------------
  @override
  Future<LdStreamEnvelope?> dataProcess({ String? pSrcTag, String? pTgtTag }) {
    throw UnimplementedError();
  }
  
  // 🌥️ 'LdTagIntf' -------------------
  @override
  String get baseTag => "LdScaffoldState";
}
