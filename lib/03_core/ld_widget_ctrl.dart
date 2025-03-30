// Abstracció del controlador d'una vista.
// CreatedAt: 2025/03/18 dt. 

import 'package:flutter/material.dart';
import 'package:ld_wbench4/03_core/ld_ctrl.dart';
import 'package:ld_wbench4/03_core/ld_view.dart';
import 'package:ld_wbench4/03_core/ld_widget.dart';
import 'package:ld_wbench4/08_streams/ld_stream_envelope.dart';

abstract class LdWidgetCtrl<
  T  extends LdStreamEnvelope,
  V  extends StatefulWidget,
  WC extends LdWidgetCtrl<T, V, WC, WS>,
  WS extends LdWidgetState<T, WC, WS>
>
extends LdCtrl<T, V, WS> {
  // 📝 ESTÀTICS -----------------------
  
  // 🧩 MEMBRES ------------------------
  final LdView _view;

  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdWidgetCtrl({
    required super.pTag,
    required LdView pView,
  }): _view = pView;

  @override  
  void dispose() {
    super.dispose();
  }
  
  // 📥 GETTERS/SETTERS ----------------
  LdView get view => _view;

}