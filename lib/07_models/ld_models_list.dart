// Llista d'entitats de tipus LdModel.
// CreatedAt: 2025/03/22 ds. JIQ

import 'package:flutter/material.dart';
import 'package:ld_wbench4/03_core/ld_tag_interface.dart';
import 'package:ld_wbench4/05_tools/ld_map.dart';
import 'package:ld_wbench4/07_models/ld_model.dart';

abstract class LdModelsList<T extends LdModel>
implements LdTagIntf  {
  // 📝 ESTÀTICS -----------------------
  static const String mfList    = "mfList";
  // static const String mfModels  = 'mfModels';
  
  // 🧩 MEMBRES ------------------------
  final List<T> _models;

  // 🛠️ CONSTRUCTOR -------------------
  LdModelsList({ required List<T> pModels })
  : _models = pModels;

  LdModelsList.fromMap({ required LdMap pMap })
  : _models = pMap[mfList] as List<T>;

  // 📥 GETTERS/SETTERS ----------------
  int get length => _models.length;
  LdModel? model(int pIdx) => (pIdx >= 0 && pIdx < _models.length)
    ? _models[pIdx]
    : null;

  List<T> get models => _models;
  Iterable<(int, T)> get enumerable => _models.indexed;

  // 🌥️ FUNCIONS ABSTRACTES -----------
  @mustCallSuper
  void dispose() {
    _models.clear();
  }

  @mustCallSuper
  LdMap toMap() 
    => LdMap({
      mfList: _models,
    });
}
