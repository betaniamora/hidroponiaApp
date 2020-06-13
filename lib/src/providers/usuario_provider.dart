
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:formvalidation/src/blocs/provider.dart';
import 'package:formvalidation/src/models/datos_model.dart';
import 'package:formvalidation/src/models/lectura_model.dart';
import 'package:formvalidation/src/preferencias_usuario/referencias_usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider{

  final String _firebaseToken = 'AIzaSyAF3iDdW2LNLMLSH0amfri0iBUA_-txAco';

  final _prefs = new PreferenciasUsuario();

  

  

  Future<Map<String, dynamic>> login(String email, String password ) async{

    final authData= {
      'user': email,
      'pass': password
    };

    final resp = await http.post(
      'http://192.168.64.2:80/hidroponia/consulta/login.php',
      body: json.encode(authData)
    );

    Map<String, dynamic> decodeResp = json.decode(resp.body);

    //print(decodeResp);

   
    if(decodeResp['message'] == true ){

      return {'ok':true, 'mensaje':decodeResp['message']};
    }else{
      return {'ok':false, 'mensaje':decodeResp['message']};
    }
  }

  Future<DatosModel> datosGeneral(String email, String password ) async{

    final authData= {
      'user': email,
      'pass': password
    };

    final resp = await http.post(
      'http://192.168.64.2:80/hidroponia/consulta/login.php',
      body: json.encode(authData)
    );

    //Map<String, dynamic> decodeResp = json.decode(resp.body);

     final datosModel= datosModelFromJson(resp.body);
    
      print (datosModel);
      int count = datosModel.data.inve.length;
      print(count);
      int temporal;
      int anterior;
      String nombre='';

      for(int i=0; i<count; i++){
        print(datosModel.data.inve[i].inveCodi);
        //int grupo = datosModel.data.inve.length;
        
          nombre= datosModel.data.inve[i].inveDesc;
          print(nombre);
        
        
      }

    return datosModel;

  }

    Future<LecturaModel> datosLectura(BuildContext context ) async{

      final bloc = Provider.of(context);

    final authData= {
      'inve_codi': bloc.invernadero
    };

    final resp = await http.post(
      'http://192.168.64.2:80/hidroponia/consulta/lectu_actual.php',
      body: json.encode(authData)
    );

    //Map<String, dynamic> decodeResp = json.decode(resp.body);

     final lecturaModel= lecturaModelFromJson(resp.body);
    
      print (lecturaModel);
     

    return lecturaModel;

  }

  Future<Map<String, dynamic>> nuevoUsuario(String email, String password)async{


    final authData= {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
      body: json.encode(authData)
    );

    Map<String, dynamic> decodeResp = json.decode(resp.body);

    //print(decodeResp);
    
    if(decodeResp.containsKey('idToken') ){
      _prefs.token = decodeResp['idToken'];
      return {'ok':true, 'token':decodeResp['idToken']};
    }else{
      return {'ok':false, 'token':decodeResp['error']['message']};
    }
  }


  }

  

