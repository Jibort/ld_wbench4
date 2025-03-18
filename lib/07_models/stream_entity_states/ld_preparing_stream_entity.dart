// Entitat tipus 'error' per a informar a través d'Streams.
// CreatedAt: 2025/03/18 dt. JIQ

// ignore_for_file: use_super_parameters, unnecessary_overrides

import 'package:ld_wbench4/07_models/ld_stream_entity.dart';
import 'package:ld_wbench4/07_models/stream_entity_states/ld_state_string_entity.dart';

class   LdPreparingStreamEntity 
extends LdStateStreamEntity {
  // 🧩 MEMBRES ------------------------
  
  // 📥 GETTERS/SETTERS ----------------
  
  // 🛠️ CONSTRUCTORS ------------------
  LdPreparingStreamEntity({ required super.pTag })
  : super(pState: LdEntityState.preparing);

  LdPreparingStreamEntity.fromMap(EntityMap pMap)
  : super.fromMap(pMap);

  // 🌥️ 'LdStateStreamEntity' ---------
  @override
  EntityMap toMap() {
    return super.toMap();
  }
}
