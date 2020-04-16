import 'package:flutter/material.dart';
import 'package:logisena/src/bloc/login_bloc.dart';
import 'package:logisena/src/bloc/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context),
        ],
      )
    );
  }

  Widget _crearFondo(context) {

    final size = MediaQuery.of(context).size;

    final fondoRojo = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color> [
            Color.fromRGBO(120, 19, 21, 1.0),
            Color.fromRGBO(220, 70, 70, 1.0)
          ]
        )
      ),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90.0),
        color: Color.fromRGBO(255, 255, 255, 0.08)
      ),
    );

    return Stack(
      children: <Widget>[
        fondoRojo,
        Positioned( top: 90.0, left: 30.0, child: circulo ),
        Positioned( top: -40.0, right: -10.0, child: circulo ),
        Positioned( bottom: -50.0, right: -10.0, child: circulo ),
        Positioned( bottom: 120.0, left: 20.0, child: circulo ),
        Positioned( bottom: -50.0, left: -20.0, child: circulo ),

        Container(
          padding: EdgeInsets.only( top: size.height * 0.1 ),
          child: Column(
            children: <Widget>[
              Image(
                image: AssetImage('assets/logisena-logo.png'),
                height: 100.0,
              ),
              SizedBox( height: 10.0, width: double.infinity) ,
            ],
          ),
        )
        
      ],
    );
  }

  Widget _loginForm(context){

    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[

          SafeArea(
            child: Container(
              height: size.height * 0.3,
            ),
          ),

          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 20.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0
                )
              ]
            ),
            child: Column(
              children: <Widget>[
                Text('Ingreso', style: TextStyle(fontSize: 20.0),),
                SizedBox( height: 20.0 ),
                _crearEmail( bloc ),
                SizedBox( height: 20.0 ),
                _crearPassword( bloc ),
                SizedBox( height: 20.0 ),
                _crearBoton( bloc )
              ],
            ),

          ),

          Text('¿Olvido su contraseña?', style: TextStyle(fontSize: 15.0)),
          SizedBox(height: 100.0,)

        ],
      ),
    );
  }


  Widget _crearEmail(LoginBloc bloc) {

    return StreamBuilder(
      stream: bloc.emailStream,
      builder: ( BuildContext context, AsyncSnapshot snapshot){

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email, color: Colors.redAccent),
              hintText: 'ejemplo@correo.com',
              labelText: 'Correo electrónico',
              counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
    
  }

  Widget _crearPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock_outline, color: Colors.redAccent),
              labelText: 'Contraseña',
              counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: bloc.changePassword,
          ),
        );

      },
    );
    
    
    
  }

  Widget _crearBoton(LoginBloc bloc) {

    // formValidStream
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: ( BuildContext context, AsyncSnapshot snapshot){

        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric( horizontal: 80.0, vertical: 15.0 ),
            child: Text('Ingresar')
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
          ),
          elevation: 0.0,
          color: Colors.redAccent,
          textColor: Colors.white,
          onPressed: snapshot.hasData ? ()=> _login(bloc, context) : null,
        );
      },
    );

  }

  _login(LoginBloc bloc, BuildContext context) {
    print('=============');
    print('email: ${ bloc.email } ');
    print('password ${ bloc.password }');
    print('=============');

    Navigator.pushReplacementNamed  (context, 'home');
  }

}