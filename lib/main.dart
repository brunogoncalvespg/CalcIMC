import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController pesocontroler = TextEditingController();
  TextEditingController alturacontroler = TextEditingController();


  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infotext = "Informe seus dados";

  void _resetarimputs(){
    setState(() {
      pesocontroler.text = "";
      alturacontroler.text = "";
      _infotext = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calcular(){
    setState(() {
      double peso = double.parse(pesocontroler.text);
      double altura = double.parse(alturacontroler.text) / 100;
      double imc = peso / (altura * altura);
      if (imc< 18.6){
        _infotext = " Abaixo do peso (${imc.toStringAsPrecision(3)})";
      } else if(imc >= 18.6 && imc < 24.9 ){
        _infotext = " Peso ideal (${imc.toStringAsPrecision(3)})";

    }else if(imc >= 24.9 && imc < 29.9 ){
      _infotext = " Levemente acima do peso (${imc.toStringAsPrecision(3)})";

  }
  else if(imc >= 29.9 && imc < 34.9 ){
  _infotext = " Obesidade Grau I (${imc.toStringAsPrecision(3)})";
  }
  else if(imc >= 34.9 && imc < 39.9 ){
      _infotext = " Obesidade Grau II (${imc.toStringAsPrecision(3)})";

  }
      else if(imc >= 40.0 ){
        _infotext = " Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        actions:[
          IconButton(icon: Icon(Icons.refresh),
          onPressed: _resetarimputs,)
        ],

      ),
      backgroundColor: Colors.white,
      body:SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.person_outline, size: 120.0, color: Colors.greenAccent,),
              TextFormField(keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.greenAccent)
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.greenAccent, fontSize: 25.0),
                controller: pesocontroler,
                validator: (value){
                if (value.isEmpty){
                  return "Insira seu peso!";
                }
                },
              ),
              TextFormField(keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.greenAccent)
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.greenAccent, fontSize: 25.0),
                controller: alturacontroler,
                validator:  (value){
                if (value.isEmpty){
                  return "Insira sua altura!";
                }
                },

              ),
              Padding(padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child:RaisedButton(
                    onPressed: (){if
                    (_formKey.currentState.validate()){
                      _calcular();
                    }},
                    child: Text("Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),),
                    color: Colors.greenAccent,
                  ),
                ),
              ),
              Text(_infotext, textAlign: TextAlign.center,
                style: TextStyle(color: Colors.greenAccent, fontSize: 25.0),)
            ],
          ),
        )
      ),
    );
  }
}