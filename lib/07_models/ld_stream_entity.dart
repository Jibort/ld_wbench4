// Classe abstracta base per a la comunicació d'entitats de dades a través de LdStream.
// CreatedAt: 2025/03/18 dt. JIQ

// ignore_for_file: unnecessary_getters_setters

// Estats on es pot trobar l'entitat.
import 'package:flutter/foundation.dart';
import 'package:ld_wbench4/04_tools/date_times.dart';
import 'package:ld_wbench4/07_models/ld_reloading_stream_entity.dart';

// 🧩 Tipus de serialització i nom de camps.
typedef EntityMap = Map<String, dynamic>;
const String mapTimeStamp = "mapTimestamp";
const String mapTag       = "mapTag";

abstract class LdStreamEntity {
  // 🧩 MEMBRES ------------------------
  late final DateTime _timestamp;
  final String _tag;

  // 📥 GETTERS/SETTERS ----------------
  DateTime get timestamp => _timestamp;
  String   get tag       => _tag;


  // 🛠️ CONSTRUCTORS ------------------
  LdStreamEntity({
    DateTime? pTimeStamp,
    required String pTag,
  }) : _tag = pTag;

  LdStreamEntity.fromMap(EntityMap pMap)
  : _timestamp = ToolsDT.parse(pMap[mapTimeStamp]),
    _tag = pMap[mapTag];
  }

}

  // 🌥️ FUNCIONS ABSTRACTES -----------
  @mustCallSuper
  EntityMap toMap() {
    return {
      mapTimeStamp: ToolsDT.format(_timestamp),
    };
  }

}