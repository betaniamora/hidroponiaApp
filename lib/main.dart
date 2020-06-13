

import 'package:flutter/material.dart';
import 'package:formvalidation/src/blocs/provider.dart';
import 'package:formvalidation/src/pages/agregar_cosecha.dart';
import 'package:formvalidation/src/pages/dashboard_page.dart';
import 'package:formvalidation/src/pages/home_page.dart';
import 'package:formvalidation/src/pages/invernadero2_page.dart';
import 'package:formvalidation/src/pages/login_page.dart';
import 'package:formvalidation/src/pages/producto_page.dart';
import 'package:formvalidation/src/pages/registro_page.dart';
import 'package:formvalidation/src/preferencias_usuario/referencias_usuario.dart';
 
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
    await prefs.initPrefs();
  runApp(MyApp());
  
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      final prefs = new PreferenciasUsuario();

   // print(prefs.token);
    return Provider(
      child:MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        routes: {
          'login'         : (BuildContext context) => LoginPage(),
          'home'          : (BuildContext context) => HomePage(),
          'producto'      : (BuildContext context) => ProductoPage(),
          'registro'      : (BuildContext context) => RegistroPage(),
          'dashboard'     : (BuildContext context) => DashboardPage(),
          'invernadero'   : (BuildContext context) => InvernaderoPage2(),
          'nueva_cosecha' : (BuildContext context) => AgregarCosecha(),

        },

        theme: ThemeData(
          primaryColor: Color.fromRGBO(0, 126, 126, 1),
        ),

      )
    );
    
    
    
    
  }

 
}

 class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}