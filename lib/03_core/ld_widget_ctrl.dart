// Abstracció del controlador d'una vista.
// CreatedAt: 2025/03/18 dt. 

import 'package:ld_wbench4/03_core/ld_ctrl.dart';
import 'package:ld_wbench4/03_core/ld_widget.dart';
import 'package:ld_wbench4/07_models/ld_stream_envelope.dart';

abstract class LdWidgetCtrl<
  T  extends LdStreamEnvelope,
  WC extends LdWidgetCtrl<T, WC, WS>,
  WS extends LdWidgetState<T, WC, WS>
>
extends LdCtrl<T, WS> {
  // 📝 ESTÀTICS -----------------------
  static const String className = "LdWidgetCtrl";
  
  // 🧩 MEMBRES ------------------------
  
  // 📥 GETTERS/SETTERS ----------------
  
  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdWidgetCtrl({ required super.pTag });

  @override  
  void dispose() {
    super.dispose();
  }
  
  // 📥 GETTERS/SETTERS ----------------

  // 🌥️ 'LdCtrl' ----------------------

}