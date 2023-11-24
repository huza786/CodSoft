import 'package:flutter/material.dart';
import 'package:quote_of_the_day/Colors.dart';

class QouteWidget extends StatefulWidget {
  final String? qoute, author;
  const QouteWidget({super.key, required this.author, required this.qoute});

  @override
  State<QouteWidget> createState() => _QouteWidgetState();
}

class _QouteWidgetState extends State<QouteWidget> {
  @override
  Widget build(BuildContext context) {
    colorslist Colorslist = colorslist();
    return Scaffold(
      backgroundColor: Colorslist.teal,
      body: Center(
          child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          margin: const EdgeInsets.only(bottom: 6.0),
          height: 300,
          width: 300,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ], color: Colorslist.grey, borderRadius: BorderRadius.circular(12)),
          child: Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.align_horizontal_right_rounded,
                        size: 20,
                        color: Colors.black,
                      ),
                      Expanded(
                        child: Text(
                          widget.qoute.toString(),
                          style: TextStyle(
                              fontFamily: 'Smooch_Sans',
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Icon(
                        Icons.align_horizontal_left_rounded,
                        size: 20,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text(
                          widget.author.toString(),
                          style:
                              TextStyle(fontFamily: 'Vina_Sans', fontSize: 16),
                        ),
                      )
                    ],
                  )
                ]),
          ),
        ),
      )),
    );
  }
}
