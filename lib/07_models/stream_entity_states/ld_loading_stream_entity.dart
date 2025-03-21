// Entitat tipus 'loading' per a informar a través d'Streams.
// CreatedAt: 2025/03/18 dt. JIQ

// ignore_for_file: use_super_parameters

import 'package:ld_wbench4/07_models/ld_stream_envelope.dart';

class LdLoadingStreamEntity 
extends LdStateStreamEntity {
  // 🧩 MEMBRES ------------------------

  // 📥 GETTERS/SETTERS ----------------

  // 🛠️ CONSTRUCTORS ------------------
  LdLoadingStreamEntity({ 
    required super.pTag,
  }): super(pState: LdEntityState.loading);

  LdLoadingStreamEntity.fromMap(EntityMap pMap)
  : super.fromMap(pMap: pMap);

  // 🌥️ 'LdStreamEntity' --------------
  // Innecessari.
}
