// ld_preparing_stream_event.dart
//
// Definició d'un event de 'preparació' per a la càrrega d'una vista.
// CreatedAt: 2025/03/26 dc. JIQ

import 'package:ld_wbench4/08_streams/events/ld_stream_event.dart';
import 'package:ld_wbench4/03_core/enums/state_event_enum.dart';

class   LdPreparingViewStreamEvent 
extends LdStreamEvent {
  // 🧩 MEMBRES ------------------------
  final bool _isVirgin;
  
  // 📥 GETTERS/SETTERS ----------------
  
  // 🛠️ CONSTRUCTORS ------------------
  LdPreparingViewStreamEvent({ required super.pSrcTag, super.pTgtTags, bool pIsVirgin = true })
  : _isVirgin = pIsVirgin, 
    super(pState: StateEvent.preparingView);
  
  // 🛠️ MÈTODES -----------------------
  bool get isFirstLoad => _isVirgin;

  LdPreparingViewStreamEvent.fromMap({ required super.pMap, bool pIsVirgin = true })
  : _isVirgin  = pIsVirgin,
    super.fromMap();

  // 🌥️ 'LdStateStreamEntity' ---------
  // Innecessari.
}
