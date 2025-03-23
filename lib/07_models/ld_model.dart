//
// CreatedAt: 2025/03/22 ds. JIQ

import 'package:ld_wbench4/05_tools/ld_map.dart';

abstract class LdModel {
  // 📝 ESTÀTICS -----------------------

  // 🧩 MEMBRES ------------------------
  final String id;

  // 🛠️ CONSTRUCTOR -------------------
  LdModel({ required this.id });

  LdModel.fromMap({ required LdMap pMap })
  : id = pMap['id'];

  // 🌥️ FUNCIONS ABSTRACTES -----------
  void dispose();

  LdMap toMap();

}
