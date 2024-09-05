import 'package:flutter/material.dart';
import 'package:notes_app/Components/Card%20Note.dart';
import 'package:notes_app/Components/Crud.dart';
import 'package:notes_app/Constant/linkAPI.dart';
import 'package:notes_app/main.dart';
import 'package:notes_app/model/Note%20Model.dart';
import 'package:notes_app/notes/Edit.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>{

  Crud crud = Crud();
  getNotes() async {
    var response = await crud.postRequest(linkViewNotes, {
      "id" : sharedPref.getString("id"),
    });
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 40),
          child: Center(
            child: Text("Home")
            ),
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app), 
            onPressed: (){
              sharedPref.clear();
              Navigator.pushNamedAndRemoveUntil(context, "Login", (route) => false);
            }
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: (){
          Navigator.pushNamed(context, "Add");
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            FutureBuilder(
              future: getNotes(),
              builder: (BuildContext context , AsyncSnapshot snapshot){
              if(snapshot.hasData){
                if(snapshot.data['Status'] == 'Failed'){
                  return Center(child: Text("لا توجد ملاحظات" , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),));
                }
                return ListView.builder(
                  itemCount: snapshot.data['data'].length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context , i){
                    return cardNotes(
                      onDelete: () async {
                        var response = await crud.postRequest(linkDeleteNotes, {
                          'id' : snapshot.data['data'][i]['notes_id'].toString(),
                          'imagename' : snapshot.data['data'][i]['notes_image'].toString(),
                        });
                        if(response["Status"] == "Success"){
                          Navigator.pushReplacementNamed(context, "Home");
                        } else {
                          //
                        }
                      },
                      ontap: (){
                        Navigator.push(context , MaterialPageRoute(
                          builder: (context) => editNote(
                            notes: snapshot.data['data'][i],
                          ))
                        );
                      }, 
                      NoteModel: noteModel.fromJson(snapshot.data['data'][i]),
                    );
                  }
                );
              }
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: Text("Loading ..."));
              }
              return Center(child: Text("Loading ..."));
            })
          ],
        ),
      ),
    );
  }
}