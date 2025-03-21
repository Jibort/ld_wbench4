// abstracció de l'estat de dades d'una vista.
// CreatedAt: 2025/03/18 dt. 

import 'package:ld_wbench4/03_core/ld_state.dart';
import 'package:ld_wbench4/03_core/ld_view.dart';
import 'package:ld_wbench4/07_models/models.dart';

abstract class LdViewState<
  T  extends LdStreamEnvelope,
  VC extends LdViewCtrl<T, VC, VS>,
  VS extends LdViewState<T, VC, VS>
>
extends LdState<T, VC> {
  // 📝 ESTÀTICS -----------------------
  static const String className = "LdViewState";
  
  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdViewState({ required super.pTag });

  @override  
  void dispose() {
    super.dispose();
  }

}