// Estat de la vista de proves 'Test_01'.
// CreatedAt: 2025/03/19 dc. JIQ

import 'package:flutter/widgets.dart';
import 'package:ld_wbench4/01_views/test_01/ld_test_01.dart';
import 'package:ld_wbench4/03_core/ld_view_state.dart';
import 'package:ld_wbench4/09_trans/l.dart';

class LdTest01State<
  FW extends StatefulWidget,
  V  extends LdTest01<FW, V, VS, VC, W, WS, WC, M>, 
  VS extends LdTest01State<FW, V, VS, VC, W, WS, WC, M>,
  VC extends LdTest01Ctrl<FW, V, VS, VC, W, WS, WC, M>,
  W  extends LdTest01<FW, V, VS, VC, W, WS, WC, M>, 
  WS extends LdTest01State<FW, V, VS, VC, W, WS, WC, M>,
  WC extends LdTest01Ctrl<FW, V, VS, VC, W, WS, WC, M>,
  M  extends Test01Model
>
extends LdViewState<FW, V, VS, VC, W, WS, WC, M> {
  // 🧩 MEMBRES ------------------------
  List<Test01Model>? items;
  
  // 🛠️ CONSTRUCTOR -------------------
  LdTest01State({
    required String pTitle,
    String? pSubTitle,
  })
  : super(pTag: "LdTest01State") {
    ctrl = LdTest01Ctrl(pState: this);
  }

  // 📥 GETTERS/SETTERS ----------------
  String? get title => L.test01Title.tx;
  String? get subtitle => isLoading 
      ? L.test01SubTitle.tx 
      : (items != null ? '${items!.length} elements' : null);

  // 🌥️ 'LdState' ---------------------
  @override
  Future<Test01Model?> dataProcess({String? pSrcTag, List<String>? pTgtTags}) async {
    // Simulem una càrrega de dades
    final totalItems = 10;
    items = [];
    
    for (int i = 0; i < totalItems; i++) {
      // Actualitzar estadístiques
      updateStats(totalItems, i, i / totalItems);
      
      // Simulem el temps de càrrega
      await Future.delayed(Duration(milliseconds: 300));
      
      // Afegim un element
      items!.add(Test01Model(
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
    
    return Test01Model(
      name: 'Model Principal',
      description: 'Model carregat correctament'
    );
  }
  
  // 🌥️ 'LdTagIntf' -------------------
  @override
  String get baseTag => "LdTest01State";
}