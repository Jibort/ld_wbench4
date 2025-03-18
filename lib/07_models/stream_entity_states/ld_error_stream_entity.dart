// Entitat tipus 'error' per a informar a través d'Streams.
// CreatedAt: 2025/03/18 dt. JIQ

// ignore_for_file: use_super_parameters

import 'package:ld_wbench4/07_models/ld_stream_entity.dart';
import 'package:ld_wbench4/07_models/stream_entity_states/ld_state_string_entity.dart';

class LdErrorStreamEntity 
extends LdStateStreamEntity {
  // 🧩 MEMBRES ------------------------
  final String? _error;
  final Exception? _exception;

  // 📥 GETTERS/SETTERS ----------------
  String?    get error     => _error;
  Exception? get exception => _exception;

  // 🛠️ CONSTRUCTORS ------------------
  LdErrorStreamEntity({ 
    super.pTimeStamp,
    required super.pTag,
    String?    pError,
    Exception? pException,
  }) : 
    _error = pError, _exception = pException,
    super(pState: LdEntityState.error);

  LdErrorStreamEntity.fromMap(EntityMap pMap)
    : _error = pMap[mapError],
      _exception = pMap[mapException],
      super.fromMap(pMap);

  // 🌥️ 'LdStreamEntity' --------------
  @override
  EntityMap toMap() {
    EntityMap map = super.toMap();
    map[mapError]     = _error;
    map[mapException] = _exception;
    return map;
  }
}
