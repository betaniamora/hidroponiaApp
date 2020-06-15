import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:formvalidation/src/blocs/provider.dart';
import 'package:formvalidation/src/models/lectura_model.dart';
import 'package:formvalidation/src/models/lista_cosecha_model.dart';
import 'package:formvalidation/src/pages/wave_view.dart';
import 'package:formvalidation/src/providers/usuario_provider.dart';
import 'package:formvalidation/src/widgets/appbar.dart';
import 'package:formvalidation/src/widgets/cosecha_list.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'liquid_script.dart' show liquidScript;

class DashboardPage extends StatefulWidget {
  

  @override
  _DashboardPageState createState() => _DashboardPageState();

}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    final invernadero  = ModalRoute.of(context).settings.arguments.toString();
    return Scaffold(
      drawer: Drawer(),
      appBar: appbar('${bloc.invernaderoName}'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
           Navigator.pushNamed(context, 'nueva_cosecha');
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF52bbbf),
      ),
      body: 
          SingleChildScrollView(
                      child: Column(
                children:<Widget>[

                  Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      _titulo('CLIMA'),
                      
                      Card(
                        
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                        children:<Widget>[
                          Container(
                            width:200.0,
                            child: climaDatos(),
                          ),
                          temperatura(),
                        ]
                      ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        margin: EdgeInsets.all(10),
                      ),
                      _titulo('AGUA'),
                      Card(
                        
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                        children:<Widget>[
                          
                          nivelAgua(),
                        ]
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        margin: EdgeInsets.all(10),
                      ),

                      

                      

                    ] 
                  ),
                  _footer(context),
                  
                ]
              ),
          ),
        
      //backgroundColor: Color.fromRGBO(230, 230, 230, 1),
    );
  }


  Widget temperatura(){

    final lecturaProvider = new UsuarioProvider();

    return FutureBuilder(
      future: lecturaProvider.datosLectura(context),
      builder: (BuildContext context, AsyncSnapshot<LecturaModel> snapshot) {
        if(snapshot.hasData){

         
          double lecturaTemp;
          int cont = snapshot.data.data.clima.length;

          for(int i = 0; i < cont ; i++){

            if(snapshot.data.data.clima[i].tipoCodi == 1){
               lecturaTemp = snapshot.data.data.clima[i].detaValueLeid;
            }

          }

          return Container(
            width: 170,
            height: 200,
            child: SfRadialGauge(
                        key: UniqueKey() ,
                          enableLoadingAnimation: true,
                          axes: <RadialAxis>[
                            RadialAxis(
                                             
                                showLabels: false,
                                showTicks: false,
                                radiusFactor: 0.8,
                                minimum: 0,
                                maximum: 50,
                                axisLineStyle:
                                    AxisLineStyle(thickness: 0.05,
                  thicknessUnit: GaugeSizeUnit.factor,),
                                annotations: <GaugeAnnotation>[
                                  GaugeAnnotation(
                                        angle: 90,
                                        positionFactor: 0,
                                        widget: Column(
                                          children: <Widget>[
                                            Text('$lecturaTemp ºC',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 20)),
                                            // Padding(
                                            //   padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                                            //   child: Text(
                                            //     'Temperatura',
                                            //     style: TextStyle(
                                            //         fontWeight: FontWeight.bold,
                                            //         fontStyle: FontStyle.italic,
                                            //         fontSize: 20),
                                            //   ),
                                            // )
                                          ],
                                        )),
                                  GaugeAnnotation(
                                        angle: 124,
                                        positionFactor: 1.1,
                                        widget: Container(
                                          child: Text('0',
                                              style: TextStyle(fontSize: 14)),
                                        )),
                                  GaugeAnnotation(
                                        angle: 54,
                                        positionFactor: 1.1,
                                        widget: Container(
                                          child: Text('50',
                                              style: TextStyle(fontSize: 14)),
                                        )),
                                ],
                                pointers: <GaugePointer>[
                                  RangePointer(
                                    value: lecturaTemp,
                                    width: 18,
                                    pointerOffset: -3,
                                    cornerStyle: CornerStyle.bothCurve,
                                    color: const Color(0xFFF67280),
                                    gradient: SweepGradient(
                                              colors: <Color>[Color(0xFF52bbbf),Color(0xFF259aca)],
                                              stops: <double>[0.40, 0.70]),
                                  ),
                                  MarkerPointer(
                                    value: lecturaTemp,
                                    color: Colors.white,
                                    markerType: MarkerType.circle,
                                  ),
                                ]),
                          ],
                        ),
          );

        }else{
          return CircularProgressIndicator();
        }
      },
    );

  }

  Widget climaDatos() {
final lecturaProvider = new UsuarioProvider();
    return FutureBuilder(
      future: lecturaProvider.datosLectura(context),
      builder: (BuildContext context, AsyncSnapshot<LecturaModel> snapshot) {
        if(snapshot.hasData){

          double lecturaHum;
           double lecturaUv;
           double lecturaCo2;
          int cont = snapshot.data.data.clima.length;

          for(int i = 0; i < cont ; i++){

            if(snapshot.data.data.clima[i].tipoCodi == 4){
               lecturaHum = snapshot.data.data.clima[i].detaValueLeid;
            }
            if(snapshot.data.data.clima[i].tipoCodi == 5){
               lecturaUv = snapshot.data.data.clima[i].detaValueLeid;
            }
            if(snapshot.data.data.clima[i].tipoCodi == 6){
               lecturaCo2 = snapshot.data.data.clima[i].detaValueLeid;
            }
          }
          return Column(
              children: <Widget>[
                
                ListTile(
                  leading: Icon(Icons.cloud),
                  title: Text('Humedad: $lecturaHum %', style: TextStyle(fontSize: 14.4),),
                ),
                //Container( padding: EdgeInsets.only(left:20.0),child: Divider(color: Colors.black,thickness:0.2 ,)),
                ListTile(
                  leading: Icon(Icons.wb_sunny),
                  title: Text('UV: $lecturaUv',style: TextStyle(fontSize: 14.4),),
                ),
                ListTile(
                  leading: Icon(Icons.toys ),
                  title: Text('Co2: $lecturaCo2 ppm', style: TextStyle(fontSize: 14.4),),
                ),

              ],

            );


        }else{
          return CircularProgressIndicator();
        }
      },
    );

  }

  Widget _titulo(String titulo) {

   return  Container(
      child: 
        ListTile(
          title: Text('$titulo', style: GoogleFonts.notoSans(
            fontSize: 20.0,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500
            )                            
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: (){},
        ),
   );


  }

  Widget nivelAgua() {
final lecturaProvider = new UsuarioProvider();
    return FutureBuilder(
      future: lecturaProvider.datosLectura(context),
      builder: (BuildContext context, AsyncSnapshot<LecturaModel> snapshot) {
        if(snapshot.hasData){

          double lecturaNivel;
          double lecturaPh;
          double lecturaTds;
          double lecturaTemp;
          double lecturaNivelA;
          double lecturaNivelB;
          double tempA;
          double tempB;
          double tempS;
          Color colorPh = Color(0xFF259aca);
          Color colorTds = Colors.grey;
          Color colorTemp = Colors.green[300];
          Icon iconTds = Icon(Icons.linear_scale, color: Colors.grey[600],);
          Icon iconPh = Icon(Icons.invert_colors, color: Colors.grey[600]);
          Icon iconTemp = Icon(Icons.av_timer, color: Colors.grey[600]);
          int cont = snapshot.data.data.agua.length;

          for(int i = 0; i < cont ; i++){

            if(snapshot.data.data.agua[i].tipoCodi == 9){
              if(snapshot.data.data.agua[i].equiUbic == 'TANQUE A'){
                lecturaNivel = snapshot.data.data.agua[i].detaValueLeid;
                lecturaNivel = lecturaNivel*100/500;
              }
               
            }
            if(snapshot.data.data.agua[i].tipoCodi == 7){
                lecturaPh = snapshot.data.data.agua[i].detaValueLeid;
            }
            if(snapshot.data.data.agua[i].tipoCodi == 8){
                lecturaTds = snapshot.data.data.agua[i].detaValueLeid;
            }
            if(snapshot.data.data.agua[i].tipoCodi == 2){
              if(snapshot.data.data.agua[i].equiUbic == 'TANQUE A'){
                lecturaTemp = snapshot.data.data.agua[i].detaValueLeid;
              }
               
            }
            if(snapshot.data.data.agua[i].tipoCodi == 9){
              if(snapshot.data.data.agua[i].equiUbic == 'SOLUCION A'){
                lecturaNivelA = snapshot.data.data.agua[i].detaValueLeid;
              }
            }
            if(snapshot.data.data.agua[i].tipoCodi == 9){
              if(snapshot.data.data.agua[i].equiUbic == 'SOLUCION B'){
                lecturaNivelB = snapshot.data.data.agua[i].detaValueLeid;
              }
            }
            if(snapshot.data.data.agua[i].tipoCodi == 2){
              if(snapshot.data.data.agua[i].equiUbic == 'SOLUCION A'){
                tempA = snapshot.data.data.agua[i].detaValueLeid;
              }
            }
            if(snapshot.data.data.agua[i].tipoCodi == 2){
              if(snapshot.data.data.agua[i].equiUbic == 'SOLUCION B'){
                tempB = snapshot.data.data.agua[i].detaValueLeid;
              }
            }
            if(snapshot.data.data.agua[i].tipoCodi == 2){
              if(snapshot.data.data.agua[i].equiUbic == 'SALIDA TANQUE'){
                tempS = snapshot.data.data.agua[i].detaValueLeid;
              }
            }
          }
          return Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical:12.0),
                child: Text('TANQUE "A"', style: TextStyle(color: Colors.grey[700], fontSize: 15, fontWeight: FontWeight.w500),)),
              Row(
                children: <Widget>[
            Container(
              width: 200,
              padding: EdgeInsets.only(bottom:20.0),
              child: Column(
                children: <Widget>[
                  
                  _datos(lecturaPh,'pH','pH', colorPh, iconPh),
                  _datos(lecturaTds,'TDS','ppm', colorTds, iconTds),
                  _datos(lecturaTemp,'Temperatura','ºC', colorTemp, iconTemp),
                 

                ],

              ),
            ),
                  
            Column(
              children: <Widget>[
                Padding(
                                      padding: const EdgeInsets.only(left: 70, right: 8, top: 10, bottom: 10),
                                      child: Container(
                                        width: 80,
                                        height: 160,
                                        decoration: BoxDecoration(
                                          color: Color(0xfff2f2f2),
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(80.0),
                                              bottomLeft: Radius.circular(80.0),
                                              bottomRight: Radius.circular(80.0),
                                              topRight: Radius.circular(80.0)),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(color: Colors.grey.withOpacity(0.4), offset: const Offset(2, 2), blurRadius: 4),
                                          ],
                                        ),
                                        child: WaveView(
                                          percentageValue: lecturaNivel,
                                        ),
                                      ),
                                    ),
                Container(
                  padding: EdgeInsets.only(bottom:20, left:55),
                  child: Center(child: Text('Nivel de Agua', style: TextStyle(color: Colors.grey),)))
              ],
            ),
            
            
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 50),
                                          height: 0.5,
                                          width: 330,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[400],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4.0)),
                                          ),
                                        ),
            
            Container(
              padding: EdgeInsets.symmetric(vertical:15),
              child: Row(
                children:<Widget>[
                  _soluciones('Solución A', lecturaNivelA, tempA, Color(0xFF008080), Color(0xFF00e6e6)),
                  _soluciones('Solución B', lecturaNivelB, tempB, Color(0xFF008080), Color(0xFF00e6e6)),
                  _temperaturaSaliente(tempS)
                ]
              ),
            )
            ],
          );


        }else{
          return CircularProgressIndicator();
        }
      },
    );

  }

  Widget _datos(double lectura, String titulo, String unidad, Color color, Icon icono) {

    return Container(
      padding: EdgeInsets.only(left:20),
      child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          height: 48,
                                          width: 2,
                                          decoration: BoxDecoration(
                                            color: color,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4.0)),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4, bottom: 2),
                                                child: Text(
                                                  '$titulo',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    letterSpacing: -0.1,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: 25,
                                                    height: 25, 
                                                    child: icono,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 4, bottom: 3),
                                                    child: Text(
                                                      '$lectura',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16,
                                                        color: Colors.black
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 4, bottom: 3),
                                                    child: Text(
                                                      '$unidad',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12,
                                                        letterSpacing: -0.2,
                                                        color: Colors
                                                            .grey
                                                            .withOpacity(0.5),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ]
                                    ),
                                  ]
      ),
    );

  }

  Widget _soluciones(String titulo, double valorTanque, double temp, Color color1, Color color2 ) {

    var porcentaje= (valorTanque * 100 / 20);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 19),
      child: Column(
                                //mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '$titulo',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      letterSpacing: -0.2,
                                      color: Colors.black
                                    ),
                                  ),
                                  Text(
                                    '$porcentaje%',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      letterSpacing: -0.2,
                                      color: Colors.black
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Container(
                                      height: 4,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        color:Colors.grey.withOpacity(0.3),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.0)),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: (valorTanque * 80 / 20),
                                            height: 4,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(colors: [
                                                Colors.teal[100],
                                                color1
                                                    .withOpacity(0.5),
                                              ]),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4.0)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Text(
                                      '$temp ºC',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: Colors.grey
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
    );

  }

  Widget _temperaturaSaliente(double temp) {

    return Container(
      padding: EdgeInsets.only(left:20,),
      child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Temperatura',textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      letterSpacing: -0.2,
                                      color: Colors.black
                                    )),
            Text('de Salida',textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      letterSpacing: -0.2,
                                      color: Colors.black
                                    )),
            Text('$temp ºC', textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      letterSpacing: -0.2,
                                      color: Colors.grey
                                    ))
          ],
      ),
    );

  }

Widget _footer(BuildContext context){
  final usuariosProvider = new UsuarioProvider();
  // peliculasProvider.getPopulares();
  return Container(
    width: double.infinity,
    child: Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          //padding: EdgeInsets.only(left:20.0),
          child: _titulo('COSECHAS'),
        ),
       // SizedBox(height:5.0),

        FutureBuilder(
          future: usuariosProvider.listaCosecha(context),
          builder: (BuildContext context, AsyncSnapshot<ListaCosechasModel> snapshot) {
            if(snapshot.hasData){
              return CosechasHorizontal(
                cosechas: (snapshot.data));
            }else{
              return Center(child: CircularProgressIndicator());
            }
          },
        ),

      ],
    ),
  );
}

}