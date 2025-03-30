// Widget de scaffold per a l'aplicació.
// CreatedAt: 2025/03/23 dg. CLA[JIQ].

import 'dart:async';
import 'package:flutter/material.dart';

import 'package:ld_wbench4/03_core/ld_widget.dart';
import 'package:ld_wbench4/05_tools/color_extensions.dart';
import 'package:ld_wbench4/07_models/ld_model.dart';
import 'package:ld_wbench4/07_models/ld_stream_envelope_old.dart';
import 'package:ld_wbench4/08_streams/ld_stream_envelope.dart';
import 'package:ld_wbench4/10_widgets/ld_app_bar/ld_appbar_widget.dart';
import 'package:ld_wbench4/10_widgets/ld_scaffold/ld_scaffold_ctrl.dart';
import 'package:ld_wbench4/10_widgets/ld_scaffold/ld_scaffold_state.dart';

export 'ld_scaffold_ctrl.dart';
export 'ld_scaffold_state.dart';

class   LdScaffold
extends LdWidget {
  // 📝 ESTÀTICS -----------------------

  // 🧩 MEMBRES ------------------------
  LdAppbar _appbar;
  
  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdScaffold({
    super.key,
    required super.pTag,
    required super.pView,
    required String pTitle,
    String? pSubtitle,
    Widget? body,
    Widget? drawer,
    Widget? endDrawer,
    Widget? floatingActionButton,
    Color? backgroundColor,
    bool resizeToAvoidBottomInset = true,
  }) : super(
    pState: LdScaffoldState(
      pTag: pTag,
      pTitle: pTitle,
      pSubtitle: pSubtitle,    
    ),
    pCtrl: LdScaffoldCtrl(
      pTag: pTag,
      pView: pView,
      pTitle: pTitle,
      pSubtitle: pSubtitle,
      pDrawer: drawer,
      pEndDrawer: endDrawer,
      pBtnFloatingAction: floatingActionButton,
      pBgColor: backgroundColor,
      pResizeToAvoidBottomInset: resizeToAvoidBottomInset,
    ),
  );

  @override
  void dispose() {
    super.dispose();
  }

  // 📥 GETTERS/SETTERS ----------------
  
  // 🌥️ 'LdWidget' --------------------
  @override
  void listen(LdStreamEnvelope<LdModel> pEnv) {
  }

  @override
  void onError() {}
  
  @override
  void onDone()  {}

  @override
  Widget build(BuildContext pBCtx) {
    return StreamBuilder<LdStreamEnvelope>(
      stream: state.stream,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: _appBar,
          drawer: _drawer,
          endDrawer: _endDrawer,
          body: _buildBody(context, snapshot),
          floatingActionButton: _floatingActionButton,
          backgroundColor: _backgroundColor,
          resizeToAvoidBottomInset: _resizeToAvoidBottomInset,
        );
      },
    );
  }

  // 🔧 MÈTODES PRIVATS ----------------
  Widget _buildBody(BuildContext pBCtx, AsyncSnapshot<LdStreamEnvelope> snapshot) {
    // Si tenim un error, mostrem un widget d'error
    if (snapshot.hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 60),
            SizedBox(height: 16),
            Text('Error: ${snapshot.error}'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => state.loadData(),
              child: Text('Reintentar'),
            ),
          ],
        ),
      );
    }

    // Si no tenim dades, mostrem un indicador de càrrega
    if (!snapshot.hasData) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    // Gestió d'estats específics
    if (snapshot.data is LdLoadingStreamEntity || 
        snapshot.data is LdReLoadingStreamEntity ||
        snapshot.data is LdPreparingStreamEntity) {
      // Podem mostrar un indicador de càrrega i, si tenim un cos, el mostrem sota
      return Stack(
        children: [
          if (_body != null) _body,
          Container(
            color: Colors.black.withPercentOpacity(0.3),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      );
    }

    // Si és un error específic, mostrem missatge d'error
    if (snapshot.data is LdErrorStreamEntity) {
      final errorData = snapshot.data as LdErrorStreamEntity;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 60),
            SizedBox(height: 16),
            Text('Error: ${errorData.error}'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => state.loadData(),
              child: Text('Reintentar'),
            ),
          ],
        ),
      );
    }

    // Per defecte, mostrem el cos normal si està disponible
    return _body ?? SizedBox.shrink();
  }

  // 🔄 GESTORS D'EVENTS DE L'STREAM ---
  void _handleStateChange(LdStreamEnvelopeOld data) {
    // Es podria implementar lògica addicional aquí si és necessari
  }

  void _handleStateError(error) {
    debugPrint('Error en l\'stream d\'estat: $error');
  }

  void _handleStateDone() {
    debugPrint('Stream d\'estat tancat');
  }

  // 'LdTagIntf' ----------------------
  @override
  String get baseTag => "LdScaffold";
}