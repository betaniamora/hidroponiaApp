import 'package:flutter/material.dart';
import 'package:formvalidation/src/blocs/provider.dart';
import 'package:formvalidation/src/models/datos_model.dart';
import 'package:formvalidation/src/providers/usuario_provider.dart';
import 'package:flutter/src/rendering/box.dart';


class InvernaderoPage extends StatelessWidget {

  final usuarioProvider = new UsuarioProvider(); 

  @override
  Widget build(BuildContext context) {
    
    return Stack(
              children:<Widget>[
                Image(image: AssetImage('assets/invernadero.jpg'),fit: BoxFit.cover, width: double.infinity, height: double.infinity,),
                _datos(context)
              ] 
            );    
  }

  Widget _datos(BuildContext context) {
    final bloc = Provider.of(context);

    //final datos = await usuarioProvider.datosGeneral(bloc.email, bloc.pass);

    final size = MediaQuery.of(context).size;

    return FutureBuilder(
      future: usuarioProvider.datosGeneral(bloc.email, bloc.pass),
      builder: (BuildContext context, AsyncSnapshot<DatosModel> snapshot) {
        if( snapshot.hasData ){
          final inver = snapshot.data.data.inve;
          return SafeArea(
            child: Container(
                width: 380.0,
                padding: EdgeInsets.only(top:100.0,left: 40.0),
                 child: ListView.builder(
                  itemCount: inver.length,
                  itemBuilder: (context,i){
                    String nombre = snapshot.data.data.inve[i].inveDesc;
                    return _crearItem(context,nombre,snapshot.data.data.inve[i].inveCodi);      
                  },
                ),
            ),
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
      child: Container(           
        padding: EdgeInsets.symmetric(horizontal:20.0, vertical:10.0),
        height: 190.0,
        width: 200.0,
        child: Card(
          color: Color.fromRGBO(0,26, 26, 0.2),        
          child: Column(
            children: <Widget>[
              SizedBox(height:35.0),
              Image(image:AssetImage('assets/smartGrande.png'), width: 70.0,),
              SizedBox(height:10.0),
              Center(child: Text('$datos', style: TextStyle(fontSize: 30.0, color: Colors.white))),                  
            ],
          )           
        ),
      ),
    );   
  }

}


// return Container(
//       padding: EdgeInsets.all(20.0),
//       height: 200.0,
//           child: Card(
//         elevation: 4.0,
//             child: ListTile(
//           leading: Image(image:AssetImage('assets/smartGrande.png')),
//           title: Text('$datos'),
//           trailing: Icon(Icons.keyboard_arrow_right, size:30.0),
//           onTap: (){
//            // Navigator.pushNamed(context, routeName)
//           },
          
//         ),
//       ),
//     );