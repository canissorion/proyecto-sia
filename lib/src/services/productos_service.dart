import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sia_front/src/models/productos_models.dart';
import 'package:http/http.dart' as http;


class ProductService with ChangeNotifier {

  String _token='';

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return _token = (prefs.getString('token')??'');
  }

  List<Productos> product = [];

  ProductService() {

    this.getProductos();

  }

  getProductos() async{

    String url;
    Response resp;
    List <Productos> productResponse;

    _loadCounter().then((value) async => {
      
      url = 'http://45.56.162.190:3001/api/productos',

      resp = await http.get(url, headers: {'user-token' : '$value'}),
      

      print('aqui esta el token'),
      print(value),
      print(resp.body),

      productResponse = productosFromJson( resp.body ),

      this.product = productResponse,
      print(productResponse[0].nombre),
      notifyListeners(),
    });

  }

}