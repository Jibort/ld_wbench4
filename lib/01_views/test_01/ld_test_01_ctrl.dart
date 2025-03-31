// ld_test_01_ctrl.dart
//
// Controlador de la vista de proves 'Test_01'.
// CreatedAt: 2025/03/19 dc. JIQ

import 'package:flutter/material.dart';
import 'package:ld_wbench4/01_views/test_01/ld_test_01.dart';
import 'package:ld_wbench4/01_views/test_01/ld_test_01_state.dart';
import 'package:ld_wbench4/02_theme/ld_theme.dart';
import 'package:ld_wbench4/03b_core/ld_ctrl.dart';
import 'package:ld_wbench4/03_core/ld_tag_interface.dart';
import 'package:ld_wbench4/03b_core/ld_view.dart';
import 'package:ld_wbench4/08_streams/ld_stream_envelope.dart';
import 'package:ld_wbench4/09_trans/l.dart';

class LdTest01Ctrl 
extends LdCtrl<LdTest01> {
  
  final LdTest01State state;
  
  LdTest01Ctrl(this.state) {
    state.ctrl = this;
  }
  
  Future<void> loadData() async => await state.loadData();
  void toggleTheme()            => LdTheme.single.toggleTheme();
  void changeLanguage(String langCode) 
    => L.tr.changeLanguage(pSrcTag: state.tag, pLangCode: langCode);
  
  @override
  String get baseTag => "LdTest01Ctrl";
  
  @override
  Widget build(BuildContext pBCtx) {
    throw UnimplementedError();
  }
  
  @override
  void connectState() {
  }
}



class _LdTest01State extends State<LdTest01> with LdEventListenerMixin {
  late LdTest01State _state;
  late LdTest01Ctrl _ctrl;
  
  // Estat de la UI
  bool _isLoading = false;
  bool _isError = false;
  String? _errorMessage;
  List<TestModel>? _items;
  
  @override
  void initState() {
    super.initState();
    
    // Crear estat i controlador
    _state = LdTest01State();
    _ctrl = LdTest01Ctrl(_state);
    
    // Escoltar events de l'estat d'aquesta vista
    listenToEventsFrom(_state.tag, _handleStateEvents);
    
    // Iniciar càrrega de dades
    _ctrl.loadData();
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
    cancelSubscription();
    _state.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return LdScaffold(
      appBar: LdAppBar(
        ctrl: LdAppBarCtrl(
          pTag: 'test_appbar',
          pView: context as LdAppBar,
          viewState: _state,
          showProgress: true,
          pActions: [
            IconButton(
              icon: Icon(Icons.language),
              onPressed: () => _showLanguageMenu(context),
            ),
            IconButton(
              icon: Icon(Icons.brightness_4),
              onPressed: _ctrl.toggleTheme,
            ),
          ],
        ),
      ),
      body: _buildBody(),
    );
  }
  
  Widget _buildBody() {
    if (_isLoading) {
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
            ElevatedButton(
              onPressed: _ctrl.loadData,
              child: Text(L.reload.tx),
            ),
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
        PopupMenuItem(
          child: Text('Català'),
          onTap: () => _ctrl.changeLanguage('ca'),
        ),
        PopupMenuItem(
          child: Text('English'),
          onTap: () => _ctrl.changeLanguage('en'),
        ),
        PopupMenuItem(
          child: Text('Español'),
          onTap: () => _ctrl.changeLanguage('es'),
        ),
        PopupMenuItem(
          child: Text('Français'),
          onTap: () => _ctrl.changeLanguage('fr'),
        ),
        PopupMenuItem(
          child: Text('Português'),
          onTap: () => _ctrl.changeLanguage('pt'),
        ),
      ],
    );
  }
  
  void _showItemDetails(BuildContext context, TestModel item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
}

// class LdTest01Ctrl<T extends LdStreamEnvelope, V extends LdTest01>
// extends LdViewCtrl<V>
// implements LdTagIntf {
//   // 📝 ESTÀTICS -----------------------
  
//   // 🛠️ CONSTRUCTOR/DISPOSE -----------
//   LdTest01Ctrl(String? pTag): super(pTag: pTag);

//   @override  
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext pBCtx) {
//     return Container();
//   }
  
//   // 🌥️ 'LdTagIntf' -------------------
//   @override
//   String get baseTag => "LdTest01Ctrl";
  
//   // 🌥️ 'LdCtrl' ----------------------
//   @override
//   void connectState() {
    
//   }
// }