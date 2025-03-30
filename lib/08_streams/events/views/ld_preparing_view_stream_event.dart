// ld_preparing_stream_event.dart
//
// Definició d'un event de 'preparació' per a la càrrega d'una vista.
// CreatedAt: 2025/03/26 dc. JIQ

import 'package:ld_wbench4/05_tools/ld_map.dart';
import 'package:ld_wbench4/08_streams/events/ld_stream_event.dart';
import 'package:ld_wbench4/08_streams/stream_event.dart';

class   LdPreparingViewStreamEvent 
extends LdStreamEvent {
  // 🧩 MEMBRES ------------------------
  final bool _isVirgin;
  
  // 📥 GETTERS/SETTERS ----------------
  
  // 🛠️ CONSTRUCTORS ------------------
  LdPreparingViewStreamEvent({ required super.pSrcTag, super.pTgtTag, bool pIsVirgin = true })
  : _isVirgin = pIsVirgin, 
    super(pState: StreamEvent.preparingView);
  
  // 🛠️ MÈTODES -----------------------
  bool get isFirstLoad => _isVirgin;

  LdPreparingViewStreamEvent.fromMap({ required LdMap pMap, bool pIsVirgin = true })
  : _isVirgin  = pIsVirgin,
    super.fromMap(pMap: pMap);

  // 🌥️ 'LdStateStreamEntity' ---------
  // Innecessari.
}
