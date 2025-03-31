// Estat de la vista de proves 'Test_01'.
// CreatedAt: 2025/03/19 dc. JIQ

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ld_wbench4/01_views/test_01/test_model.dart';
import 'package:ld_wbench4/03_core/ld_state.dart';
import 'package:ld_wbench4/03_core/ld_tag_interface.dart';
import 'package:ld_wbench4/03_core/ld_view_state.dart';
import 'package:ld_wbench4/05_tools/ld_map.dart';
import 'package:ld_wbench4/07_models/client_model/ld_user_model.dart';
import 'package:ld_wbench4/07_models/ld_model_stream_entity.dart';
import 'package:ld_wbench4/08_streams/ld_stream_envelope.dart';

class LdTest01State extends LdState<TestModel> {
  List<TestModel>? items;
  
  @override
  String? get title => 'Vista de Proves';
  
  @override
  String? get subtitle => isLoading 
      ? 'Carregant dades...' 
      : (items != null ? '${items!.length} elements' : null);

  @override
  Future<TestModel?> dataProcess({String? pSrcTag, List<String>? pTgtTags}) async {
    // Simulem una càrrega de dades
    final totalItems = 10;
    items = [];
    
    for (int i = 0; i < totalItems; i++) {
      // Actualitzar estadístiques
      updateStats(totalItems, i, i / totalItems);
      
      // Simulem el temps de càrrega
      await Future.delayed(Duration(milliseconds: 300));
      
      // Afegim un element
      items!.add(TestModel(
        pId: i,
        name: 'Element $i',
        description: 'Descripció detallada de l\'element $i'
      ));
      
      // Simulem un error aleatori per provar la gestió d'errors
      if (i == 5 && DateTime.now().millisecond % 5 == 0) {
        throw Exception('Error de simulació al carregar l\'element $i');
      }
    }
    
    // Actualitzar estadístiques finals
    updateStats(totalItems, totalItems, 1.0);
    
    return TestModel(
      name: 'Model Principal',
      description: 'Model carregat correctament'
    );
  }
}