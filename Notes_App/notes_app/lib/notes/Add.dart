import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes_app/Components/Crud.dart';
import 'package:notes_app/Components/Valid.dart';
import 'package:notes_app/Components/customtextformfield.dart';
import 'package:notes_app/Constant/linkAPI.dart';
import 'package:notes_app/main.dart';

class addNote extends StatefulWidget {
  const addNote({super.key});

  @override
  State<addNote> createState() => _addNoteState();
}

class _addNoteState extends State<addNote>{

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  bool isLooding = false;
  File? myFile;

  Crud crud = Crud();
  addNote() async {
    if (myFile == null){
      return AwesomeDialog(context: context , 
        title: "هام" , 
        body: Text("الرجاء اضافة الصورة الخاصة بالملاحظة")
      )..show();
    }
    if (_formKey.currentState!.validate()) {
      isLooding = true;
      setState(() {});
      var response = await crud.postRequestWithFile(linkAddNotes, {
      "title": title.text,
      "content": content.text,
      "id": sharedPref.getString("id"),
      } , myFile!);
      isLooding = false;
      setState(() {});
      if(response["Status"] == "Success"){
        Navigator.pushNamedAndRemoveUntil(context, "Home" , (route) => false);
      } else {
        //
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.only(right: 20),
          child: Center(child: Text('Add Note'))
        ),
        backgroundColor: Colors.blue,
      ),
      body: isLooding == true 
      ?Center(child: CircularProgressIndicator())
      :Container(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              customTextFormField(
                prefix: Icon(Icons.title),
                label: 'Title', 
                myController: title, 
                valid: (val){
                  return validInput(val!, 1, 40);
                }
              ),
              customTextFormField(
                label: 'Content', 
                prefix: Icon(Icons.content_copy),
                myController: content, 
                valid: (val){
                  return validInput(val!, 10, 255);
                }
              ),
              SizedBox(height: 20,),
              MaterialButton(
                child: Text("Choose Image"),
                textColor: Colors.white,
                color: myFile == null ? Colors.blue : Colors.grey,
                onPressed: (){
                  showModalBottomSheet(context: context, builder: (context) => Container(
                    height: 110,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Text("Please Choose Image" , style: TextStyle(fontWeight: FontWeight.bold),),
                        InkWell(
                          onTap: () async {
                            XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
                            Navigator.pop(context);
                            myFile = File(xfile!.path);
                            setState(() {});
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
                            child: Text("From Gallery"),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            XFile? xfile = await ImagePicker().pickImage(source: ImageSource.camera);
                            Navigator.pop(context);
                            myFile = File(xfile!.path);
                            setState(() {});
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
                            child: Text("From Camera"),
                          ),
                        ),
                      ],
                    ),
                  ));
                }
              ),
              SizedBox(height: 20,),
              MaterialButton(
                child: Text("Add"),
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () async {
                  await addNote();
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}