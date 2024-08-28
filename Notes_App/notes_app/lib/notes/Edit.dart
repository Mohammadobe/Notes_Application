import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes_app/Components/Crud.dart';
import 'package:notes_app/Components/Valid.dart';
import 'package:notes_app/Components/customtextformfield.dart';
import 'package:notes_app/Constant/linkAPI.dart';

class editNote extends StatefulWidget {

  final notes;
  const editNote({super.key, this.notes});

  @override
  State<editNote> createState() => _editNoteState();
}

class _editNoteState extends State<editNote>{

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  bool isLooding = false;
  File? myFile;

  Crud crud = Crud();
  editNote() async {
    if (_formKey.currentState!.validate()) {
      isLooding = true;
      setState(() {});
      var response;
      if (myFile == null) {
        response = await crud.postRequest(linkEditNotes, {
        "title": title.text,
        "content": content.text,
        "id": widget.notes['notes_id'].toString(),
        "imagename": widget.notes['notes_image'].toString(),
        });
      } else {
        response = await crud.postRequestWithFile(linkEditNotes, {
        "title": title.text,
        "content": content.text,
        "id": widget.notes['notes_id'].toString(),
        "imagename": widget.notes['notes_image'].toString(),
        } , myFile!);
      }
      isLooding = false;
      setState(() {});
      if(response["Status"] == "Success"){
        Navigator.pushReplacementNamed(context, "Home");
      } else {
        //
      }
    }
  }

  @override
  void initState() {
    title.text = widget.notes['notes_title'];
    content.text = widget.notes['notes_content'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.only(left: 60),
          child: Text('Edit Note')
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
                hint: 'Title', 
                myController: title, 
                valid: (val){
                  return validInput(val!, 1, 40);
                }
              ),
              customTextFormField(
                hint: 'Content', 
                myController: content, 
                valid: (val){
                  return validInput(val!, 10, 255);
                }
              ),
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
                child: Text("Edit"),
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () async {
                  await editNote();
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}