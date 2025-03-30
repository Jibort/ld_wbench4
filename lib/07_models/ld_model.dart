//
// CreatedAt: 2025/03/22 ds. JIQ

import 'package:ld_wbench4/03_core/ld_tag_interface.dart';
import 'package:ld_wbench4/05_tools/ld_map.dart';

abstract class LdModel
implements LdTagIntf {
  // 📝 ESTÀTICS -----------------------
  static const String mfModel = "mfData";

  // 🧩 MEMBRES ------------------------
  final String id;

  // 🛠️ CONSTRUCTOR -------------------
  LdModel({ required this.id });

  LdModel.fromMap({ required LdMap pMap })
  : id = pMap['id'];

  // 📥 GETTERS/SETTERS ----------------
  @override String get baseTag;
  
  // 🌥️ FUNCIONS ABSTRACTES -----------
  void dispose();
  LdMap toMap();
}
