import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool switchEnabled = false;
  var tipController = TextEditingController();
  double tip = 0.0;
  int selectedRadio = 0;
  var radioGroupValues = {
    0: "Amazing 20%",
    1: "Good 18%",
    2: "Okay 15%",
  };

  tipCalculation(){
    var costOfService = double.parse(tipController.text??"0");
    if(selectedRadio == 0){
      tip = costOfService*0.20;
    }else if(selectedRadio == 1){
      tip = costOfService*0.18;
    }else if(selectedRadio == 2){
      tip = costOfService*0.15;
    }

    if(switchEnabled){
      tip = tip.ceilToDouble();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tip time'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 14),
          ListTile(
            leading: Icon(Icons.room_service),
            title: Padding(
              padding: EdgeInsets.only(right: 24),
              child: TextField(
                controller: tipController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Cost of service",
                    border: OutlineInputBorder()
                  )
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dinner_dining),
            title: Text("How was the service?"),
          ),
          Column(//tiende a infinito, por eso se agrega MainAxisSize.min
            mainAxisSize: MainAxisSize.min,
            children: radioGroupValues.entries
                .map(
                  (element) => ListTile(
                    leading: Radio(
                        value: element.key,//es el key del mapa
                        groupValue: selectedRadio,
                        onChanged: (int currentSelectedRadio){
                          setState(() {
                            selectedRadio = currentSelectedRadio;
                          });
                        }
                    ),
                    title: Text("${element.value}"),
                  ),
            ).toList(),
          ),
          
          ListTile(
            leading: Icon(Icons.credit_card),//parte de la izquierda
            title: Text("Round up tip"),//parte central
            trailing: Switch(
                        value: switchEnabled, 
                        onChanged: (switchstate){
                          setState(() {
                            switchEnabled = switchstate;
                          });
                        }
                      ),//parte de la derecha
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: MaterialButton(
                    child: Text("CALCULATE", style: TextStyle(color: Colors.grey[200]),),
                    onPressed: (){
                      tipCalculation();
                      setState(() {});
                      print("Valor del text field: ${tipController.text}");
                    },
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: 
              Text("Tip amount: \$${tip.toStringAsFixed(2)}", textAlign: TextAlign.end,)
          ),
          
        ],
      ),
    );
  }
}
