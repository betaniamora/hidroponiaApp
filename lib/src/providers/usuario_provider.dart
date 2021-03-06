
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:formvalidation/src/blocs/provider.dart';
import 'package:formvalidation/src/models/conf_plant_model.dart';
import 'package:formvalidation/src/models/datos_model.dart';
import 'package:formvalidation/src/models/lectura_model.dart';
import 'package:formvalidation/src/models/lista_cosecha_model.dart';
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

   Future <Map<String , dynamic>> addCosecha(Map <String,Object> authData) async{

   

    final resp = await http.post(
      'http://192.168.64.2:80/hidroponia/consulta/cosecha.php',
      body: json.encode(authData)
    );

    Map<String, dynamic> decodeResp = json.decode(resp.body);

    //print(decodeResp);

   
    //int respuesta = int.parse(decodeResp['code']) ;

      print(decodeResp);
     //  print(decodeResp[0].code);
      return decodeResp ;
    
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

   Future<ConfPlantModel> datosConfPlantas(BuildContext context ) async{

     final bloc = Provider.of(context);

    final authData= {
      'inve_codi': bloc.invernadero ,
    };

    final resp = await http.post(
      'http://192.168.64.2:80/hidroponia/consulta/conf_plantas.php',
      body: json.encode(authData)
    );

    //Map<String, dynamic> decodeResp = json.decode(resp.body);

     final datosModel= confPlantModelFromJson(resp.body);
    
      print (datosModel);
      int count = datosModel.data.length;
      String titulo = datosModel.data[0].plantDesc;
      print(count);
      

      
    return datosModel;

  }

  Future<ListaCosechasModel> listaCosecha(BuildContext context) async{

     final bloc = Provider.of(context);

    final authData= {
      'inve_codi': bloc.invernadero
    };

    final resp = await http.post(
      'http://192.168.64.2:80/hidroponia/consulta/lista_cosechas.php',
      body: json.encode(authData)
    );

    //Map<String, dynamic> decodeResp = json.decode(resp.body);

     final datosModel= listaCosechasModelFromJson(resp.body);
    
     

    return datosModel;

  }


  }

  

