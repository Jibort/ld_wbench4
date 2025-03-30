// ld_state_stream_entity.dart
//  
// Abstracció d'un event associat a una vista.
// CreatedAt: 2025/03/18 dt. JIQ

import 'package:ld_wbench4/05_tools/ld_map.dart';
import 'package:ld_wbench4/08_streams/ld_stream_envelope.dart';
import 'package:ld_wbench4/08_streams/stream_event.dart';

// 🧩 Tipus de serialització i nom de camps.
const String mapState     = "mapState";
const String mapError     = "mapError";
const String mapException = "mapException";
const String mapData      = "mapData";

abstract class LdStreamEvent 
extends LdStreamEnvelope {
  // 🧩 MEMBRES ------------------------
  late StreamEvent _event;

  // 📥 GETTERS/SETTERS ----------------
  StreamEvent get event => _event;
  set event(StreamEvent pEvent) => _event = pEvent;

  // 🛠️ CONSTRUCTORS ------------------
  LdStreamEvent({
    super.pTimeStamp,
    required super.pSrcTag,
    required super.pTgtTag,
    required StreamEvent pState,
  }): _event = pState;

  LdStreamEvent.fromMap({ required LdMap pMap })
  : super.fromMap(pMap: pMap) {
    _event = pMap[mapState];
  }

  // 🌥️ FUNCIONS ABSTRACTES -----------
  @override
  LdMap toMap() {
    LdMap map = super.toMap();
    map[mapState] = _event;
    return map;
  }
}