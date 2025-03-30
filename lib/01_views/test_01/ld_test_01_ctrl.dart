// Controlador de la vista de proves 'Test_01'.
// CreatedAt: 2025/03/19 dc. JIQ

import 'package:flutter/material.dart';
import 'package:ld_wbench4/01_views/test_01/ld_test_01_state.dart';
import 'package:ld_wbench4/03_core/ld_tag_interface.dart';
import 'package:ld_wbench4/03_core/ld_view.dart';
import 'package:ld_wbench4/08_streams/ld_stream_envelope.dart';

class LdTest01Ctrl<T extends LdStreamEnvelope, V extends StatefulWidget>
extends LdViewCtrl<T, V, LdTest01Ctrl<T, V>, LdTest01State<T>>
implements LdTagIntf {
  // 📝 ESTÀTICS -----------------------
  
  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdTest01Ctrl(String? pTag): super(pTag: pTag);

  @override  
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext pBCtx) {
    return Container();
  }
  
  // 🌥️ 'LdTagIntf' -------------------
  @override
  String get baseTag => "LdTest01Ctrl";
}