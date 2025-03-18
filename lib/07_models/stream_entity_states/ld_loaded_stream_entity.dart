// Entitat tipus 'loaded' per a informar a través d'Streams.
// CreatedAt: 2025/03/18 dt. JIQ

// ignore_for_file: use_super_parameters

import 'package:ld_wbench4/07_models/stream_entity_states/ld_loading_stream_entity.dart';
import 'package:ld_wbench4/07_models/ld_stream_entity.dart';
import 'package:ld_wbench4/07_models/stream_entity_states/ld_state_string_entity.dart';

class LdLoadedStreamEntity<T>
extends LdStateStreamEntity {
  // 🧩 MEMBRES ------------------------
  final T _data;
  
  // 📥 GETTERS/SETTERS ----------------
  T get data => _data;
  
  // 🛠️ CONSTRUCTORS ------------------
  LdLoadedStreamEntity({
    super.pTimeStamp,
    required super.pTag, 
    required T pData, })
  : _data = pData,
    super(pState: LdEntityState.loaded);
  
    LdLoadedStreamEntity.fromMap(EntityMap pMap)
    : _data = pMap[mapData],
      super.fromMap(pMap);

    // 🌥️ 'LdStreamEntity' --------------
  @override
  EntityMap toMap() {
    EntityMap map = super.toMap();
    map[mapData] = _data;
    return map;
  }
}