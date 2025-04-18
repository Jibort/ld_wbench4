// Gestor de bindings per a la injecció de dades i controladors.
// CreatedAt: 2025/03/08 dt. JIQ

import 'package:intl/intl.dart';
import 'package:ld_wbench4/03_core/interfaces/ld_tag_intf.dart';
import 'package:ld_wbench4/03_core/mixins/ld_tag_mixin.dart';
import 'package:ld_wbench4/05_tools/ld_map.dart';

class LdBinding<T extends LdTagMixin> {
  // 📝 ESTÀTICS -----------------------
  static int _views = 0;
  static String get _newView => NumberFormat('00000').format(_views++);
  static int _widgets = 0;
  static String get _newWidget => NumberFormat('00000').format(_widgets++);
  static int _states = 0;
  static String get _newState => NumberFormat('00000').format(_states++);
  static int _ctrls = 0;
  static String get _newCtrl => NumberFormat('00000').format(_ctrls++);
  static int _services = 0;
  static String get _newService => NumberFormat('00000').format(_services++);

  // 📝 SINGLETON ----------------------
  static final LdBinding _single = LdBinding._();
  static LdBinding get single => _single;

  // 🧩 MEMBRES ------------------------
  final LdMap<T> _map = LdMap<T>({});

  // 🛠️ CONSTRUCTORS ------------------
  LdBinding._();

  // 🌥️ GESTIÓ DELS BINDINGS  ---------
  // Afegeix un objecte al magatzem.
  void add(String pTag, T pBind) {
    _map[pTag] = pBind;
  }

  // Elimina un objecte del magatzem.
  LdTagMixin? remove(String pTag) {
    return _map.remove(pTag);
  }

  // Retorna cert només si la clau està enregistrada.
  bool contains(String pTag) => _map.containsKey(pTag);

  // Retorna la instància enregistrada associada amb el tag o nul.
  LdTagMixin? get(String pTag) => _map[pTag];

  // 📝 CREACIÓ DE TAGS ----------------
  String newViewTag(dynamic pBase) {
    assert((pBase == null || pBase! is String || pBase! is T), "LdTagMixin.newViewTag(pBase): pBase no és nul ni cap tipus de vista acceptat!");
    String tag;

    if (pBase == null) {
      tag = "LdView[$_newView]";
    } else if (pBase is String) {
      tag = "$pBase[$_newView]";
    } else {
      tag = "${(pBase as LdTagIntf).baseTag}[$_newView]";
    }
    return tag;
  }

  String newWidgetTag(dynamic pBase) {
    assert((pBase == null || pBase! is String || pBase! is T), "LdTagMixin.newWidgetTag(pBase): pBase no és nul ni cap tipus de widget acceptat!");
    String tag;

    if (pBase == null) {
      tag = "LdWidget[$_newWidget]";
    } else if (pBase is String) {
      tag = "$pBase[$_newWidget]";
    } else {
      tag = "${(pBase as LdTagIntf).baseTag}[$_newWidget]";
    }

    return tag;
  }

  String newStateTag(dynamic pBase) {
    assert((pBase == null || pBase! is String || pBase! is T), "LdTagMixin.newStateTag(pBase): pBase no és nul ni cap tipus d'estat acceptat!");
    String tag;

    if (pBase == null) {
      tag = "LdState[$_newState]";
    } else if (pBase is String) {
      tag = "$pBase[$_newState]";
    } else {
      tag = "${(pBase as LdTagIntf).baseTag}[$_newState]";
    }

    return tag;
  }

  String newCtrlTag(dynamic pBase) {
    assert((pBase == null || pBase! is String || pBase! is T), "LdTagMixin.newCtrlTag(pBase): pBase no és nul ni cap tipus de controlador acceptat!");
    String tag;

    if (pBase == null) {
      tag = "LdCtrl[$_newCtrl]";
    } else if (pBase is String) {
      tag = "$pBase[$_newCtrl]";
    } else {
      tag = "${(pBase as LdTagIntf).baseTag}[$_newCtrl]";
    }

    return tag;
  }

  String newServiceTag(dynamic pBase) {
        assert((pBase == null || pBase! is String || pBase! is T), "LdTagMixin.newServiceTag(pBase): pBase no és nul ni cap tipus de servei acceptat!");


    String tag;

    if (pBase == null) {
      tag = "LdService[$_newService]";
    } else if (pBase is String) {
      tag = "$pBase[$_newService]";
    } else {
      tag = "${(pBase as LdTagIntf).baseTag}[$_newService]";
    }

    return tag;
  }
}
