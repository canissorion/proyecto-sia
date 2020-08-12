import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:provider/provider.dart';
import 'package:sia_front/src/models/productos_models.dart';
import 'package:sia_front/src/services/productos_service.dart';
import 'package:sia_front/src/theme/tema.dart';
import 'package:http/http.dart' as http;

class ListaProductos extends StatelessWidget {

  final List<Productos> productos;

  const ListaProductos( this.productos );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 48),
      itemCount: this.productos.length,
      itemBuilder: (BuildContext context, int index) {
        return _Producto( productos: this.productos[index], index: index);
      },
    );
  }
}

class _Producto extends StatelessWidget {
  
  final Productos productos;
  final int index;

  const _Producto({
    @required this.productos, 
    @required this.index
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _TarjetaTopBar( productos, index)
      ],
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {

  final Productos productos;
  final int index;

  const _TarjetaTopBar( this.productos, this.index );

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
          Text('ID: ${productos.id}', 
            style: TextStyle(
              color: miTema.textSelectionColor,
              fontSize: MediaQuery.of(context).size.width*0.04
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width*0.04),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Nombre',
                style: TextStyle(
                  color: miTema.textSelectionColor,
                  fontWeight: FontWeight.w600,
                  fontSize: MediaQuery.of(context).size.width*0.04,
                ),
              ),
              Text('${productos.nombre}',
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
              Text('Precio',
                style: TextStyle(
                  color: miTema.textSelectionColor,
                  fontWeight: FontWeight.w600,
                  fontSize: MediaQuery.of(context).size.width*0.04,
                ),
              ),
              Text('${productos.precio}',
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
              Text('Stock',
                style: TextStyle(
                  color: miTema.textSelectionColor,
                  fontWeight: FontWeight.w600,
                  fontSize: MediaQuery.of(context).size.width*0.04,
                ),
              ),
              Text('${productos.stock}',
                style: TextStyle(
                  color: miTema.textSelectionColor,
                  fontSize: MediaQuery.of(context).size.width*0.04,
                ),
              ),              
            ],
          ),
          IconButton(
            icon: Icon(Icons.edit), 
            onPressed: (){
              showMaterialNumberPicker(
                context: context,
                title: "Cambiar Stock",
                maxNumber: 10000,
                minNumber: 0,
                selectedNumber: productos.stock,
                onChanged: (value){
                      final url = 'http://45.56.162.190:3001/api/productos/${productos.id}';
                      final productService = Provider.of<ProductService>(context, listen: false);

                      http.put(url, headers: {
                        'user-token' : 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c3VhcmlvSWQiOiJlOTQ2ODJhMi0xZTNlLTQxMzMtODI4My1iZjkxZjlmNmJjMDMiLCJjcmVhdGVkQXQiOjE1OTcxMTk5NzEsImV4cGlyZWRBdCI6MTU5NzI5Mjc3MX0.Xs0VMzrlVhKpMzl5-EyhueTwuddkVtCwqqBcnoPq5Dg'}, body: {'stock' : '$value' }
                      ).then((value) => {
                        productService.getProductos()
                      });
                },
              );             
            }
          ),                                                       
          Spacer(),         
          Container(width: MediaQuery.of(context).size.width*0.02)
        ],
      ),

    );
  }
}

