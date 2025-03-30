// abstracció de l'estat de dades d'una vista.
// CreatedAt: 2025/03/18 dt. 

import 'package:ld_wbench4/03_core/ld_state.dart';
import 'package:ld_wbench4/03_core/ld_widget.dart';
import 'package:ld_wbench4/08_streams/ld_stream_envelope.dart';

abstract class LdWidgetState<
  T  extends LdStreamEnvelope,
  WC extends LdWidgetCtrl<T, WC, WS>,
  WS extends LdWidgetState<T, WC, WS>
>
extends LdState<T, WC> {
  // 📝 ESTÀTICS -----------------------
  
  // 🧩 MEMBRES ------------------------

  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdWidgetState({ required super.pTag });
    
  @override  
  void dispose() {
    super.dispose();
  }
}