import 'package:flutter/material.dart';
import 'package:notes_app/Constant/linkAPI.dart';
import 'package:notes_app/model/Note%20Model.dart';

class cardNotes extends StatelessWidget {

  final void Function() ontap;
  final noteModel NoteModel;
  final void Function() onDelete;
  const cardNotes({super.key, 
    required this.ontap, 
    required this.onDelete, 
    required this.NoteModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)
                ),
                child: Image.network("$linkImageRoot/${NoteModel.notesImage}" , width: 60 , height: 100 , fit: BoxFit.fill,)
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              flex: 3,
              child: ListTile(
                title: Text("${NoteModel.notesTitle}"),
                subtitle: Text("${NoteModel.notesContent}"),
                trailing: IconButton(
                  onPressed: onDelete, 
                  icon: Icon(Icons.delete)
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}