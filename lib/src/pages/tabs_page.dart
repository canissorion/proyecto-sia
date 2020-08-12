import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sia_front/src/pages/tab1_page.dart';
import 'package:sia_front/src/pages/tab2_page.dart';
import 'package:sia_front/src/pages/tab3_page.dart';

class TabsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _NavegacionModel(),
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  const _Navegacion({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual,
      onTap: (i) => navegacionModel.paginaActual = i,
      items: [
        BottomNavigationBarItem( icon: Icon( Icons.home ), title: Text('Inicio') ),
        BottomNavigationBarItem( icon: Icon( Icons.fastfood ), title: Text('Productos') ),
        BottomNavigationBarItem( icon: Icon( Icons.shopping_cart), title: Text('Venta') ),
      ]
    );
  }
}

class _Paginas extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return PageView(
      controller: navegacionModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[

        Tab1Page(),

        Tab2Page(),

        Tab3Page()

      ],
    );
  }
}


class _NavegacionModel with ChangeNotifier{

  int _paginaActual = 0;
  PageController _pageController = new PageController();

  int get paginaActual => this._paginaActual;

  set paginaActual( int valor){
    this._paginaActual = valor;

    _pageController.animateToPage(valor, duration: Duration(milliseconds: 250), curve: Curves.easeInOut);

    notifyListeners();
  }

  PageController get pageController => this._pageController;

}