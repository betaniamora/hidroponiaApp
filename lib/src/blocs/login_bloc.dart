

import 'dart:async';

import 'package:formvalidation/src/blocs/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators{

  final _passwordController    = BehaviorSubject<String>();
  final _emailController       = BehaviorSubject<String>();
  final _invernaderoController = BehaviorSubject<int>();


  //recuperar datos del stream

 Stream<String> get emailStream    => _emailController.stream.transform(validarEmail);
 Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);
 Stream<int> get invernaderoStream => _invernaderoController.stream;

Stream<bool> get formValidStream => CombineLatestStream.combine2(emailStream, passwordStream, (e, p) => true);

  //inserrtar valores al string

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePasword => _passwordController.sink.add;
  Function(int) get changeInvernadero => _invernaderoController.sink.add;

  //obtener ultimos valores ingresados

  String get email=> _emailController.value;
  String get pass=> _passwordController.value;
  int get invernadero => _invernaderoController.value;

  dispose(){
    _emailController?.close();
    _passwordController?.close();
    _invernaderoController?.close();
  }

}