import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:readmore/readmore.dart';

class CryptoNewsList extends StatefulWidget {
  const CryptoNewsList({Key? key}) : super(key: key);

  @override
  _CryptoNewsListState createState() => _CryptoNewsListState();
}

class _CryptoNewsListState extends State<CryptoNewsList> {
  List<dynamic> newsItems = [];
  @override
  void initState() {
    super.initState();
    getNews();
  }

  Future<void> getNews() async {
    var response = await http.get(Uri.parse('https://n59der.deta.dev/'));
    String jsonBody = response.body;
    Map<String, dynamic> items = jsonDecode(jsonBody);
    newsItems = items['newsItems'];
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    Widget CryptoNewsHeading() {
      return Container(
        margin: EdgeInsets.only(bottom: screenWidth * 0.02),
        width: screenWidth * 0.9,
        decoration: BoxDecoration(
           
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        height: screenWidth * 0.12,
        child: Center(
            child: Text(
          'Latest Cryptocurrency News',
          style: TextStyle(
              
              fontSize: screenWidth * 0.055,
              fontWeight: FontWeight.bold),
        )),
      );
    }

    Widget cryptoNewsWidgetMaker(cryptoNewsObject toShow) {
      return Container(
        width: screenWidth * 0.9,
        margin: EdgeInsets.all(10),
        
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color:  Color.fromARGB(19, 92, 92, 92),),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: NetworkImage(toShow.imageUrl), fit: BoxFit.cover),
                  ),
                ),
                Positioned(left : 10,bottom: 7,child: Container(padding: EdgeInsets.symmetric(horizontal: 5),decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5)),child: Text(toShow.source.substring(toShow.source.indexOf('|')+2),style: TextStyle(fontSize: 14, color:Colors.black),),)),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: screenWidth * 0.015, horizontal: screenWidth * 0.02),
              child: Text(
                toShow.heading,
                style: TextStyle(
                   
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                margin: EdgeInsets.only(
                    left: screenWidth * 0.02,
                    right: screenWidth * 0.02,
                    bottom: screenWidth * 0.02),
                child: ReadMoreText(
                  toShow.description,
                  trimLines: 3,
                  trimMode: TrimMode.Line,
                  style: TextStyle(
                      
                      fontSize:15,
                      
                      ),
                )),
          ],
        ),
      );
    }
    Stream streamOfNews(){
      return Stream.periodic(Duration(seconds: 10), (count) => getNews());
    }
    return StreamBuilder(
        stream: streamOfNews(),
        builder: (context,snapshot){
          return newsItems.length==0 ? Center(child: CircularProgressIndicator(),) : ListView.builder(
            itemCount: newsItems.length,
            itemBuilder: (context, index) {
              cryptoNewsObject toShow = cryptoNewsObject(
                  heading: newsItems[index]["heading"],
                  imageUrl: newsItems[index]["imageURL"],
                  source: newsItems[index]["source"],
                  description: newsItems[index]["description"]);
              return cryptoNewsWidgetMaker(toShow);
            },
          );
        });
  }
}

class cryptoNewsObject {
  final String heading;
  final String imageUrl;
  final String source;
  final String description;
  cryptoNewsObject(
      {required this.heading,
      required this.imageUrl,
      required this.source,
      required this.description});
}