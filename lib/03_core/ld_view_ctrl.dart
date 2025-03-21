// Abstracció del controlador d'una vista.
// CreatedAt: 2025/03/18 dt. 

import 'package:ld_wbench4/03_core/ld_ctrl.dart';
import 'package:ld_wbench4/03_core/ld_view.dart';
import 'package:ld_wbench4/07_models/ld_stream_envelope.dart';

abstract class LdViewCtrl<
  T extends LdStreamEnvelope,
  VC extends LdViewCtrl<T, VC, VS>,
  VS extends LdViewState<T, VC, VS>
> 
extends LdCtrl<T, VS>  {
  // 📝 ESTÀTICS -----------------------
  static const String className = "LdWidgetState";
  
  // 🧩 MEMBRES ------------------------
  
  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdViewCtrl({ required super.pTag });

  @override
  void dispose() {
    super.dispose();
  }

  // 📥 GETTERS/SETTERS ----------------
  
  // 🌥️ 'LdCtrl' ----------------------

}