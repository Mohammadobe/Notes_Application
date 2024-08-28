import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/Components/Crud.dart';
import 'package:notes_app/Components/Valid.dart';
import 'package:notes_app/Components/customtextformfield.dart';
import 'package:notes_app/Constant/linkAPI.dart';
import 'package:notes_app/main.dart';

class Login extends StatefulWidget {

  @override
  State<Login> createState() => _LoginState();

}

class _LoginState extends State<Login> {

  GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Crud crud = Crud();
  bool isLooding = false;

  logIn() async {
    if(_formKey.currentState!.validate()){
      isLooding = true;
      setState(() {});
      var response = await crud.postRequest(linkLogin, {
      "email": email.text,
      "password": password.text,
      });
      isLooding = false;
      setState(() {});
      if (response["Status"] == "Success") {
        sharedPref.setString("id", response['data']['id'].toString());
        sharedPref.setString("email", response['data']['email']);
        sharedPref.setString("username", response['data']['username']);
        Navigator.pushNamedAndRemoveUntil(context, "Home", (route) => false);
      } else {
        AwesomeDialog(context: context ,
          title: "تنبيه" , 
          body: Text("البريد الالكتروني او كلمة المرور خطأ او الحساب غير موجود" , textAlign: TextAlign.center,)
        )..show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLooding == true
      ? Center(child: CircularProgressIndicator(),) 
      : Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset("assets/Images/Login.png" , width: 200 , height: 200),
                  customTextFormField(
                    valid: (val){
                      return validInput(val!, 3, 20);
                    },
                    myController: email,
                    hint: "Email Or Username",
                  ),
                  customTextFormField(
                    valid: (val){
                      return validInput(val!, 3, 20);
                    },
                    myController: password,
                    hint: "Password",
                  ),
                  MaterialButton(
                    padding: EdgeInsets.symmetric(vertical: 10 , horizontal: 70),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () async {
                      await logIn();
                    },
                    child: Text("Login"),
                  ),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed("Signup");
                    },
                    child: Text("Sign Up"),
                  ),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}