import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/services.dart';

void main(){
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,         //for removing the debug banner
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var result;
  Future scanqr()async{
    try{
      var qrResult =(await BarcodeScanner.scan());
      setState(() {
        result=qrResult;
      });
    }
    on PlatformException catch(ex){
        if(ex.code==BarcodeScanner.cameraAccessDenied){
          setState((){
            result="CAMERA PERMISSION WAS DENIED";
          });
        }
        else{
          setState(() {
            result="UNKNOWN ERROR $ex";
          });
        }
    }
    on FormatException{
      setState(() {
        result="YOU PRESSED THE BACK BUTTUON BEFORE SCANNING ANYTHING";
      });
    }
    catch(ex){
      setState(() {
        result="UNKNOWN ERROR $ex";
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("THE QR CODE APP"),
      ),
      body: const Center(child: Text("hi",
      style: TextStyle(
        color: Colors.red,
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
      ),)),

      floatingActionButton: FloatingActionButton.extended(
          icon:const Icon(Icons.camera_alt),
          onPressed: scanqr, label:const Text("Scan")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
