// Entitat tipus 'error' per a informar a través d'Streams.
// CreatedAt: 2025/03/18 dt. JIQ

// ignore_for_file: use_super_parameters

import 'package:ld_wbench4/05_tools/ld_map.dart';
import 'package:ld_wbench4/07_models/models.dart';

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
    required   super.pSrcTag,
    String?    pTgtTag,
    String?    pError,
    Exception? pException,
  }) : 
    _error = pError, _exception = pException,
    super(pState: LdEntityState.error);

  LdErrorStreamEntity.fromMap(LdMap pMap)
    : _error = pMap[mapError],
      _exception = pMap[mapException],
      super.fromMap(pMap: pMap);

  // 🌥️ 'LdStreamEntity' --------------
  @override
  LdMap toMap() {
    LdMap map = super.toMap();
    map[mapError]     = _error;
    map[mapException] = _exception;
    return map;
  }
}
