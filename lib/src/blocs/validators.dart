

import 'dart:async';

class Validators{


  final validarEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink){

      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regEXP   = new RegExp(pattern);

      if(email.length >= 3){

        sink.add(email);
      }else{
        sink.addError('Email no es correcto');
      }
      
    } 
  );

  final validarPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink){

      if(password.length >= 3){

        sink.add(password);

      }else{
        sink.addError('Contrasena Incompleta');
      }

    } 
  );



}