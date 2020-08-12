import 'package:flutter/material.dart';
import 'package:sia_front/src/models/order_models.dart';
import 'package:http/http.dart' as http;


class OrderService with ChangeNotifier {

  List<Order> order = [];

  OrderService() {

    this.getOrders();

  }

  getOrders() async{

    final url = 'http://45.56.162.190:3001/api/order';

    final resp = await  http.get(url, headers: {'user-token' : 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c3VhcmlvSWQiOiJlOTQ2ODJhMi0xZTNlLTQxMzMtODI4My1iZjkxZjlmNmJjMDMiLCJjcmVhdGVkQXQiOjE1OTcxMTk5NzEsImV4cGlyZWRBdCI6MTU5NzI5Mjc3MX0.Xs0VMzrlVhKpMzl5-EyhueTwuddkVtCwqqBcnoPq5Dg'});
    
    print(resp.body);

    final orderResponse = orderFromJson( resp.body );

    this.order = orderResponse;
    print(orderResponse[0].totalPago);
    notifyListeners();

  }

}