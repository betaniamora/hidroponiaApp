import 'package:flutter/material.dart';
import 'package:formvalidation/src/blocs/provider.dart';
import 'package:formvalidation/src/providers/usuario_provider.dart' as usuarioProvider;
import 'package:formvalidation/src/providers/usuario_provider.dart';
import 'package:formvalidation/src/widgets/appbar.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AgregarCosecha extends StatefulWidget {
  
  @override
  _AgregarCosechaState createState() => _AgregarCosechaState();
}

class _AgregarCosechaState extends State<AgregarCosecha> {
  String especie= "1";
  String cantidad = "0";
  String date = "Elegir Fecha";
  String etapaCosecha = "S";
  String obsCosecha = "";
  String invernaderoSeleccionado = "1";
  List<DropdownMenuItem<String>> listaInve= new List();
  List<DropdownMenuItem<String>> listaConfPlants= new List();
   
   
  //TextEditingController _cantController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar('Nueva Cosecha'),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height:30.0),
            _invernadero(),
            _tipoPlanta(),
            _cantidad(),
            _observacion(),
            _etapaCosecha(),
            _fecha(),
            _aceptarCosecha()
            
          ],
        ),
      ),
    );
  }

  Widget _tipoPlanta() {
      
      List<DropdownMenuItem<String>> lista = new List();

      lista.add(DropdownMenuItem(
            child: Text('Lechuga'),
            value: '1' //aca tiene que ser mi id
          ));
      lista.add(DropdownMenuItem(
            child: Text('Rucula'),
            value: '2' //aca tiene que ser mi id
          ));

      return Column(
      children: <Widget>[
        
        Container(
          padding: EdgeInsets.symmetric(horizontal:20.0, vertical: 20.0),
          child: FutureBuilder(
            future: _menuItemConf(),

            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return DropdownButtonFormField(
                isExpanded: true,
                value: especie ,
                items: snapshot.data,
                hint: Text('Especie'),
                icon: Icon(Icons.keyboard_arrow_down,color:Color(0xFF259aca)),
            
                decoration: InputDecoration(
                  //focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide(color: Color(0xFF259aca))),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Color(0xFF259aca))),
           
            focusColor: Colors.grey,
            
                
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Color(0xFF259aca),
                  width: 0.5,
                  style: BorderStyle.solid,
                ),
              ),

            labelText: 'Especie', labelStyle: TextStyle(fontSize:16, color:Color(0xFF259aca), letterSpacing: 3),
                
                
                
              ),
               style: TextStyle(inherit: false, color: Colors.grey, decorationColor: Colors.white, fontSize: 16.0),
              onChanged: (opt){
                  setState(() {
                    especie = opt;
                  });
                }
              );
            },
          ),
        ),
      ],
    );


  }

  Widget _cantidad() {

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal:20.0, vertical: 20.0),
          child: TextField(
            //initialValue: cantidad,
            style: const TextStyle(color: Colors.grey, fontSize: 16.0),
            keyboardType: TextInputType.number,
            cursorColor: Colors.grey,

            
            decoration: InputDecoration(
              
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide(color: Color(0xFF259aca))),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Color(0xFF259aca))),
           
            focusColor: Colors.grey,
              
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Color(0xFF259aca),
                  width: 0.5,
                  style: BorderStyle.solid,
                ),
              ),
             
            labelText: 'Cantidad', labelStyle: TextStyle(fontSize:16, color:Color(0xFF259aca), letterSpacing: 3),
            ),
            
            onChanged: (value) {
              if(int.parse(value) == 0 || int.parse(value) < 0){
                showDialog(
                  context: context,
                  builder: (context){
                    return AlertDialog(
                      title: Text('Info'),
                      content: Text('El valor no puede ser 0 o inferior'),
                      actions: <Widget>[
                        FlatButton(
                          child:Text('Ok'),
                          onPressed:()=> Navigator.of(context).pop(),
                        )
                      ],
                    );
                  }
                );
              }else{
                setState(() {
                  cantidad= value;
                });
              }
            }),
        ),
      ],
    );


  }

  Widget _fecha() {

    return Column(
      children: <Widget>[
        
        Container(
          padding: EdgeInsets.symmetric(horizontal:20.0, vertical: 20.0),
          height: 100.0,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Color(0xFF259aca))
              
                
            ),
            elevation: 0.0,
            onPressed: () {
              DatePicker.showDatePicker(context,
                theme: DatePickerTheme(
                  containerHeight: 210.0,
                ),
                showTitleActions: true,
                minTime: DateTime(2000, 1, 1),
                maxTime: DateTime(2022, 12, 31), onConfirm: (dates) {
                  print('confirm $dates');
                  date = '${dates.day}-${dates.month}-${dates.year}';
                  setState(() {});
                }, 
                currentTime: DateTime.now(), locale: LocaleType.es);
            },
            child: Container(
              alignment: Alignment.center,
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.date_range,
                              size: 20.0,
                              color: Colors.grey,
                            ),
                            Text(
                              "  $date",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Icon(Icons.keyboard_arrow_down,color:Color(0xFF259aca))
                ],
              ),
            ),
            color: Colors.grey[50],
          ),
        ),
      ],
    );

  }

  Widget _invernadero() {

    _menuItemInve();
  
    return Column(
      children: <Widget>[
        
        Container(
          padding: EdgeInsets.symmetric(horizontal:20.0, vertical: 20.0),
          child: FutureBuilder(
            future: _menuItemInve(),

            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return DropdownButtonFormField(
                isExpanded: true,
                value: invernaderoSeleccionado ,
                items: snapshot.data,
                hint: Text('Invernadero'),
                icon: Icon(Icons.keyboard_arrow_down,color:Color(0xFF259aca)),
            
                decoration: InputDecoration(
                  //focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide(color: Color(0xFF259aca))),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Color(0xFF259aca))),
           
            focusColor: Colors.grey,
            
                
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Color(0xFF259aca),
                  width: 0.5,
                  style: BorderStyle.solid,
                ),
              ),

            labelText: 'Invernadero', labelStyle: TextStyle(fontSize:16, color:Color(0xFF259aca), letterSpacing: 3),
                
                
                
              ),
               style: TextStyle(inherit: false, color: Colors.grey, decorationColor: Colors.white, fontSize: 16.0),
              onChanged: (opt){
                  setState(() {
                    invernaderoSeleccionado = opt;
                  });
                }
              );
            },
          ),
        ),
      ],
    );

  }

 Future<List<DropdownMenuItem<String>>> _menuItemInve() async{
    final bloc = Provider.of(context);
    final lecturaProvider = new UsuarioProvider();

   final datos = await lecturaProvider.datosGeneral(bloc.email, bloc.pass);

   int cant = datos.data.inve.length;
   listaInve= [];

   for(int i=0 ; i < cant ; i++){

     listaInve.add(DropdownMenuItem(
            child: Text(datos.data.inve[i].inveDesc),
            value: (datos.data.inve[i].inveCodi).toString(), //aca tiene que ser mi id
          ));
   }

   print(listaInve);
   return listaInve;
  }

   Future<List<DropdownMenuItem<String>>> _menuItemConf() async{
    //final bloc = Provider.of(context);
    final lecturaProvider = new UsuarioProvider();

   final datos = await lecturaProvider.datosConfPlantas(context);

   int cant = datos.data.length;
   listaConfPlants= [];

   for(int i=0 ; i < cant ; i++){

     listaConfPlants.add(DropdownMenuItem(
            child: Text(datos.data[i].plantDesc),
            value: (datos.data[i].confCodi).toString()//aca tiene que ser mi id
          ));
   }

   //print(listaInve);
   return listaConfPlants;
  }

  Widget _etapaCosecha() {

    List<DropdownMenuItem<String>> lista = new List();
    lista.add(DropdownMenuItem(
      child: Text('Germinación'),
      value: 'S' 
    ));
    lista.add(DropdownMenuItem(
      child: Text('Vegetativo'),
      value: 'P' 
    ));
    lista.add(DropdownMenuItem(
      child: Text('Floración'),
      value: 'F' 
    ));
      

      return Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal:20.0, vertical: 20.0),
            child: DropdownButtonFormField(
              isExpanded: true,
              value: etapaCosecha,
              icon: Icon(Icons.keyboard_arrow_down, color:Color(0xFF259aca) ,),
              items:lista,
              onChanged: (opt){      
                setState(() {
                  etapaCosecha = opt;
                          
                });
              },
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide(color: Color(0xFF259aca))),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Color(0xFF259aca))),
           
            focusColor: Colors.grey,
            
                
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Color(0xFF259aca),
                  width: 0.5,
                  style: BorderStyle.solid,
                ),
              ),

            labelText: 'Etapa', labelStyle: TextStyle(fontSize:16, color:Color(0xFF259aca), letterSpacing: 3)
            ),
              style: TextStyle(inherit: false, color: Colors.grey, decorationColor: Colors.white, fontSize: 16.0),
              
            ),
          ),
        ],
      );


  }

  Widget _aceptarCosecha() {

   return Container(
     padding: EdgeInsets.only(bottom: 20),
     child: GestureDetector(
          child: Container(
            decoration:BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFF52bbbf),Color(0xFF259aca)]),
              borderRadius: BorderRadius.circular(6.0),
              boxShadow: [BoxShadow(color: Color(0xFF6078ea).withOpacity(.3), offset: Offset(0.0, 8.0), blurRadius: 8.0)]
            ),
            padding: EdgeInsets.symmetric(horizontal:90.0, vertical:15.0),
            child:Text('Aceptar', style: TextStyle(color: Colors.white,fontFamily: "Poppins-Bold", fontSize: 18,letterSpacing: 1.0),)
          ),
          onTap:(){

            if(date == "Elegir Fecha" || cantidad == "0"){
              showDialog(
                  context: context,
                  builder: (context){
                    return AlertDialog(
                      title: Text('Info'),
                      content: Text('Por favor Complete todos los campos.'),
                      actions: <Widget>[
                        FlatButton(
                          child:Text('Ok'),
                          onPressed:()=> Navigator.of(context).pop(),
                        )
                      ],
                    );
                  }
                );
            }
            else{
              
            _submit();
            
              
            }
            

          }
        ),
   );
     }

 Widget  _observacion() {

   

    return Column(
      children: <Widget>[
      
        Container(
          padding: EdgeInsets.symmetric(horizontal:20.0, vertical: 20.0),
          child: TextFormField(
            //initialValue: cantidad,
            style: const TextStyle(color: Colors.grey, fontSize: 16.0),
            keyboardType: TextInputType.text,
            cursorColor: Colors.blueGrey,
            decoration: InputDecoration(
              
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide(color: Color(0xFF259aca))),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Color(0xFF259aca))),
           
            focusColor: Colors.grey,
              
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Color(0xFF259aca),
                  width: 0.5,
                  style: BorderStyle.solid,
                ),
              ),
             
            labelText: 'Observacion', labelStyle: TextStyle(fontSize:16, color:Color(0xFF259aca), letterSpacing: 3),
            ),
            
            onChanged: (value) {
              
                setState(() {
                  obsCosecha= value;
                });
              
            }),
        ),
      ],
    );

 }

  void _submit() async{

    final lecturaProvider = new UsuarioProvider();
    final bloc = Provider.of(context);

    final respuesta = {

            "even":"I",
            "esta":"$etapaCosecha",
            "obse":"$obsCosecha",
            "fech_inic":"$date",
            "user":"${bloc.email}",
            "conf_plan": int.parse(especie),
            "cant": int.parse(cantidad) ,
            "inve_codi": int.parse(invernaderoSeleccionado)

            };
    print(respuesta);
    final resp = await lecturaProvider.addCosecha(respuesta);
    
    if (resp['code'] == "1"){
      showDialog(
                  context: context,
                  builder: (context){
                    return AlertDialog(
                      title: Text('Exito'),
                      content: Text('Datos Agregados Correctamente.'),
                      actions: <Widget>[
                        FlatButton(
                          child:Text('Ok'),
                          onPressed:()=> Navigator.pushNamed(context, 'dashboard'),
                        )
                      ],
                    );
                  }
                );
    }
    else{
      showDialog(
                  context: context,
                  builder: (context){
                    return AlertDialog(
                      title: Text('Error'),
                      content: Text('${resp['message']}'),
                      actions: <Widget>[
                        FlatButton(
                          child:Text('Ok'),
                          onPressed:()=> Navigator.of(context).pop(),
                        )
                      ],
                    );
                  }
                );

    }
    

            

  }
    


  }
