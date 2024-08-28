import 'package:flutter/material.dart';

class customTextFormField extends StatelessWidget {

  final String hint;
  final String? Function(String?) valid;
  final TextEditingController myController;
  const customTextFormField({Key? key, required this.hint, required this.myController, required this.valid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        validator: valid,
        controller: myController,
        decoration: InputDecoration(
          hintText: hint,
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