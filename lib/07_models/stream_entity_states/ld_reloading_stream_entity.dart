// Entitat tipus 'reloading' per a informar a través d'Streams.
// CreatedAt: 2025/03/18 dt. JIQ

// ignore_for_file: use_super_parameters

import 'package:ld_wbench4/05_tools/ld_map.dart';
import 'package:ld_wbench4/07_models/models.dart';

class LdReLoadingStreamEntity
extends LdStateStreamEntity {
  // 🧩 MEMBRES ------------------------

  // 📥 GETTERS/SETTERS ----------------

  // 🛠️ CONSTRUCTORS ------------------
  LdReLoadingStreamEntity({ 
    super.pTimeStamp,
    required super.pSrcTag,
    String? pTgtTag,
  }) : super(pState: LdEntityState.reloading);

  LdReLoadingStreamEntity.fromMap(LdMap pMap)
  : super.fromMap(pMap: pMap);

  // 🌥️ 'LdStreamEntity' --------------
  // Innecessari.
}
