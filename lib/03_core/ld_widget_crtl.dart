// ld_view_state.dart
//
// Abstracció d'una vista de l'aplicació.
// CreatedAt: 2025/03/31 dl. CLA[JIQ]

import 'package:flutter/material.dart';
import 'package:ld_wbench4/03_core/events/ld_event.dart';
import 'package:ld_wbench4/03_core/ld_ctrl.dart';
import 'package:ld_wbench4/03_core/ld_view.dart';
import 'package:ld_wbench4/03_core/ld_view_crtl.dart';
import 'package:ld_wbench4/03_core/ld_view_state.dart';
import 'package:ld_wbench4/03_core/ld_widget.dart';
import 'package:ld_wbench4/03_core/ld_widget_state.dart';
import 'package:ld_wbench4/03_core/mixins/ld_event_emitter_mixin.dart';
import 'package:ld_wbench4/03_core/mixins/ld_event_listener_mixin.dart';
import 'package:ld_wbench4/07_models/ld_model.dart';

/// Controlador base per vistes
abstract class LdWidgetCtrl<
  FW extends StatefulWidget,
  V  extends LdView<FW, V, VS, VC, W, WS, WC, M>, 
  VS extends LdViewState<FW, V, VS, VC, W, WS, WC, M>,
  VC extends LdViewCtrl<FW, V, VS, VC, W, WS, WC, M>,
  W  extends LdWidget<FW, V, VS, VC, W, WS, WC, M>, 
  WS extends LdWidgetState<FW, V, VS, VC, W, WS, WC, M>,
  WC extends LdWidgetCtrl<FW, V, VS, VC, W, WS, WC, M>,
  M  extends LdModel> 
extends LdCtrl<FW, M>
with LdEventEmitterMixin, LdEventListenerMixin {
  // 🧩 MEMBRES ---------º---------------
  /// Referència a l'estat de la vista
  late LdWidgetState<FW, V, VS, VC, W, WS, WC, M> _state;
  
  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdWidgetCtrl({ required super.pState });
  
    @override
  void dispose() {
    cancelSubscription();
    super.dispose();
  }
  // Inicialitzar el controlador amb l'estat de la vista
  void initialize(LdWidgetState<FW, V, VS, VC, W, WS, WC, M> pState) {
    _state = pState;
    setupEventListeners();
  }
  // Configurar listeners d'events
  void setupEventListeners();
  // {
  //   listenToEventType((pEvent) {
  //     if (isRelevantStateChange(pEvent)) {
  //       updateUI();
  //     }
  //   });
  // }

  // 🛠️ GESTIÓ D'ESTATS --------------- 
  /// Inicialització
  @override
  void initState() {
    super.initState();
    _ctrl = createCtrl();
    _ctrl.initialize(this);
  }
  // Actualitzar la UI
  void updateUI() {
    // Mecanisme per actualitzar la UI
  }
  // Determinar si un canvi d'estat és rellevant
  bool isRelevantStateChange(LdEvent pEvent) {
    return true;
  }
  
  // Actualitzar estat
  void updateState<V>(String key, V value) {
    _state.setValue<V>(key, value, sourceTag: tag);
  }
  
  // Obtenir valor d'estat
  V? getStateValue<V>(String key) {
    return _state.getValue<V>(key);
  }
}   