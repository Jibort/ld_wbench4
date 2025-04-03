// ld_event_data_changed.dart
//
// Event que es produeix quan es requereix d'un canvi de dades.
// CreatedAt: 2025/04/01 dt. JIQ

import 'package:ld_wbench4/03_core/events/ld_event.dart';
import 'package:ld_wbench4/05_tools/ld_map.dart';

class   LdEventMap
extends LdEvent {
  // 🧩 MEMBRES ------------------------
  final LdMap _map;
  
  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdEventMap({ 
    super.pSubType,
    required super.pSrcTag, 
    super.pTgtTags, 
    required LdMap pMap })
  : _map = pMap,
    super(pType: LdEvent.evtMapEvent);

  // 📥 GETTERS/SETTERS ----------------
  LdMap get data => _map;
}


