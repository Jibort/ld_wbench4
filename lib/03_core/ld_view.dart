// Abstracció d'una vista de l'aplicació.
// CreatedAt: 2025/03/31 dl. CLA[JIQ]

import 'package:flutter/material.dart';
import 'package:ld_wbench4/03_core/ld_tag_interface.dart';
import 'package:ld_wbench4/03_core/ld_tag_mixin.dart';

abstract   class LdView 
extends    StatefulWidget 
with       LdTagMixin 
implements LdTagIntf {
  LdView({ super.key, String? tag }) {
    if (tag != null) {
      this.tag = tag;
    }
  }
  
  @override
  String get baseTag => "LdView";
}