//
// CreatedAt: 2025/03/22 ds. JIQ

import 'package:flutter/widgets.dart';
import 'package:ld_wbench4/03_core/interfaces/ld_tag_intf.dart';
import 'package:ld_wbench4/05_tools/ld_map.dart';

abstract class LdModel
implements LdTagIntf {
  // 📝 ESTÀTICS -----------------------
  static int _ids = 0;
  static int get newId => _ids++;

  static const String mfModel = "mfModel";
  static const String mfId    = "mdId";
  static const String mfName  = "mfName";
  static const String mfDesc  = "mfDesc";

  // 🧩 MEMBRES ------------------------
  final int id;

  // 🛠️ CONSTRUCTOR -------------------
  LdModel({ int? pId }):id = pId?? LdModel.newId;

  LdModel.fromMap({ required LdMap pMap })
  : id = pMap[mfId];

  // 📥 GETTERS/SETTERS ----------------
  @override String get baseTag;
  
  // 🌥️ FUNCIONS ABSTRACTES -----------
  void dispose();
  @mustCallSuper
  LdMap toMap() => LdMap({ mfId: id });
}
