import 'package:flutter/material.dart';

class customTextFormField extends StatelessWidget {

  final String label;
  final Icon prefix;
  final String? Function(String?) valid;
  final TextEditingController myController;
  const customTextFormField({Key? key, required this.label, required this.myController, required this.valid, required this.prefix}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        validator: valid,
        controller: myController,
        decoration: InputDecoration(
          prefixIcon: prefix,
          labelText: label,
          contentPadding: EdgeInsets.symmetric(vertical: 8 , horizontal: 10),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black , width: 1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
        )
      ),
    );
  }
}

class customTextFormField1 extends StatelessWidget {

  final String label;
  final Icon prefix;
  final bool pass;
  final Widget? suff;
  final String? Function(String?) valid;
  final TextEditingController myController;
  const customTextFormField1({Key? key, required this.label, required this.myController, required this.valid, required this.prefix, required this.pass, this.suff}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        validator: valid,
        controller: myController,
        obscureText: pass,
        decoration: InputDecoration(
          suffixIcon: suff,
          prefixIcon: prefix,
          labelText: label,
          contentPadding: EdgeInsets.symmetric(vertical: 8 , horizontal: 10),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black , width: 1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
        )
      ),
    );
  }
}