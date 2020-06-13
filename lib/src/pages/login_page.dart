import 'package:flutter/material.dart';
import 'package:formvalidation/src/blocs/provider.dart';
import 'package:formvalidation/src/providers/usuario_provider.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;

class LoginPage extends StatelessWidget {

  final usuarioProvider = new UsuarioProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context),
        ],
      ),
    );
    
  }

  Widget _crearFondo(context) {

    final fondoImagen= Container(
      child: Image(
        image: AssetImage('assets/farm.png'),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        fit: BoxFit.cover,
      ),
    );

    return Stack(
      children: <Widget>[
        fondoImagen,
        Container(
          padding: EdgeInsets.only(top:100.0),
          child:Column(
            children: <Widget>[
              Center(
                child: Container(                 
                  child: Image(
                    image: AssetImage('assets/logo.png'),
                    width: 180,
                    height: 180,
                  ),
                ),
              ),
            ],
          )
        )
      ],
    );

  }

  Widget _loginForm(context) {

    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height:180.0,
            )
          ),
          Container(
            width: size.width,
            padding: EdgeInsets.symmetric(vertical: 50.0),
            margin: EdgeInsets.symmetric(vertical: 30.0),         
            child: Column(
              children: <Widget>[
                Text('Ingresar',
                  style: TextStyle(fontSize:30.0, color: Colors.white)
                ),
                SizedBox(height:40.0),
                _crearEmail(bloc),
                SizedBox(height:30.0),
                _crearPassword(bloc),
                SizedBox(height:30.0),
                _crearBoton(bloc),
              ],
            ),
          ),
          FlatButton(
            child: Text('Olvide mi Contrasena', style: TextStyle(color: Colors.white),),
            onPressed: ()=>Navigator.pushReplacementNamed(context, 'registro'),
          ),
            
        ],
      ),
    );
  }

 Widget _crearEmail(LoginBloc bloc) {

   return StreamBuilder(
     stream: bloc.emailStream,
     builder: (BuildContext context, AsyncSnapshot snapshot){
       return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.white,fontSize: 20.0),
            cursorColor: Colors.white,
            decoration: InputDecoration(
              fillColor: Colors.white,              
              suffixIcon: Icon(Icons.perm_identity, color: Colors.white,size: 40,),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white),),
              labelText: 'Usuario',
              focusColor: Colors.white,
              labelStyle: TextStyle(color: Colors.white, fontSize: 15.0,fontFamily: "Poppins-Bold",letterSpacing: 3.0),
              errorText: snapshot.error
            ),
            onChanged: (value)=>bloc.changeEmail(value),           
          )           
      );
     },
    );
 }

 Widget _crearPassword(LoginBloc bloc ) {

   return StreamBuilder(
    stream: bloc.passwordStream,
    builder: (BuildContext context, AsyncSnapshot snapshot){
    
      return Container(        
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          style: const TextStyle(color: Colors.white,fontSize: 20.0),
          cursorColor: Colors.white,
          obscureText: true,
          decoration: InputDecoration(
            fillColor: Colors.white,             
            suffixIcon: Icon(Icons.lock_outline,color: Colors.white,size: 35,),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            labelText: 'Contraseña',
            focusColor: Colors.white,
            labelStyle: TextStyle(color: Colors.white, fontSize: 15.0,fontFamily: "Poppins-Bold",letterSpacing: 3.0),
            errorText: snapshot.error
          ),
          onChanged: bloc.changePasword,
        )
      );    
    }
   );
 }

 Widget _crearBoton(LoginBloc bloc){

   return StreamBuilder(
     stream: bloc.formValidStream,
     builder: (BuildContext context, AsyncSnapshot snapshot){
       return GestureDetector(
        child: Container(
          decoration:BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xFF52bbbf),Color(0xFF259aca)]),
            borderRadius: BorderRadius.circular(6.0),
            boxShadow: [BoxShadow(color: Color(0xFF6078ea).withOpacity(.3), offset: Offset(0.0, 8.0), blurRadius: 8.0)]
          ),
          padding: EdgeInsets.symmetric(horizontal:90.0, vertical:15.0),
          child:Text('Ingresar', style: TextStyle(color: Colors.white,fontFamily: "Poppins-Bold", fontSize: 18,letterSpacing: 1.0),)
        ),
        onTap: snapshot.hasData ? ()=>_login(bloc, context) : null
      );
     }
   );   
 }

 _login(LoginBloc bloc, BuildContext context) async {

   Map info = await usuarioProvider.login(bloc.email, bloc.pass);

   if ( info['ok'] == true){
     Navigator.pushReplacementNamed(context, 'invernadero');
   }else{
     utils.mostrarAlerta(context, 'error');
   }

 }

}