// ld_test_01_ctrl.dart
//
// Controlador de la vista de proves 'Test_01'.
// CreatedAt: 2025/03/19 dc. JIQ

import 'package:flutter/material.dart';
import 'package:ld_wbench4/01_views/test_01/ld_test_01.dart';
import 'package:ld_wbench4/01_views/test_01/ld_test_01_state.dart';
import 'package:ld_wbench4/01_views/test_01/test_01_model.dart';
import 'package:ld_wbench4/02_theme/ld_theme.dart';
import 'package:ld_wbench4/03_core/ld_ctrl.dart';
import 'package:ld_wbench4/03_core/interfaces/ld_tag_intf.dart';
import 'package:ld_wbench4/03_core/ld_view.dart';
import 'package:ld_wbench4/03_core/ld_view_crtl.dart';
import 'package:ld_wbench4/03_core/ld_widget.dart';
import 'package:ld_wbench4/03_core/ld_widget_crtl.dart';
import 'package:ld_wbench4/03_core/ld_widget_state.dart';
import 'package:ld_wbench4/07_models/ld_model.dart';
import 'package:ld_wbench4/08_streams/ld_stream_envelope.dart';
import 'package:ld_wbench4/09_trans/l.dart';
import 'package:ld_wbench4/10_widgets/ld_scaffold/ld_scaffold_widget.dart';

class   LdTest01Ctrl<
  FW extends StatefulWidget,
  V  extends LdTest01<FW, V, VS, VC, W, WS, WC, M>, 
  VS extends LdTest01State<FW, V, VS, VC, W, WS, WC, M>,
  VC extends LdTest01Ctrl<FW, V, VS, VC, W, WS, WC, M>,
  W  extends LdWidget<FW, V, VS, VC, W, WS, WC, M>, 
  WS extends LdWidgetState<FW, V, VS, VC, W, WS, WC, M>,
  WC extends LdWidgetCtrl<FW, V, VS, VC, W, WS, WC, M>,
  M  extends LdModel
>
extends LdViewCtrl<LdTest01, LdTest01State, LdTest01Ctrl, LdTest01, Test01Model> {
  // 🧩 MEMBRES ------------------------
  List<Test01Model>? _items;

  // 🛠️ CONSTRUCTOR -------------------
  LdTest01Ctrl({ required super.pState });

  // 🌥️ FUNCIONALITAT -----------------
  void toggleTheme() => LdTheme.single.toggleTheme();
  void changeLanguage(String langCode) =>
      L.tr.changeLanguage(pSrcTag: state.tag, pLangCode: langCode);

  // 🌥️ 'LdTagIntf' -------------------
  @override
  String get baseTag => "LdTest01Ctrl";

  @override
  void connectState() {}

  // 🌥️ 'LdCtrl' ----------------------
  @override
  Widget build(BuildContext pBCtx) {
    return LdScaffold(
      pTag: "${baseTag}_Scaffold",
      pView: state.view,
    );

    //   appBar: LdAppBar(
    //     ctrl: LdAppBarCtrl(
    //       pTag: 'test_appbar',
    //       pView: context as LdAppBar,
    //       viewState: _state,
    //       showProgress: true,
    //       pActions: [
    //         IconButton(
    //           icon: Icon(Icons.language),
    //           onPressed: () => _showLanguageMenu(context),
    //         ),
    //         IconButton(
    //           icon: Icon(Icons.brightness_4),
    //           onPressed: _ctrl.toggleTheme,
    //         ),
    //       ],
    //     ),
    //   ),
    //   body: _buildBody(),
    // );
  }

  @override
  void initState() {
    super.initState();

    // Crear estat i controlador
    _state = LdTest01State();
    _ctrl = LdTest01Ctrl(_state);

    // Escoltar events de l'estat d'aquesta vista
    listenToEventsFrom(state.tag, _handleStateEvents);

    // Iniciar càrrega de dades
    loadData();
  }

  void _handleStateEvents(LdEvent event) {
    if (event is LdStateChangedEvent) {
      final state = event.state;

      setState(() {
        _isLoading = _state.isLoading;
        _isError = _state.isError;
        _errorMessage = _state.errorMessage;
        _items = _state.items;
      });
    }
  }

  @override
  void dispose() {
    state.cancelSubscription();
    state.dispose();
    super.dispose();
  }

  Widget _buildBody() {
    if (state.isLoading) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(L.loading.tx),
          ],
        ),
      );
    }

    if (_isError) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 48),
            SizedBox(height: 16),
            Text(_errorMessage ?? 'Error desconegut'),
            SizedBox(height: 16),
            ElevatedButton(onPressed: _ctrl.loadData, child: Text(L.reload.tx)),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: _items?.length ?? 0,
      itemBuilder: (context, index) {
        final item = _items![index];
        return ListTile(
          leading: CircleAvatar(child: Text('${index + 1}')),
          title: Text(item.name),
          subtitle: Text(item.description),
          onTap: () => _showItemDetails(context, item),
        );
      },
    );
  }

  void _showLanguageMenu(BuildContext context) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 0, 0),
      items: [
        PopupMenuItem(child: Text('Català'), onTap: () => changeLanguage('ca')),
        PopupMenuItem(
          child: Text('English'),
          onTap: () => changeLanguage('en'),
        ),
        PopupMenuItem(
          child: Text('Español'),
          onTap: () => changeLanguage('es'),
        ),
        PopupMenuItem(
          child: Text('Français'),
          onTap: () => changeLanguage('fr'),
        ),
        PopupMenuItem(
          child: Text('Português'),
          onTap: () => changeLanguage('pt'),
        ),
      ],
    );
  }

  void _showItemDetails(BuildContext context, Test01Model item) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(item.name),
            content: Text(item.description),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Tancar'),
              ),
            ],
          ),
    );
  }
  
  @override
  void setupEventListeners() {
    // TODO: implement setupEventListeners
  }
}
