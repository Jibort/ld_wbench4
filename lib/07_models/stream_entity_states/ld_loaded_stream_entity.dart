// Entitat tipus 'loaded' per a informar a través d'Streams.
// CreatedAt: 2025/03/18 dt. JIQ

// ignore_for_file: use_super_parameters

import 'package:ld_wbench4/07_models/ld_stream_envelope.dart';

class   LdLoadedStreamEntity<T>
extends LdStateStreamEntity {
  // 🧩 MEMBRES ------------------------
  final T _data;
  final bool _firstTime;
  
  // 📥 GETTERS/SETTERS ----------------
  T    get data      => _data;
  bool get firstTime => _firstTime;

  // 🛠️ CONSTRUCTORS ------------------
  LdLoadedStreamEntity({
    super.pTimeStamp,
    required super.pTag, 
    required T pData,
    required bool pFirstTime, 
 })
  : _data = pData,
    _firstTime = pFirstTime,
    super(pState: LdEntityState.loaded);
  
    LdLoadedStreamEntity.fromMap(EntityMap pMap)
    : _data = pMap[mfData],
      _firstTime = pMap[mfFirstTime],
      super.fromMap(pMap: pMap);

    // 🌥️ 'LdStreamEntity' --------------
  @override
  EntityMap toMap() {
    EntityMap map = super.toMap();
    map[mfData] = _data;
    return map;
  }
}