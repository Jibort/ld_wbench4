//
// CreatedAt: 2025/03/21 dv. JIQ

import 'package:flutter/widgets.dart';

import 'package:ld_wbench4/01_views/test_01/ld_test_01_ctrl.dart';
import 'package:ld_wbench4/01_views/test_01/ld_test_01_state.dart';
import 'package:ld_wbench4/03_core/ld_view.dart';

export 'package:ld_wbench4/01_views/test_01/ld_test_01_ctrl.dart';
export 'package:ld_wbench4/01_views/test_01/ld_test_01_state.dart';
export 'package:ld_wbench4/01_views/test_01/test_01_model.dart';

class LdTest01<
  FW extends StatefulWidget,
  V  extends LdTest01<FW, V, VS, VC, W, WS, WC, M>, 
  VS extends LdTest01State<FW, V, VS, VC, W, WS, WC, M>,
  VC extends LdTest01Ctrl<FW, V, VS, VC, M>,
  W  extends LdWidget<FW, V, VS, VC, W, WS, WC, M>, 
  WS extends LdWidgetState<FW, V, VS, VC, W, WS, WC, M>,
  WC extends LdWidgetCtrl<FW, W, WS, WC, M>,
  M  extends LdModel
>
extends LdView<FW, V, VS, VC, W, WS, WC, M> {
  // 🧩 MEMBRES ------------------------

  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdTest01({ 
    super.key,
    required super.pState,
    required super.pTitle,
    super.pSubTitle }) {
      ctrl = state.ctrl;
    }
  
  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  State<LdTest01> createState() => ;
}
