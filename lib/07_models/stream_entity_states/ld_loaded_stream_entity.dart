// Entitat tipus 'loaded' per a informar a través d'Streams.
// CreatedAt: 2025/03/18 dt. JIQ

// ignore_for_file: use_super_parameters

import 'package:ld_wbench4/05_tools/ld_map.dart';
import 'package:ld_wbench4/07_models/ld_model.dart';
import 'package:ld_wbench4/07_models/models.dart';
import 'package:ld_wbench4/08_streams/ld_stream_envelope.dart';

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
    required super.pSrcTag,
    super.pTgtTags, 
    required T pData,
    required bool pFirstTime, 
 })
  : _data = pData,
    _firstTime = pFirstTime,
    super(pState: LdEntityState.loaded);
  
    LdLoadedStreamEntity.fromMap(LdMap pMap)
    : _data = pMap[LdModel.mfModel],
      _firstTime = pMap[LdStreamEnvelope.mfFirstTime],
      super.fromMap(pMap: pMap);

    // 🌥️ 'LdStreamEntity' --------------
  @override
  LdMap toMap() {
    LdMap map = super.toMap();
    map[LdModel.mfModel] = _data;
    return map;
  }
}