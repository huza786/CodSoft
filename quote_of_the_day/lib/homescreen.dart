import 'package:flutter/material.dart';
import 'package:quote_of_the_day/Api_service.dart';
import 'package:quote_of_the_day/Colors.dart';
import 'package:quote_of_the_day/Quote_widget.dart';
import 'package:quote_of_the_day/quote_model.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    Api_service api_service = Api_service();
    quote_model quote = quote_model();
    colorslist colorlist2 = colorslist();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorlist2.teal,
        title: Text(
          'Quote of the Day',
          style: TextStyle(
              fontFamily: 'Smooch_Sans',
              fontSize: 36,
              fontWeight: FontWeight.w600),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder(
            future: api_service.getQuote(),
            builder: (context, snapshot) {
              return QouteWidget(
                qoute: snapshot.data!.quote.toString(),
                author: snapshot.data!.author.toString(),
              );
            }),
      ),
    );
  }
}
