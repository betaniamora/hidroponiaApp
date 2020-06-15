import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/conf_plant_model.dart';
import 'package:formvalidation/src/models/lista_cosecha_model.dart';

class CosechasHorizontal extends StatelessWidget {
  final ListaCosechasModel cosechas ;
  //final Function siguientePagina;
  CosechasHorizontal({ @required this.cosechas,
                    //@required this.siguientePagina
    });

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.7
  );
  
  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;
    _pageController.addListener((){
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200){
        //siguientePagina();
      }
    });


    return Container(
      
      height: _screenSize.height * 0.25,
      width: double.infinity,
      
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: cosechas.data.length,
        itemBuilder: (context, i){
          var envio = cosechas.data[i];
          return _tarjeta(context, envio);
        },
        //children: _tarjetas(context),
      ),
    );

  }
Widget _tarjeta(BuildContext context, var cose){
var fecha;
var fase1;
var fase2;
  String desc= cose.desc;
  if(cose.fase1 == ""){
    fase1 ="";
    print("fase 1 vacia");
  }else{
    fecha= DateTime.parse(cose.fase1);
    fase1 = formatDate(fecha, [dd, '/', mm, '/', yyyy]);
  }
  if(cose.fase2 == ""){
    fase2 ="";
  }else{
    fecha= DateTime.parse(cose.fase2);
    fase2 = formatDate(fecha, [dd, '/', mm, '/', yyyy]);
  }
  
  
  var fase3 = formatDate(cose.fase3, [dd, '/', mm, '/', yyyy]);
  var fase4 = formatDate(cose.fase4, [dd, '/', mm, '/', yyyy]);
  //desc= desc.replaceAll('Desc.', '');
  final tarjeta = Container(
      //width: 400,
       //margin: EdgeInsets.only(right: 5.0),
       child: Column(
         children: <Widget>[
           Container(
             width: 500,
             child: Card(
                        
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Container(
                        
                  
                  height: 175,
                  child:Container(
                    padding: EdgeInsets.symmetric(vertical:5.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(left:15),
                                          height: 48,
                                          width: 2,
                                          decoration: BoxDecoration(
                                            color: Colors.teal,
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
                                                  desc,
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
                                                    child: Image(image: AssetImage('assets/leaves_small.png')),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 4, bottom: 3),
                                                    child: Text(
                                                      '${cose.cant}',
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
                                                      'Un.',
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
                                    Container(
                                      child:Column(
                                       crossAxisAlignment: CrossAxisAlignment.center,
                                        
                                        children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(),
                                          
                                          child: Text('Mesa Nº 3', style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold),)),
                                        Container(
                                          margin: EdgeInsets.symmetric(horizontal:40,vertical: 5),
                                          child: Row(
                                            children: <Widget>[
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Text('Semillero:', style: TextStyle(color:Colors.grey, fontWeight: FontWeight.bold),),

                                                  Text('$fase1', style: TextStyle(color:Colors.black26),),
                                                ],
                                              ),
                                              SizedBox(width: 35,),
                                              Column(
                                                children: <Widget>[
                                                  Text('Plantula:', style: TextStyle(color:Colors.grey, fontWeight: FontWeight.bold),),
                                                  Text('$fase2', style: TextStyle(color:Colors.black26),),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(horizontal:40,vertical: 5),
                                          child: Row(
                                            children: <Widget>[
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text('Floracion:', style: TextStyle(color:Colors.grey, fontWeight: FontWeight.bold),),

                                                  Text('$fase3', style: TextStyle(color:Colors.black26,),),
                                                ],
                                              ),
                                              SizedBox(width: 35,),
                                              Column(
                                                children: <Widget>[
                                                  Text('Cosecha:', style: TextStyle(color:Colors.grey, fontWeight: FontWeight.bold),),
                                                  Text('$fase4', style: TextStyle(color:Colors.black26),),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),

                                      ],)
                                    )
                        
                      ],
                    ),
                  ),
                 // color: Colors.tealAccent,
                ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        margin: EdgeInsets.all(10),
                      ),
             
        
           ),
           
           //SizedBox(height: 5.0),
          //  Text(
          //    "prueba",
          //    overflow: TextOverflow.ellipsis,
          //    style: Theme.of(context).textTheme.caption,
          //  )
         ],
       ),

     );

     return GestureDetector(
       child: tarjeta,
       onTap: (){
         Navigator.pushNamed(context, 'nueva_cosecha');
         //print ('ID de la pelicula ${pelicula.id}');
       },
     );
}

 


//  List<Widget> _tarjetas(BuildContext context){

//    return peliculas.map( (pelicula) {

//      return Container(

//        margin: EdgeInsets.only(right: 15.0),
//        child: Column(
//          children: <Widget>[
//            ClipRRect(
//              borderRadius: BorderRadius.circular(20.0),
//              child: FadeInImage(
//                placeholder: AssetImage('assets/img/no-image.jpg'), 
//                image: NetworkImage(pelicula.getPosterImg()),
//                fit: BoxFit.cover,
//                height: 130.0,
//               ),
//            ),
//            SizedBox(height: 5.0),
//            Text(
//              pelicula.title,
//              overflow: TextOverflow.ellipsis,
//              style: Theme.of(context).textTheme.caption,
//            )
//          ],
//        ),

//      );

//  }).toList();

// }
}