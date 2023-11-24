import 'package:flutter/material.dart';
import 'package:to_do_app/View/Colors.dart';
import 'package:to_do_app/_model/Notes_db.dart';
import 'package:to_do_app/_model/noteModel.dart';

class NoteWidget extends StatefulWidget {
  NoteWidget({
    Key? key,
    required this.description,
    required this.title,
    required this.noteDb,
    required this.notemodel,
    required this.fetchNotes,
  }) : super(key: key);

  final String? title;
  final String? description;
  NoteDb noteDb = NoteDb();
  final noteModel? notemodel;
  final VoidCallback fetchNotes;

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  ColorsList colorsList = ColorsList();
// Declare notemodel variable

  @override
  void initState() {
    super.initState();

    //  widget.notemodel  = noteModel(
    //     title: widget.title,
    //     description: widget.description,
    //   );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: colorsList.Gold_container_color,
                borderRadius: BorderRadius.circular(6),
              ),
              height: MediaQuery.of(context).size.height / 6,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title?.toString() ?? 'no title',
                          style: const TextStyle(
                            fontFamily: 'Pilat',
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            // Call the delete method from NoteDb
                            await widget.noteDb
                                .Delete(widget.notemodel?.id as int);
                            widget.fetchNotes();
                          },
                        ),
                        IconButton(
                          icon: widget.notemodel?.IsCompleted == 0
                              ? Icon(
                                  Icons.autorenew,
                                  size: 30,
                                  color: Colors.black,
                                )
                              : Icon(
                                  Icons.check,
                                  size: 30,
                                  color: Colors.green,
                                ),
                          onPressed: () {
                            widget.notemodel?.IsCompleted = 1;
                            setState(() {});
                          },
                        )
                      ],
                    ),
                    Text(
                      widget.notemodel?.description ?? 'no description',
                      style: TextStyle(
                        fontFamily: 'Pilat',
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
