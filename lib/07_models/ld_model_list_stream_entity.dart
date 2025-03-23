// Entitat de dades tipus llista de 'model's per a transmetre a través d'Streams.
// CreatedAt: 2025/03/18 dt. JIQ

// ignore_for_file: use_super_parameters

import 'package:ld_wbench4/05_tools/ld_map.dart';
import 'package:ld_wbench4/07_models/client_model/ld_user_model.dart';
import 'package:ld_wbench4/07_models/ld_models_list.dart';
import 'package:ld_wbench4/07_models/ld_stream_envelope.dart';

class LdModelsListStreamEntity<T extends LdModelsList>
extends LdStreamEnvelope {
  // 🧩 MEMBRES ------------------------
  final T _list;
  
  // 📥 GETTERS/SETTERS ----------------
  T get list => _list;
  
  // 🛠️ CONSTRUCTORS ------------------
  LdModelsListStreamEntity({
    super.pTimeStamp,
    required super.pTag, 
    required T pList, })
  : _list = pList;
  
    LdModelsListStreamEntity.fromMap(LdMap pMap)
    : _list = pMap[UserModel.mfUsers],
      super.fromMap(pMap: pMap);

    // 🌥️ 'LdStreamEntity' --------------
  @override
  LdMap toMap() {
    LdMap map = super.toMap();
    map[mfData] = _list;
    return map;
  }
}