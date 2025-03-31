// abstracció de l'estat de dades d'una vista.
// CreatedAt: 2025/03/18 dt. 

import 'package:ld_wbench4/03b_core/ld_state.dart';
import 'package:ld_wbench4/03b_core/ld_widget.dart';
import 'package:ld_wbench4/07_models/ld_model.dart';
import 'package:ld_wbench4/08_streams/ld_stream_envelope.dart';

abstract class LdWidgetState<
  V extends LdWidget,
  E extends LdStreamEnvelope<LdModel>>
extends LdState<E> {
  // 📝 ESTÀTICS -----------------------
  
  // 🧩 MEMBRES ------------------------

  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdWidgetState({ required super.pTag });
    
  @override  
  void dispose() {
    super.dispose();
  }
}