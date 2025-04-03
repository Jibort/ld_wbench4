// Abstracció d'una vista de l'aplicació.
// CreatedAt: 2025/03/31 dl. CLA[JIQ]

import 'package:flutter/material.dart';
import 'package:ld_wbench4/03_core/interfaces/ld_tag_intf.dart';
import 'package:ld_wbench4/03_core/ld_view_crtl.dart';
import 'package:ld_wbench4/03_core/ld_view_state.dart';
import 'package:ld_wbench4/03_core/ld_widget.dart';
import 'package:ld_wbench4/03_core/ld_widget_crtl.dart';
import 'package:ld_wbench4/03_core/ld_widget_state.dart';
import 'package:ld_wbench4/03_core/mixins/ld_event_emitter_mixin.dart';
import 'package:ld_wbench4/03_core/mixins/ld_event_listener_mixin.dart';
import 'package:ld_wbench4/03_core/mixins/ld_tag_mixin.dart';
import 'package:ld_wbench4/04_manager/injection/ld_binding.dart';
import 'package:ld_wbench4/07_models/ld_model.dart';

/// Abstracció d'una vista de l'aplicació.
abstract class LdView<
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
with       LdTagMixin, LdEventEmitterMixin, LdEventListenerMixin 
implements LdTagIntf {
  // 🧩 MEMBRES ------------------------
  final VS _state;
  late  VC _ctrl;
  String   _title;
  String?  _subtitle;

  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdView({
    super.key,
    String? pTag,
    required String pTitle,
    String? pSubTitle,
    required VS pState })
  : _title    = pTitle,
    _subtitle = pSubTitle,
    _state    = pState
  { LdBinding bind = LdBinding.single;
    tag = bind.newCtrlTag(pTag ?? baseTag);
    bind.add(tag, this);
  }
  
  // 📥 GETTERS/SETTERS ----------------
  VS      get state    => _state;
  VC      get ctrl     => _ctrl;
  set ctrl(VC pCtrl)   => _ctrl = pCtrl;
  String  get title    => _title;
  String? get subTitle => _subtitle;

  // 🌥️ FUNCIONS ABSTRACTES -----------
  /// Funció per a alliberar recursos de la vista.
  void dispose();
  @override String get baseTag => "LdView";
}