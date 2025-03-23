// Classe abstracta base per a la comunicació d'entitats de dades a través de LdStream.
// CreatedAt: 2025/03/18 dt. JIQ

// Estats on es pot trobar l'entitat.
import 'package:flutter/foundation.dart';
import 'package:ld_wbench4/05_tools/date_times.dart';
import 'package:ld_wbench4/05_tools/ld_map.dart';

export 'stream_entity_states/ld_state_stream_entity.dart';
export 'stream_entity_states/ld_error_stream_entity.dart';
export 'stream_entity_states/ld_loaded_stream_entity.dart';
export 'stream_entity_states/ld_loading_stream_entity.dart';
export 'stream_entity_states/ld_preparing_stream_entity.dart';
export 'stream_entity_states/ld_reloading_stream_entity.dart';
export 'stream_entity_states/ld_theme_stream_entity.dart';

// 🧩 Noms dels camps.
const String mfTimeStamp = "mfTimeStamp";
const String mfTag       = "mfTag";
const String mfFirstTime = "mfFirstTime";
const String mfData      = "mfData";

abstract class LdStreamEnvelope {
  // 🧩 MEMBRES ------------------------
  late final DateTime _timestamp;
  final String _tag;

  // 📥 GETTERS/SETTERS ----------------
  DateTime get timestamp => _timestamp;
  String   get tag       => _tag;

  // 🛠️ CONSTRUCTORS ------------------
  LdStreamEnvelope({
    DateTime? pTimeStamp,
    required String pTag,
  }) : 
    _tag = pTag, 
    _timestamp = pTimeStamp?? DateTime.now();

  LdStreamEnvelope.fromMap({ required LdMap<dynamic> pMap })
  : _timestamp = ToolsDT.parse(pMap[mfTimeStamp]),
    _tag = pMap[mfTag];

  // 🌥️ FUNCIONS ABSTRACTES -----------
  @mustCallSuper
  LdMap toMap() 
    => LdMap({
      mfTimeStamp: ToolsDT.format(_timestamp),
      mfTag: _tag,
    }
  );
  
}