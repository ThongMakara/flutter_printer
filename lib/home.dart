import 'package:flutter/material.dart';
import 'package:thermal_printer_flutter/printer.dart';

class Home extends StatelessWidget {
  final List<Map<String, dynamic>> data = [
    {
      'title': 'Angkor Beer',
      'price': 2.50,
      'qty': 2,
      'total_price': 5.00,
    },
    {
      'title': ' ABC Beer',
      'price': 3.20,
      'qty': 2,
      'total_price': 6.40,
    },
    {
      'title': 'Tiger',
      'price': 2,
      'qty': 3,
      'total_price': 6.00,
    },
  ];

  @override
  Widget build(BuildContext context) {
    double _total = 0;

    for (var i = 0; i < data.length; i++) {
      _total += data[i]['total_price'];
    }

    return Scaffold(
      appBar: AppBar(title: Text('Thermal Printer')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (c, i) {
                return ListTile(
                  title: Text(data[i]['title']),
                  subtitle: Text('KH ${data[i]['price']} x ${data[i]['qty']}'),
                  trailing: Text('KH ${data[i]['total_price']}'),
                );
              },
            ),
          ),
          Container(
            color: Colors.grey[200],
            padding: EdgeInsets.all(20),
            child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      'Total :',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'KH $_total :',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(width: 20),
                Expanded(
                  child: FlatButton(
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: Text('Print'),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => Printer(data)));
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
