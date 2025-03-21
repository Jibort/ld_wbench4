// Estat de la vista de proves 'Test_01'.
// CreatedAt: 2025/03/19 dc. JIQ

import 'package:ld_wbench4/01_views/test_01/ld_test_01_ctrl.dart';
import 'package:ld_wbench4/03_core/ld_view_state.dart';
import 'package:ld_wbench4/07_models/ld_stream_envelope.dart';

class LdTest01State<T extends LdStreamEnvelope>
extends LdViewState<T, LdTest01Ctrl<T> ,LdTest01State<T>> {
  // 📝 ESTÀTICS -----------------------
  static const String className = "LdViewState";
  
  // 🧩 MEMBRES ------------------------

  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdTest01State(): super(pTag: LdTest01State.className);

  @override  
  void dispose() {
    super.dispose();
  }

  // 🌥️ 'LdViewState' -----------------
  @override
  Future<T?> dataProcess(String? pTag) {
    return Future.value(null);
  }
  
}