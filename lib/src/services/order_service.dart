import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sia_front/src/models/order_models.dart';
import 'package:http/http.dart' as http;


class OrderService with ChangeNotifier {

  List<Order> order = [];

  String _token='';

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return _token = (prefs.getString('token')??'');
  }

  OrderService() {

    this.getOrders();

  }

  getOrders() async{

    String url;
    Response resp;
    List<Order> orderResponse;

    _loadCounter().then((value) async => {
      url = 'http://45.56.162.190:3001/api/order',
      resp = await  http.get(
        url, 
        headers: {'user-token' : '$value'}
      ),

      print(resp.body),
      orderResponse = orderFromJson( resp.body ),

      this.order = orderResponse,
      print(orderResponse[0].totalPago),
      notifyListeners()

    });

  }

}