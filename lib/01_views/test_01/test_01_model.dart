// test_model.dart
//
// Model de proves per a la vista LdTest01.
// CreatedAt: 2025/03/31 dl. CLA[JIQ]

import 'package:ld_wbench4/05_tools/ld_map.dart';
import 'package:ld_wbench4/07_models/ld_model.dart';

class   Test01Model 
extends LdModel {
  // 🧩 MEMBRES ------------------------
  final String name;
  final String description;
  
  // 🛠️ CONSTRUCTOR -------------------
  Test01Model({
    int? pId,
    required this.name,
    required this.description,
  });

  @override
  String get baseTag => "TestModel";

  @override
  void dispose() { }

  @override
  LdMap toMap() {
    LdMap map = super.toMap();
    map.addAll({
    LdModel.mfName: name,
    LdModel.mfDesc: description,
    });

    return map;
  }
}