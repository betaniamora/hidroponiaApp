import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:formvalidation/src/blocs/provider.dart';
import 'package:formvalidation/src/models/datos_model.dart';
import 'package:formvalidation/src/providers/usuario_provider.dart';


class InvernaderoPage2 extends StatelessWidget {

  final usuarioProvider = new UsuarioProvider(); 

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Stack(
      
              children:<Widget>[
                _fondo(),
                Center(
                                  child: BackdropFilter(
                    filter: ImageFilter.blur( sigmaX: 10.0, sigmaY: 10.0 ),
                                    child: SingleChildScrollView(
                                      child: Column(
                        children:<Widget>[
                          SafeArea(child: 
                            Container(
                              padding: EdgeInsets.only(top:30,left: 25.0, right: 25.0),
                              child: Text('Elija un Invernadero para Comenzar',
                                style: TextStyle(color: Colors.white, fontSize: 25.0, fontWeight:FontWeight.bold),
                                textAlign: TextAlign.center,
                              )
                            )
                          ),
                          Center(child: _datos(context)),

                        ]
                        
                      ),
                    ),
                  ),
                )
                
              ] 
            )   
    );
    
    
  }

  Widget _datos(BuildContext context) {
    final bloc = Provider.of(context);

    //final datos = await usuarioProvider.datosGeneral(bloc.email, bloc.pass);

    return FutureBuilder(
      future: usuarioProvider.datosGeneral(bloc.email, bloc.pass),
      builder: (BuildContext context, AsyncSnapshot<DatosModel> snapshot) {
        if( snapshot.hasData ){
          return SafeArea(
            child:  GridView.builder(
              
              itemCount: snapshot.data.data.inve.length,
              scrollDirection:Axis.vertical,
              shrinkWrap: true,
              primary:false,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:2
              ),
              itemBuilder:(context,i){
                String nombre = snapshot.data.data.inve[i].inveDesc;
                return _crearItem(context,nombre,snapshot.data.data.inve[i].inveCodi);      
              },

            )
            
          );
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );

    
  }

  Widget _crearItem(BuildContext context, String datos, int key){
    final bloc = Provider.of(context);
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, 'dashboard', arguments: datos);
        bloc.changeInvernadero(key);
      },
      child:ClipRect(
          
          child: Container(
            height: 190.0,
            margin: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Color.fromRGBO(115, 115, 115, 0.5),
              borderRadius: BorderRadius.circular(20.0)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(
                  height:5.0
                ),
                Image(image:AssetImage('assets/hoja.png'),width: 60.0,),
                // CircleAvatar(
                //   radius: 40.0,
                //   backgroundColor: Colors.white,
                //   child: 
                // ),
                Text('$datos', style: TextStyle(color: Colors.white, fontSize: 20.0, letterSpacing: 3.0)),
                SizedBox(
                  height:5.0
                )
              ]
            ),
        ),
          
      
    )
    );   
  }

  Widget _fondo() {
    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin:FractionalOffset(0.0, 0.6) ,
          end: FractionalOffset(0.0, 1.0) ,
          colors: [
            Color.fromRGBO(0, 102, 102, 1.0),
            Color.fromRGBO(0 , 179, 179, 1.0),
          ]
        )
      ),
    );

    final cajaRosa = Transform.rotate(
        angle: -pi / 5.0,
        child:Container(
          height: 280.0,
          width: 280.0,
          decoration: BoxDecoration(
            color: Colors.pink,
            borderRadius: BorderRadius.circular(80.0),
            gradient: LinearGradient(
              colors:[
                Color.fromRGBO(236, 98, 188, 1.0),
                Color.fromRGBO(230, 142, 172, 1.0)
              ] 
            )
          ),
        )
      );
    
    return Stack(
      children: <Widget>[
        Container(width: double.infinity,
      height: double.infinity,child: Image(image: AssetImage('assets/lettuce.jpg', ),fit: BoxFit.cover, width: double.infinity, height: double.infinity,))
        //gradiente,
        // Positioned(
        //   top: -100.0,
        //   child:cajaRosa,
        // ),
        
      ],
    );
  }

}
