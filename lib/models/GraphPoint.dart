class GraphPoint {
  DateTime? date;
  double? price;

  GraphPoint({this.date, this.price});

  GraphPoint.fromList(List<dynamic> list) {
    date = DateTime.fromMillisecondsSinceEpoch(list[0]);
    price = list[1].toDouble();
  }
}