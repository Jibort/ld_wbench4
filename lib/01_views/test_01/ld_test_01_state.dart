// Estat de la vista de proves 'Test_01'.
// CreatedAt: 2025/03/19 dc. JIQ

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ld_wbench4/01_views/test_01/ld_test_01_ctrl.dart';
import 'package:ld_wbench4/03_core/ld_view_state.dart';
import 'package:ld_wbench4/05_tools/ld_map.dart';
import 'package:ld_wbench4/07_models/client_model/ld_user_model.dart';
import 'package:ld_wbench4/07_models/ld_model_stream_entity.dart';
import 'package:ld_wbench4/07_models/ld_stream_envelope.dart';

class   LdTest01State<T extends LdStreamEnvelope>
extends LdViewState<T, LdTest01Ctrl<T> ,LdTest01State<T>> {
  // 📝 ESTÀTICS -----------------------
  static const String className = "LdViewState";
  
  // 🧩 MEMBRES ------------------------
  int _delaySeconds; // Retard per defecte de 2 segons
  int _userCount;    // Nombre d'usuaris per defecte
  
  // 📥 GETTERS/SETTERS ----------------
  int get delaySeconds        => _delaySeconds;
  set delaySeconds(int value) => _delaySeconds = value;

  int get userCount        => _userCount;
  set userCount(int value) => _userCount = value;

  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdTest01State({ int pSecs = 2, int pCount = 10 })
  : _delaySeconds = pSecs, 
    _userCount   = pCount,
    super(pTag: LdTest01State.className);

  @override  
  void dispose() {
    super.dispose();
  }

  // 🌥️ 'LdViewState' -----------------
  @override
  Future<T?> dataProcess(String? pTag) async {
    try {
      // Construir l'URL amb els paràmetres configurats
      final url = 'https://randomuser.me/api/?results=$_userCount&delay=${_delaySeconds * 1000}';
      
      // Realitzar la petició HTTP
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final LdMap json = jsonDecode(response.body);
        final List<dynamic> results = json['results'];
        
        // Convertir les dades a una llista d'usuaris
        final List<UserModel> users = results
            .map((userData) => UserModel.fromMap(userData))
            .toList();
        
        // Crear un objecte de resposta
        final UsersResponse usersResponse = UsersResponse(users: users);
        
        // Retornar les dades dins d'una entitat de stream adequada
        return LdModelStreamEntity<UsersResponse>(
          pTag: pTag ?? tag,
          pData: usersResponse
        ) as T;
      } else {
        // Si hi ha un error HTTP, llançar una excepció
        throw Exception('Error carregant dades: ${response.statusCode}');
      }
    } catch (e) {
      // Capturar qualsevol error
      throw Exception('Excepció carregant dades: $e');
    }
  }
  
  // Mètode per carregar les dades d'usuari
  Future<void> loadUsers() async {
    await loadData();
  }
  
}