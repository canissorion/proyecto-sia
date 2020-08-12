import 'package:flutter/material.dart';
import 'package:sia_front/src/models/productos_models.dart';
import 'package:http/http.dart' as http;


class ProductService with ChangeNotifier {

  List<Productos> product = [];

  ProductService() {

    this.getProductos();

  }

  getProductos() async{

    final url = 'http://45.56.162.190:3001/api/productos';

    final resp = await  http.get(url, headers: {'user-token' : 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c3VhcmlvSWQiOiJlOTQ2ODJhMi0xZTNlLTQxMzMtODI4My1iZjkxZjlmNmJjMDMiLCJjcmVhdGVkQXQiOjE1OTcxMTk5NzEsImV4cGlyZWRBdCI6MTU5NzI5Mjc3MX0.Xs0VMzrlVhKpMzl5-EyhueTwuddkVtCwqqBcnoPq5Dg'});
    
    print(resp.body);

    final productResponse = productosFromJson( resp.body );

    this.product = productResponse;
    print(productResponse[0].nombre);
    notifyListeners();

  }

}