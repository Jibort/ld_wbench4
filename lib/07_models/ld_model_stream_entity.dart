// Entitat tipus 'loaded' per a informar a través d'Streams.
// CreatedAt: 2025/03/18 dt. JIQ

// ignore_for_file: use_super_parameters

import 'package:ld_wbench4/07_models/ld_stream_envelope.dart';

class LdStreamEntity<T>
extends LdStreamEnvelope {
  // 🧩 MEMBRES ------------------------
  final T _data;
  
  // 📥 GETTERS/SETTERS ----------------
  T get data => _data;
  
  // 🛠️ CONSTRUCTORS ------------------
  LdStreamEntity({
    super.pTimeStamp,
    required super.pTag, 
    required T pData, })
  : _data = pData;
  
    LdStreamEntity.fromMap(EntityMap pMap)
    : _data = pMap[mfData],
      super.fromMap(pMap: pMap);

    // 🌥️ 'LdStreamEntity' --------------
  @override
  EntityMap toMap() {
    EntityMap map = super.toMap();
    map[mfData] = _data;
    return map;
  }
}