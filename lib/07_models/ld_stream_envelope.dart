// Classe abstracta base per a la comunicació d'entitats de dades a través de LdStream.
// CreatedAt: 2025/03/18 dt. JIQ

// Estats on es pot trobar l'entitat.
import 'package:flutter/foundation.dart';
import 'package:ld_wbench4/05_tools/date_times.dart';

export 'stream_entity_states/ld_state_stream_entity.dart';
export 'stream_entity_states/ld_error_stream_entity.dart';
export 'stream_entity_states/ld_loaded_stream_entity.dart';
export 'stream_entity_states/ld_loading_stream_entity.dart';
export 'stream_entity_states/ld_preparing_stream_entity.dart';
export 'stream_entity_states/ld_reloading_stream_entity.dart';
export 'stream_entity_states/ld_theme_stream_entity.dart';

// 🧩 Tipus de serialització i nom de camps.
typedef EntityMap = Map<String, dynamic>;
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
  }) : _tag = pTag;

  LdStreamEnvelope.fromMap({ required EntityMap pMap })
  : _timestamp = ToolsDT.parse(pMap[mfTimeStamp]),
    _tag = pMap[mfTag];

  // 🌥️ FUNCIONS ABSTRACTES -----------
  @mustCallSuper
  EntityMap toMap() {
    return {
      mfTimeStamp: ToolsDT.format(_timestamp),
      mfTag: _tag,
    };
  }
}