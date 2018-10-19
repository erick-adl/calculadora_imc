import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _globalKey = new GlobalKey<FormState>();

  TextEditingController PesoController = new TextEditingController();
  TextEditingController AlturaController = new TextEditingController();

  String _info = "Informe seus dados";

  void _resetFild() {
    PesoController.text = "";
    AlturaController.text = "";
    setState(() {
      _info = "Informe seus dados";
    });
  }

  void _calculator() {
    setState(() {
      var peso = double.parse(PesoController.text);
      var altura = double.parse(AlturaController.text) / 100;
      var imc = peso / (altura * altura);
      print(imc);
      if (imc < 18.5) {
        _info = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _info = "Peso ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _info = "Peso ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _info = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _info = "Obesidade Grau 1 (${imc.toStringAsPrecision(4)})";
      } else if (imc < 40) {
        _info = "Obesidade Grau 2 (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculador de IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), onPressed: _resetFild)
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.person_outline,
                  color: Colors.green,
                  size: 120.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso (kg)",
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: PesoController,
                  validator: (value){
                    if(value.isEmpty){
                      return "Insira seu peso";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: AlturaController,
                  validator: (value){
                    if(value.isEmpty){
                      return "Insira sua altura";
                    }
                  },
                ),
                Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        color: Colors.green,
                        textColor: Colors.white,
                        child: Text(
                          "Calcular",
                          style: TextStyle(fontSize: 20.0),
                        ),
                        onPressed: (){
                          if(_globalKey.currentState.validate()){
                            _calculator();
                          }
                        },
                      ),
                    )),
                Text(
                  _info,
                  style: TextStyle(fontSize: 25.0, color: Colors.green),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ));
  }
}
