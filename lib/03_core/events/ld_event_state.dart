// ld_event_locale_changed.dart
//
// Event que es produeix quan es requereix d'un canvi d'idioma.
// CreatedAt: 2025/04/01 dt. JIQ

import 'package:ld_wbench4/03_core/events/ld_event.dart';
import 'package:ld_wbench4/03_core/enums/state_event_enum.dart';

class   LdEventState 
extends LdEvent {
  // 🧩 MEMBRES ------------------------
  final StateEvent _state;
  
  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdEventState({ 
    required super.pSrcTag, 
    super.pTgtTags, 
    super.pIsVirgin,
    required StateEvent pState, 
  }): _state = pState,
      super(pType: LdEvent.evtStateEvent);

  // 📥 GETTERS/SETTERS -----------------
  StateEvent get state => _state;
}


