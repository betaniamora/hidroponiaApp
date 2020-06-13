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
  String etapaCosecha = "1";
  String invernaderoSeleccionado = "1";
  List<DropdownMenuItem<String>> listaInve= new List();
   
   
  //TextEditingController _cantController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar('Nueva Cosecha'),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height:30.0),
            _tipoPlanta(),
            _cantidad(),
            _fecha(),
            _invernadero(),
            _etapaCosecha(),
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
          Row(
            children: <Widget>[
              Container(
                child: Text('Especie:', style: TextStyle(

                  fontSize: 18.0,
                  color: Colors.black
                  
                ),), 
                padding: EdgeInsets.only(left:25.0),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal:20.0, vertical: 20.0),
            child: DropdownButton(
              isExpanded: true,
              value: especie,
              items:lista,
              
              onChanged: (opt){      
                setState(() {
                  especie = opt;
                          
                });
              },
              style: TextStyle(inherit: false, color: Colors.blueGrey, decorationColor: Colors.white, fontSize: 18.0),
              
            ),
          ),
        ],
      );
  }

  Widget _cantidad() {

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              child: Text('Cantidad a Cosechar:', style: TextStyle(
                fontSize: 18.0,
                color: Colors.blueGrey),
              ), 
              padding: EdgeInsets.only(left:25.0),
            ),
          ],
        ),

        Container(
          padding: EdgeInsets.symmetric(horizontal:20.0, vertical: 20.0),
          child: TextFormField(
            initialValue: cantidad,
            keyboardType: TextInputType.number,
            cursorColor: Colors.blueGrey,
            decoration: InputDecoration(
              
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: Colors.amber,
                  style: BorderStyle.solid,
                ),
              )
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
        Row(
          children: <Widget>[
            Container(
                  child: Text('Fecha de Inicio:', style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.blueGrey),
                  ), 
                  padding: EdgeInsets.only(left:25.0),
                ),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal:20.0, vertical: 20.0),
          height: 100.0,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)
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
                  date = '${dates.day}/${dates.month}/${dates.year}';
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
                              color: Colors.blueGrey,
                            ),
                            Text(
                              "  $date",
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 18.0
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Icon(Icons.keyboard_arrow_right)
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
        Row(
          children: <Widget>[
            Container(
              child: Text('Invernadero:', style: TextStyle(
                fontSize: 18.0,
                color: Colors.blueGrey),
              ), 
              padding: EdgeInsets.only(left:25.0),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal:20.0, vertical: 20.0),
          child: FutureBuilder(
            future: _menuItemInve(),

            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return DropdownButton(
                isExpanded: true,
                value: invernaderoSeleccionado ,
                items: snapshot.data,
                onChanged: (opt){
                  setState(() {
                    invernaderoSeleccionado = opt;
                  });

                 // print(invernaderoSeleccionado);
                },
                style: TextStyle(inherit: false, color: Colors.blueGrey, decorationColor: Colors.white, fontSize: 18.0),
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

  Widget _etapaCosecha() {

    List<DropdownMenuItem<String>> lista = new List();
    lista.add(DropdownMenuItem(
      child: Text('Germinación'),
      value: '1' 
    ));
    lista.add(DropdownMenuItem(
      child: Text('Vegetativo'),
      value: '2' 
    ));
    lista.add(DropdownMenuItem(
      child: Text('Floración'),
      value: '3' 
    ));
      

      return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                child: Text('Etapa:', style: TextStyle(

                  fontSize: 18.0,
                  color: Colors.blueGrey
                  
                ),), 
                padding: EdgeInsets.only(left:25.0),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal:20.0, vertical: 20.0),
            child: DropdownButton(
              isExpanded: true,
              value: etapaCosecha,
              items:lista,
              onChanged: (opt){      
                setState(() {
                  etapaCosecha = opt;
                          
                });
              },
              style: TextStyle(inherit: false, color: Colors.blueGrey, decorationColor: Colors.white, fontSize: 18.0),
              
            ),
          ),
        ],
      );


  }

  Widget _aceptarCosecha() {

    final bloc = Provider.of(context);

   return GestureDetector(
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

          final respuesta = {

          '"even"':'"I"',
          '"esta"':'"$etapaCosecha"',
          '"obse"':'"Plantacion de lechuga mantecada"',
          '"cant"': int.parse(cantidad) ,
          '"fech_inic"':'"$date"',
          '"user"':'"${bloc.email}"',
          '"conf_plan"': int.parse(especie),
          '"inve_codi"': int.parse(invernaderoSeleccionado)

          };
          print(respuesta);

        }
      );
     }
    
 

  }
