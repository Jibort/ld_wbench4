// Entitat tipus 'themeUpdate' per a informar a través d'Streams.
// CreatedAt: 2025/03/18 dt. JIQ

// ignore_for_file: use_super_parameters

import 'package:ld_wbench4/05_tools/ld_map.dart';
import 'package:ld_wbench4/07_models/ld_model.dart';
import 'package:ld_wbench4/07_models/models.dart';

class LdThemeStreamEntity<T>
extends LdStateStreamEntity {
  // 🧩 MEMBRES ------------------------
  final T _data;
  
  // 📥 GETTERS/SETTERS ----------------
  T get data => _data;
  
  // 🛠️ CONSTRUCTORS ------------------
  LdThemeStreamEntity({
    super.pTimeStamp,
    required super.pSrcTag, 
    super.pTgtTag,
    required T pData, })
  : _data = pData,
    super(pState: LdEntityState.updatingTheme);
  
    LdThemeStreamEntity.fromMap(LdMap pMap)
    : _data = pMap[LdModel.mfModel],
      super.fromMap(pMap: pMap);

    // 🌥️ 'LdStreamEntity' --------------
  @override
  LdMap toMap() {
    LdMap map = super.toMap();
    map[LdModel.mfModel] = _data;
    return map;
  }
}