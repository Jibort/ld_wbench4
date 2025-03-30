// ld_stream_envelope.dart
// 
// Estructura genèrica per a qualsevol informació enviada a través d'streams.
// CreatedAt: 2025/08/21 dv. JIQ

import 'package:flutter/material.dart';

import 'package:ld_wbench4/05_tools/date_times.dart';
import 'package:ld_wbench4/05_tools/ld_map.dart';
import 'package:ld_wbench4/07_models/ld_model.dart';

abstract class LdStreamEnvelope<M extends LdModel> {
  // 📝 ESTÀTICS -----------------------
  static const String mfTimeStamp = "mfTimeStamp";
  static const String mfSrcTag    = "mfSrcTag";
  static const String mfTgtTag    = "mfTgtTag";
  static const String mfTgtTags   = "mfTgtTags";
  static const String mfFirstTime = "mfFirstTime";

  // 🧩 MEMBRES ------------------------
  late final DateTime _timestamp;
  final String       _srcTag;
  final List<String> _tgtTags = [];
  final M?           _model;

  // 📥 GETTERS/SETTERS ----------------
  DateTime     get timestamp => _timestamp;
  String       get srcTag    => _srcTag;
  List<String> get tgtTags   => _tgtTags;
  M?           get model     => _model;

  // 🛠️ CONSTRUCTORS ------------------
  LdStreamEnvelope({
    required String pSrcTag,
    List<String>? pTgtTags,
    DateTime? pTimeStamp,
    M? pModel,
  }) :
    _srcTag = pSrcTag, 
    _timestamp = pTimeStamp?? DateTime.now(),
    _model     = pModel {
      _tgtTags.addAll(pTgtTags?? []);
    }

  LdStreamEnvelope.fromMap({ required LdMap<dynamic> pMap })
  : _srcTag    = pMap[mfSrcTag],
    _timestamp = ToolsDT.parse(pMap[mfTimeStamp]),
    _model     = pMap[LdModel.mfModel] {
    _tgtTags.addAll(pMap[mfTgtTags]);
  }

  // 🌥️ FUNCIONS ABSTRACTES -----------
  @mustCallSuper
  LdMap toMap() 
    => LdMap({
      mfSrcTag:        _srcTag,
      mfTgtTags:       _tgtTags,
      mfTimeStamp:     ToolsDT.format(_timestamp),
      LdModel.mfModel: _model,
    });
}