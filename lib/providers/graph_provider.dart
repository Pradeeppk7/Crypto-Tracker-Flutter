import 'package:crytoapp/models/GraphPoint.dart';
import 'package:crytoapp/models/API.dart';
import 'package:flutter/cupertino.dart';

class GraphProvider with ChangeNotifier {

  List<GraphPoint> graphPoints = [];

  Future<void> initializeGraph(String id, int days) async {
    List<dynamic> priceData = await API.fetchGraphData(id, days);

    List<GraphPoint> temp = [];
    for(var pricePoint in priceData) {
      GraphPoint graphPoint = GraphPoint.fromList(pricePoint);
      temp.add(graphPoint);
    }

    graphPoints = temp;
    notifyListeners();
  }

}