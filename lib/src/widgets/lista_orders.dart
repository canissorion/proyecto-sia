import 'package:flutter/material.dart';
import 'package:sia_front/src/models/order_models.dart';
import 'package:sia_front/src/theme/tema.dart';
import 'package:http/http.dart' as http;

class ListaOrders extends StatelessWidget {

  final List<Order> order;

  const ListaOrders( this.order );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 48),
      itemCount: this.order.length,
      itemBuilder: (BuildContext context, int index) {
        return _Order( orders: this.order[index], index: index);
      },
    );
  }
}

class _Order extends StatelessWidget {
  
  final Order orders;
  final int index;

  const _Order({
    @required this.orders, 
    @required this.index
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _TarjetaTopBar( orders, index)
      ],
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {

  final Order orders;
  final int index;

  const _TarjetaTopBar( this.orders, this.index );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.indigo[50],
        border: Border(
          bottom: BorderSide(
            color: Colors.indigo[200],
            width: 1,
          )
        )
      ),
      padding: EdgeInsets.symmetric( horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('ID: ${orders.orderId}', 
            style: TextStyle(
              color: miTema.textSelectionColor,
              fontSize: MediaQuery.of(context).size.width*0.04
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width*0.04),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Pago',
                style: TextStyle(
                  color: miTema.textSelectionColor,
                  fontWeight: FontWeight.w600,
                  fontSize: MediaQuery.of(context).size.width*0.04,
                ),
              ),
              Text('${orders.totalPago}',
                style: TextStyle(
                  color: miTema.textSelectionColor,
                  fontSize: MediaQuery.of(context).size.width*0.04,
                ),
              ),              
            ],
          ),
          SizedBox(width: MediaQuery.of(context).size.width*0.04), 
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Fecha',
                style: TextStyle(
                  color: miTema.textSelectionColor,
                  fontWeight: FontWeight.w600,
                  fontSize: MediaQuery.of(context).size.width*0.04,
                ),
              ),
              Text('${orders.orderDate.day} / ${orders.orderDate.month} / ${orders.orderDate.year}',
              overflow: TextOverflow.fade,
                style: TextStyle(
                  color: miTema.textSelectionColor,
                  fontSize: MediaQuery.of(context).size.width*0.04,
                ),
              ),              
            ],
          ),                                                    
          Spacer(),         
          Container(width: MediaQuery.of(context).size.width*0.02)
        ],
      ),

    );
  }
}

