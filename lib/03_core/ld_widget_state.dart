// ld_view_state.dart
//
// Abstracció d'una vista de l'aplicació.
// CreatedAt: 2025/03/31 dl. CLA[JIQ]

import 'package:flutter/material.dart';
import 'package:ld_wbench4/03_core/ld_ctrl.dart';
import 'package:ld_wbench4/03_core/ld_state.dart';
import 'package:ld_wbench4/03_core/ld_view.dart';
import 'package:ld_wbench4/03_core/ld_view_crtl.dart';
import 'package:ld_wbench4/03_core/ld_view_state.dart';
import 'package:ld_wbench4/03_core/ld_widget.dart';
import 'package:ld_wbench4/03_core/ld_widget_crtl.dart';
import 'package:ld_wbench4/07_models/ld_model.dart';

/// Estat base per a les vistes
abstract class LdWidgetState<
  FW extends StatefulWidget,
  V  extends LdView<FW, V, VS, VC, W, WS, WC, M>, 
  VS extends LdViewState<FW, V, VS, VC, W, WS, WC, M>,
  VC extends LdViewCtrl<FW, V, VS, VC, M>,
  W  extends LdWidget<FW, V, VS, VC, W, WS, WC, M>, 
  WS extends LdWidgetState<FW, V, VS, VC, W, WS, WC, M>,
  WC extends LdWidgetCtrl<FW, W, WS, WC, M>,
  M  extends LdModel
>
extends LdState<FW, M> {
  // 🧩 MEMBRES ------------------------
  /// Vista associada d'arrel a l'estat.
  final V _view;
  /// Controlador associat a l'estat.
  late LdCtrl<FW, M> _ctrl;
    
  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdWidgetState({ required V pView})
  : _view = pView;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  // 🛠️ GESTIÓ D'ESTATS ---------------
  V get view => _view;

  void initState() {
    // Inicialització
    _ctrl = createController();
    _ctrl.initialize(this);
  }
  
  // Mètode que cada subclasse ha d'implementar per crear el seu controlador
  LdWidgetCtrl<W, M> createController();
  
}