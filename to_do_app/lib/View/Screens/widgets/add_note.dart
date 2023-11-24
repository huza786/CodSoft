import 'package:flutter/material.dart';
import 'package:to_do_app/View/Colors.dart';
import 'package:to_do_app/_model/noteModel.dart';

class AddNote extends StatefulWidget {
  final noteModel? notemodel;

  final ValueChanged<Map> onSubmit;
  const AddNote({super.key, this.notemodel, required this.onSubmit});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.notemodel != null) {
      titlecontroller.text = widget.notemodel!.title ?? "";
      descriptioncontroller.text = widget.notemodel!.description ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    late ColorsList colorsList = ColorsList();
    final isEditing = widget.notemodel != null;
    return AlertDialog(
      backgroundColor: colorsList.Gold_container_color,
      title: Text(isEditing ? 'Edit A Note' : 'Add A Note'),
      content: Form(
        key: formkey,
        child: Container(
          width: 300,
          height: 300,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                    hintText: 'Title', fillColor: Colors.white),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Title is required' : null,
                controller: titlecontroller,
                maxLength: 20,
              ),
              SizedBox(
                child: Container(
                  height: 150,
                  width: 100,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Description',
                    ),
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Description is required'
                        : null,
                    controller: descriptioncontroller,
                    maxLines: 100,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ElevatedButton(
                    child: const Text('Save'),
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        widget.onSubmit({
                          'title': titlecontroller.text,
                          'description': descriptioncontroller.text,
                          'IsCompleted': 0,
                        });
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
