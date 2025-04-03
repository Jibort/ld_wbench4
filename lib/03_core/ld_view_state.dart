// ld_view_state.dart
//
// Abstracció d'una vista de l'aplicació.
// CreatedAt: 2025/03/31 dl. CLA[JIQ]

import 'package:flutter/material.dart';
import 'package:ld_wbench4/03_core/ld_state.dart';
import 'package:ld_wbench4/03_core/ld_view.dart';
import 'package:ld_wbench4/03_core/ld_view_crtl.dart';
import 'package:ld_wbench4/03_core/ld_widget.dart';
import 'package:ld_wbench4/03_core/ld_widget_crtl.dart';
import 'package:ld_wbench4/03_core/ld_widget_state.dart';
import 'package:ld_wbench4/07_models/ld_model.dart';

/// Estat base per a les vistes
abstract class LdViewState<
  FW extends StatefulWidget,
  V  extends LdView<FW, V, VS, VC, W, WS, WC, M>, 
  VS extends LdViewState<FW, V, VS, VC, W, WS, WC, M>,
  VC extends LdViewCtrl<FW, V, VS, VC, W, WS, WC, M>,
  W  extends LdWidget<FW, V, VS, VC, W, WS, WC, M>, 
  WS extends LdWidgetState<FW, V, VS, VC, W, WS, WC, M>,
  WC extends LdWidgetCtrl<FW, W, WS, WC, M>,
  M  extends LdModel
>
extends LdState<FW, M> {
  // 🧩 MEMBRES ------------------------
  late LdViewCtrl<FW, V, VS, VC, W, WS, WC, M> _ctrl;
  
  /// Referència a la vista
  V get view;
  
  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdViewState({ super.pTag });

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  // 🛠️ GESTIÓ D'ESTATS --------------- 
  /// Inicialització
  void initState() {
    _ctrl = createCtrl();
    _ctrl.initialize(this);
  }
  
  // Mètode que cada subclasse ha d'implementar per crear el seu controlador
  LdViewCtrl<FW, V, VS, VC, W, WS, WC, M> createCtrl();
}