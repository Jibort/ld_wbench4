// Entitat tipus 'reloading' per a informar a través d'Streams.
// CreatedAt: 2025/03/18 dt. JIQ

// ignore_for_file: use_super_parameters

import 'package:ld_wbench4/07_models/ld_stream_envelope.dart';

class LdReLoadingStreamEntity
extends LdStateStreamEntity {
  // 🧩 MEMBRES ------------------------

  // 📥 GETTERS/SETTERS ----------------

  // 🛠️ CONSTRUCTORS ------------------
  LdReLoadingStreamEntity({ 
    super.pTimeStamp,
    required super.pTag,
  }) : super(pState: LdEntityState.reloading);

  LdReLoadingStreamEntity.fromMap(EntityMap pMap)
  : super.fromMap(pMap: pMap);

  // 🌥️ 'LdStreamEntity' --------------
  // Innecessari.
}
