//
// CreatedAt: 2025/03/21 dv. JIQ

import 'package:ld_wbench4/03_core/ld_tag_interface.dart';
import 'package:ld_wbench4/03_core/ld_view.dart';

class      LdTest01
extends    LdView 
implements LdTagIntf {
  // 📝 ESTÀTICS -----------------------

  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdTest01({
    String? pTag,
    required super.pState,
    required super.pCtrl
  }): super(pTag: pTag, );
  
  // 'LdTagIntf' ----------------------
  @override
  String get baseTag => "LdTest01";
  
  // ´LdView´ -------------------------
  @override
  createState() {
    
  }
}
