import 'package:flutter/material.dart';
import 'package:notes_app/Components/Crud.dart';
import 'package:notes_app/Components/Valid.dart';
import 'package:notes_app/Components/customtextformfield.dart';
import 'package:notes_app/Constant/linkAPI.dart';

class Signup extends StatefulWidget {

  @override
  State<Signup> createState() => _SignupState();

}

class _SignupState extends State<Signup> {

  GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController username= TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password1 = TextEditingController();
  TextEditingController password2 = TextEditingController();

  bool _passwordVisible1 = true;
  bool _passwordVisible2 = true;

  Crud _crud = Crud();
  bool isLooding = false;

  signUp() async {
    if(_formKey.currentState!.validate()){
      isLooding = true;
      setState(() {});
      var response = await _crud.postRequest(linkSignUp , {
        "username": username.text,
        "email": email.text,
        "password": password1.text,
      });
      isLooding = false;
      setState(() {});
      if (response["Status"] == "Success") {
        Navigator.pushNamedAndRemoveUntil(context, "Success", (route) => false);
      } else {
        print("Signup Fail");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLooding == true 
      ? Center(child: CircularProgressIndicator()) 
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
                    myController: username,
                    label: "Username",
                    prefix: Icon(Icons.person),
                  ),
                  customTextFormField(
                    valid: (val){
                      return validInput(val!, 5, 40);
                    },
                    myController: email,
                    label: "Email",
                    prefix: Icon(Icons.email),
                  ),
                  customTextFormField1(
                    pass: _passwordVisible1,
                    valid: (val){
                      return validInput(val!, 3, 10);
                    },
                    myController: password1,
                    label: "Password",
                    prefix: Icon(Icons.password),
                    suff: IconButton(
                      onPressed: (){
                        setState(() {
                          _passwordVisible1 = !_passwordVisible1;
                        });
                      }, 
                      icon: Container(
                        child: Icon(
                          _passwordVisible1 
                          ? Icons.visibility_off 
                          : Icons.visibility,
                        )
                      )
                    ),
                  ),
                  customTextFormField1(
                    pass: _passwordVisible2,
                    valid: (val){
                      if(val!.isEmpty || val.length < 3 || val.length > 10){
                        return validInput(val, 3, 10);
                      }
                      if(val != password1.text){
                        return 'كلمة السر غير متوافقه';
                      }
                      return null;
                    },
                    myController: password2,
                    label: "Confirm Password",
                    prefix: Icon(Icons.password),
                    suff: IconButton(
                      onPressed: (){
                        setState(() {
                          _passwordVisible2 = !_passwordVisible2;
                        });
                      }, 
                      icon: Container(
                        child: Icon(
                          _passwordVisible2 
                          ? Icons.visibility_off 
                          : Icons.visibility,
                        )
                      )
                    ),
                  ),
                  MaterialButton(
                    padding: EdgeInsets.symmetric(vertical: 10 , horizontal: 70),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () async {
                      await signUp();
                    },
                    child: Text("Sign Up"),
                  ),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "Login");
                    },
                    child: Text("Login")
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}