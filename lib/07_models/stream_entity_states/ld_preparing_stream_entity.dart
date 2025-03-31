// Entitat tipus 'error' per a informar a través d'Streams.
// CreatedAt: 2025/03/18 dt. JIQ

// ignore_for_file: use_super_parameters

import 'package:ld_wbench4/05_tools/ld_map.dart';
import 'package:ld_wbench4/07_models/models.dart';

class   LdPreparingStreamEntity 
extends LdStateStreamEntity {
  // 🧩 MEMBRES ------------------------
  final bool _isVirgin;
  
  // 📥 GETTERS/SETTERS ----------------
  
  // 🛠️ CONSTRUCTORS ------------------
  LdPreparingStreamEntity({ required super.pSrcTag, super.pTgtTags, bool pIsVirgin = true })
  : _isVirgin = pIsVirgin, 
    super(pState: LdEntityState.preparing);
  
  // 🛠️ MÈTODES -----------------------
  bool get isFirstLoad => _isVirgin;

  LdPreparingStreamEntity.fromMap({ required LdMap pMap, bool pIsVirgin = true })
  : _isVirgin  = pIsVirgin,
    super.fromMap(pMap: pMap);

  // 🌥️ 'LdStateStreamEntity' ---------
  // Innecessari.
}
