// Entitat tipus 'themeUpdate' per a informar a través d'Streams.
// CreatedAt: 2025/03/18 dt. JIQ

// ignore_for_file: use_super_parameters

import 'package:ld_wbench4/05_tools/ld_map.dart';
import 'package:ld_wbench4/07_models/ld_stream_envelope.dart';

class LdThemeStreamEntity<T>
extends LdStateStreamEntity {
  // 🧩 MEMBRES ------------------------
  final T _data;
  
  // 📥 GETTERS/SETTERS ----------------
  T get data => _data;
  
  // 🛠️ CONSTRUCTORS ------------------
  LdThemeStreamEntity({
    super.pTimeStamp,
    required super.pTag, 
    required T pData, })
  : _data = pData,
    super(pState: LdEntityState.updatingTheme);
  
    LdThemeStreamEntity.fromMap(LdMap pMap)
    : _data = pMap[mfData],
      super.fromMap(pMap: pMap);

    // 🌥️ 'LdStreamEntity' --------------
  @override
  LdMap toMap() {
    LdMap map = super.toMap();
    map[mfData] = _data;
    return map;
  }
}