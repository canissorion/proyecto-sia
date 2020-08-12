import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sia_front/src/services/productos_service.dart';
import 'package:sia_front/src/utlis/utils.dart' as utils;
import 'package:sia_front/src/widgets/lista_productos.dart';
import 'package:http/http.dart' as http;

class Tab2Page extends StatefulWidget {

  @override
  _Tab2PageState createState() => _Tab2PageState();
}

class _Tab2PageState extends State<Tab2Page> {
  final formKey = GlobalKey<FormState>();

  String nombre;
  String categoria;
  String stock;
  String precio;

  @override
  Widget build(BuildContext context) {

    final productService = Provider.of<ProductService>(context);

    return Scaffold(
      body: ListaProductos( productService.product ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                            _crearNombre(),
                            _crearCategoria(),
                            _crearStock(),
                            _crearPrecio(),
                            SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                            _crearBoton(),
                          ],
                        ),
                      ),
                    ),
                  ]
                ),
              );
            }
          );
        },
        icon: Icon(Icons.add),
        label: Text('Agregar'),
      ),
    );
  }

  Widget _crearNombre(){
    return TextFormField(
      decoration: InputDecoration(
        labelText:  'Nombre del Producto'
      ),
      onSaved: (value) => nombre = value,
      validator: (value) {
        if ( value.length < 1){
          return 'Ingresse el nombre del producto';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearCategoria(){
    return TextFormField(
      decoration: InputDecoration(
        labelText:  'Categoria'
      ),
      onSaved: (value) => categoria = value,      
      validator: (value) {
        if ( value.length < 1){
          return 'Ingresse el nombre del producto';
        } else {
          return null;
        }
      },      
    );
  }

  Widget _crearPrecio(){
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText:  'Precio'
      ),
      onSaved: (value) => precio = value,
      validator: (value) {
        if ( utils.isNumeric(value) ){
          return null;
        } else {
          return 'Ingrese solo numeros';
        }
      },
    );
  }  

  Widget _crearStock(){
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText:  'Stock'
      ),
      onSaved: (value) => stock = value,
      validator: (value) {
        if ( utils.isNumeric(value) ){
          return null;
        } else {
          return 'Ingrese solo numeros';
        }
      },
    );
  }

  Widget _crearBoton(){
    return RaisedButton.icon(
      icon: Icon (Icons.check),
      label: Text('Guardar'),
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      color: Colors.deepPurple,
      onPressed: (){
        _submit();
      },
    );
  }

  void _submit(){
    if ( !formKey.currentState.validate() ) return;

    formKey.currentState.save();

    print('aquiiiiiii');
    print(nombre);

    final url = 'http://45.56.162.190:3001/api/productos';
    final productService = Provider.of<ProductService>(context, listen: false);
    http.post(url, headers: {
      'user-token' : 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c3VhcmlvSWQiOiJlOTQ2ODJhMi0xZTNlLTQxMzMtODI4My1iZjkxZjlmNmJjMDMiLCJjcmVhdGVkQXQiOjE1OTcxMTk5NzEsImV4cGlyZWRBdCI6MTU5NzI5Mjc3MX0.Xs0VMzrlVhKpMzl5-EyhueTwuddkVtCwqqBcnoPq5Dg'}, 
      body: {
        'nombre' : '$nombre',
        'precio' : '$precio',
        'categoria' : '$categoria',
        'stock' : '$stock',
      }
    ).then((value) => {
      productService.getProductos(),
      Navigator.of(context, rootNavigator: true).pop()
    });


  }
}