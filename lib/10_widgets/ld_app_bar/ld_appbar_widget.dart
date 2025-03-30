// Widget d'appbar per a l'aplicació.
// CreatedAt: 2025/03/23 dg. JIQ

import 'package:flutter/material.dart';
import 'package:ld_wbench4/03_core/ld_widget.dart';
import 'package:ld_wbench4/07_models/ld_model.dart';
import 'package:ld_wbench4/08_streams/ld_stream_envelope.dart';
import 'package:ld_wbench4/10_widgets/ld_app_bar/ld_appbar_ctrl.dart';
import 'package:ld_wbench4/10_widgets/ld_app_bar/ld_appbar_state.dart';

export 'ld_appbar_ctrl.dart';
export 'ld_appbar_state.dart';

class   LdAppbar
extends LdWidget {
  // 📝 ESTÀTICS -----------------------

  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdAppbar({
    super.key,
    required super.pTag,
    required super.pView,
    required String pTitle,
    String?  pSubtitle,
    Widget?  pDrawer,
    Widget?  pEndDrawer,
  }): super(
    pState: LdAppbarState(
      pTag: pTag,
      pTitle: pTitle,
      pSubtitle: pSubtitle,
    ),
    pCtrl: LdAppbarCtrl(
      pTag: pTag,
      pView: pView,
    ),
  ) {
    state.ctrl = ctrl;
    ctrl.state = state;
  }
  
  // 🌥️ 'LdWidget' --------------------
  @override
  void listen(LdStreamEnvelope<LdModel> pEnv) {
  }

  @override
  void onError() {}
  
  @override
  void onDone()  {}

  @override
  Widget build(BuildContext pBCtx) {
    throw UnimplementedError();
  }

  // 'LdTagIntf' ----------------------
  @override
  String get baseTag => "LdAppbar";
}