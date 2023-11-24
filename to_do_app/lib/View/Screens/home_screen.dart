import 'package:flutter/material.dart';
import 'package:to_do_app/View/Colors.dart';
import 'package:to_do_app/View/Screens/widgets/add_note.dart';
import 'package:to_do_app/View/Screens/widgets/note.dart';
import 'package:to_do_app/_model/Notes_db.dart';
import 'package:to_do_app/_model/noteModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<noteModel>>? Future_note;
  final NoteDb noteDb = NoteDb();

  void FetchNotes() async {
    final notes = await noteDb.getAllNotes();
    setState(() {
      Future_note = Future.value(notes);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    ColorsList colorsList = ColorsList();
    return Scaffold(
        backgroundColor: colorsList.background_color,
        body: SafeArea(
            child: FutureBuilder(
          future: Future_note,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text(
                  "Error loading notes",
                  style: TextStyle(
                    fontFamily: 'Pilat',
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            } else if (snapshot.data == null) {
              return const Center(
                child: Text(
                  "No Notes Found",
                  style: TextStyle(
                    fontFamily: 'Pilat',
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            } else {
              final notes =
                  snapshot.data as List<noteModel>; // Cast to the correct type
              if (notes.isEmpty) {
                return const Center(
                  child: Text(
                    "No Notes Found",
                    style: TextStyle(
                      fontFamily: 'Pilat',
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              } else {
                return ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    return InkWell(
                      child: NoteWidget(
                        fetchNotes: FetchNotes,
                        notemodel: note,
                        description: note.description.toString(),
                        title: note.title.toString(),
                        noteDb: noteDb,
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AddNote(
                            notemodel: note,
                            onSubmit: (Map data) async {
                              await noteDb.Update(
                                id: note.id,
                                IsCompleted: data['IsCompleted'] as int,
                                title: data['title'].toString(),
                                description: data['description'].toString(),
                              );
                              FetchNotes();
                              if (!mounted) return;
                              Navigator.of(context).pop();
                            },
                          ),
                        );
                      },
                    );
                  },
                );
              }
            }
          },
        )),
        floatingActionButton: FloatingActionButton(
          backgroundColor: colorsList.Gold_container_color,
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => AddNote(
                onSubmit: (Map data) async {
                  await noteDb.create(
                    title: data['title'].toString(),
                    description: data['description'].toString(),
                    IsCompleted: data['IsCompleted'] as int,
                  );
                  if (!mounted) return;
                  FetchNotes();
                  Navigator.pop(context);
                },
              ),
            );
          },
        ));
  }
}
