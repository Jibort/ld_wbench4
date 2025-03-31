// test_model.dart
//
// Model de proves per a la vista LdTest01.
// CreatedAt: 2025/03/31 dl. CLA[JIQ]

import 'package:ld_wbench4/05_tools/ld_map.dart';
import 'package:ld_wbench4/07_models/ld_model.dart';

class   TestModel 
extends LdModel {
  final String name;
  final String description;
  
  TestModel({
    int? pId,
    required this.name,
    required this.description,
  });

  @override
  String get baseTag => "TestModel";

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  LdMap toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}