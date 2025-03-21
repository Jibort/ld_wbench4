// Controlador de la vista de proves 'Test_01'.
// CreatedAt: 2025/03/19 dc. JIQ

import 'package:ld_wbench4/01_views/test_01/ld_test_01_state.dart';
import 'package:ld_wbench4/03_core/ld_view.dart';
import 'package:ld_wbench4/07_models/ld_stream_envelope.dart';

class LdTest01Ctrl<T extends LdStreamEnvelope>
extends LdViewCtrl<T, LdTest01Ctrl<T> ,LdTest01State<T>> {
  // 📝 ESTÀTICS -----------------------
  static const String className = "LdViewState";
  
  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdTest01Ctrl(): super(pTag: LdTest01State.className);

  @override  
  void dispose() {
    super.dispose();
  }

  // 🌥️ 'LdViewState' -----------------


}