//
// CreatedAt: 2025/03/23 dg. JIQ

import 'package:flutter/widgets.dart';
import 'package:ld_wbench4/03_core/ld_widget.dart';
import 'package:ld_wbench4/08_streams/ld_stream_envelope.dart';
import 'package:ld_wbench4/10_widgets/ld_app_bar/ld_appbar_state.dart';

class LdAppbarCtrl 
extends LdWidgetCtrl<LdStreamEnvelope, LdAppbarCtrl, LdAppbarState> {
  // 📝 ESTÀTICS -----------------------
  static const String className = "LdAppbarCtrl";
  
  // 🧩 MEMBRES ------------------------
  Widget? drawer;
  Widget? endDrawer;

  LdAppbarCtrl({
    required super.pTag, 
    required super.pView
  });
    
  // 🌥️ 'LdCtrl' ----------------------
  @override
  Widget build(BuildContext pBCtx) {
    return Container();
  }
  
  @override
  String get baseTag => "LdAppbarCtrl";
  
}