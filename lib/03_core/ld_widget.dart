// Abstracció d'una vista de l'aplicació.
// CreatedAt: 2025/03/18 dt. JIQ

import 'package:flutter/material.dart';
import 'package:ld_wbench4/03_core/interfaces/ld_tag_intf.dart';
import 'package:ld_wbench4/03_core/ld_view.dart';
import 'package:ld_wbench4/03_core/ld_view_crtl.dart';
import 'package:ld_wbench4/03_core/ld_view_state.dart';
import 'package:ld_wbench4/03_core/ld_widget_crtl.dart';
import 'package:ld_wbench4/03_core/ld_widget_state.dart';
import 'package:ld_wbench4/03_core/mixins/ld_tag_mixin.dart';
import 'package:ld_wbench4/04_manager/injection/ld_binding.dart';
import 'package:ld_wbench4/07_models/ld_model.dart';

/// Abstracció d'una vista de l'aplicació.
abstract class LdWidget<
  FW extends StatefulWidget,
  V  extends LdView<FW, V, VS, VC, W, WS, WC, M>, 
  VS extends LdViewState<FW, V, VS, VC, W, WS, WC, M>,
  VC extends LdViewCtrl<FW, V, VS, VC, M>,
  W  extends LdWidget<FW, V, VS, VC, W, WS, WC, M>, 
  WS extends LdWidgetState<FW, V, VS, VC, W, WS, WC, M>,
  WC extends LdWidgetCtrl<FW, W, WS, WC, M>,
  M  extends LdModel
> 
extends    StatefulWidget
with       LdTagMixin
implements LdTagIntf {
  // 🧩 MEMBRES ------------------------
  final LdView _view;
  final WS     _state;
  late  WC     _ctrl;
  
  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdWidget({ 
    super.key, 
    String? pTag,
    required LdView pView,
    required WS pState })
    : _view = pView,
      _state = pState {
    LdBinding bind = LdBinding.single;
    tag = bind.newCtrlTag(pTag ?? baseTag);
    bind.add(tag, this);
  }
  
  // 📥 GETTERS/SETTERS ----------------
  LdView get view  => _view;
  WS     get state => _state;
  WC     get ctrl  => _ctrl;

  // 🌥️ FUNCIONS ABSTRACTES -----------
  /// Funció per a alliberar recursos de la vista.
  void dispose();
  @override String get baseTag => "LdWidget";
}