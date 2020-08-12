import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sia_front/src/services/order_service.dart';
import 'package:sia_front/src/services/productos_service.dart';
import 'package:sia_front/src/utlis/utils.dart' as utils;
import 'package:sia_front/src/widgets/lista_orders.dart';
import 'package:sia_front/src/widgets/lista_productos.dart';
import 'package:http/http.dart' as http;

class Tab3Page extends StatefulWidget {

  @override
  _Tab3PageState createState() => _Tab3PageState();
}

class _Tab3PageState extends State<Tab3Page> {
  final formKey = GlobalKey<FormState>();

  String nombre;
  String categoria;
  String stock;
  String precio;

  @override
  Widget build(BuildContext context) {

    final orderService = Provider.of<OrderService>(context);

    return Scaffold(
      body: ListaOrders( orderService.order ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
        },
        icon: Icon(Icons.add),
        label: Text('Agregar'),
      ),
    );
  }
}