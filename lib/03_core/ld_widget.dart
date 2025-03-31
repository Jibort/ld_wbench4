// Abstracció d'una vista de l'aplicació.
// CreatedAt: 2025/03/18 dt. JIQ


import 'package:flutter/material.dart';
import 'package:ld_wbench4/03_core/ld_tag_interface.dart';
import 'package:ld_wbench4/03_core/ld_tag_mixin.dart';

abstract   class LdWidget
extends    StatefulWidget
with       LdTagMixin
implements LdTagIntf {
  LdWidget({ super.key, String? tag }) {
    if (tag != null) {
      this.tag = tag;
    }
  }
  
  @override
  String get baseTag => runtimeType.toString();
}