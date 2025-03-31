// Entitat tipus 'loading' per a informar a través d'Streams.
// CreatedAt: 2025/03/18 dt. JIQ

// ignore_for_file: use_super_parameters

import 'package:ld_wbench4/05_tools/ld_map.dart';
import 'package:ld_wbench4/07_models/models.dart';

class LdLoadingStreamEntity 
extends LdStateStreamEntity {
  // 🧩 MEMBRES ------------------------

  // 📥 GETTERS/SETTERS ----------------

  // 🛠️ CONSTRUCTORS ------------------
  LdLoadingStreamEntity({ 
    required super.pSrcTag,
    super.pTgtTags,
  }): super(pState: LdEntityState.loading);

  LdLoadingStreamEntity.fromMap(LdMap pMap)
  : super.fromMap(pMap: pMap);

  // 🌥️ 'LdStreamEntity' --------------
  // Innecessari.
}
