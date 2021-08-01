import 'dart:typed_data';
import 'package:flutter/material.dart' hide Image;
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart';
import 'dart:io' show Platform;
import 'package:image/image.dart';
import 'package:intl/intl.dart';

class Printer extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  Printer(this.data);
  @override
  _PrinterState createState() => _PrinterState();
}

class _PrinterState extends State<Printer> {
  PrinterBluetoothManager _printerManager = PrinterBluetoothManager();
  List<PrinterBluetooth> _devices = [];
  String _devicesMsg;
  BluetoothManager bluetoothManager = BluetoothManager.instance;

  @override
  void initState() {
    if (Platform.isAndroid) {
      bluetoothManager.state.listen((val) {
        print('state = $val');
        if (!mounted) return;
        if (val == 12) {
          print('on');
          initPrinter();
        } else if (val == 10) {
          print('off');
          setState(() => _devicesMsg = 'Bluetooth Disconnect!');
        }
      });
    } else {
      initPrinter();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Print'),
      ),
      body: _devices.isEmpty
          ? Center(child: Text(_devicesMsg ?? ''))
          : ListView.builder(
              itemCount: _devices.length,
              itemBuilder: (c, i) {
                return ListTile(
                  leading: Icon(Icons.print),
                  title: Text(_devices[i].name),
                  subtitle: Text(_devices[i].address),
                  onTap: () {
                    _startPrint(_devices[i]);
                  },
                );
              },
            ),
    );
  }

  void initPrinter() {
    _printerManager.startScan(Duration(seconds: 2));
    _printerManager.scanResults.listen((val) {
      if (!mounted) return;
      setState(() => _devices = val);
      if (_devices.isEmpty) setState(() => _devicesMsg = 'No Devices');
    });
  }

  Future<void> _startPrint(PrinterBluetooth printer) async {
    _printerManager.selectPrinter(printer);
    final result =
        await _printerManager.printTicket(await _ticket(PaperSize.mm80));
    // showDialog(
    //   context: context,
    //   builder: (_) => AlertDialog(
    //     content: Text(result.msg),
    //   ),
    // );
  }

  Future<Ticket> _ticket(PaperSize paper) async {
    final ticket = Ticket(paper);
    double total = 0;
    ticket.text('AENO-II',
        styles: PosStyles(
            underline: true,
            turn90: true,
            align: PosAlign.center,
            height: PosTextSize.size2,
            width: PosTextSize.size2),
        linesAfter: 1);
    final f = new DateFormat('yyyy-MM-dd hh:mm');
    ticket.text("Name: VengE");
    ticket.text("Tel: 081363135");
    ticket.text("Date:" + f.format(DateTime.now()).toString(),
        styles: PosStyles(
          bold: true,
        ));
    ticket.text("================================");
    for (var i = 0; i < widget.data.length; i++) {
      total += widget.data[i]['total_price'];
      ticket.text(widget.data[i]['title']);
      ticket.row([
        PosColumn(
            text: '${widget.data[i]['price']} x ${widget.data[i]['qty']}',
            width: 6),
        PosColumn(text: 'KH ${widget.data[i]['total_price']}', width: 6),
      ]);
    }
    ticket.text("================================");
    ticket.feed(1);
    ticket.qrcode("erererwewefe");
    ticket.feed(1);
    final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
    ticket.barcode(Barcode.upcA(barData));
    ticket.feed(1);
    ticket.row([
      PosColumn(text: 'Total', width: 6, styles: PosStyles(bold: true)),
      PosColumn(text: 'KH $total', width: 6, styles: PosStyles(bold: true)),
    ]);
    ticket.feed(1);
    ticket.text("================================");
    ticket.text('Thank you...',
        styles: PosStyles(align: PosAlign.center, bold: true));
    ticket.cut();
    return ticket;
  }

  @override
  void dispose() {
    _printerManager.stopScan();
    super.dispose();
  }
}
