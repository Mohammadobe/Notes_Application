import 'package:flutter/material.dart';

class Success extends StatefulWidget {
  const Success({super.key});

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text('تم انشاء الحساب بنجاح الان يمكنك تسجيل الدخول' , style: TextStyle(fontSize: 16) , textAlign: TextAlign.center,),
            ),
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: (){
                Navigator.pushNamedAndRemoveUntil(context, "Login", (route) => false);
              },
              child: Text('تسجيل الدخول'),
            )
          ],
        ),
      ),
    );
  }
}