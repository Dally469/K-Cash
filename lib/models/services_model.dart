class ServicesModel {
  String serviceId;
  String title;
  String icon;

  ServicesModel(this.serviceId, this.title, this.icon);
}

List<ServicesModel> services = cardData
    .map(
      (item) => ServicesModel(
        item['serviceId'].toString(),
        item['title'].toString(),
        item['icon'].toString(),
      ),
    ).toList();

var cardData = [
  {
    "serviceId": "1",
    "title": "Airtime",
    "icon": "assets/images/airtime.png",
  },
  {
    "serviceId": "1",
    "title": "Electricity",
    "icon": "assets/images/electricity.png",
  },
  {
    "serviceId": "1",
    "title": "Water",
    "icon": "assets/images/water.png",
  },
  {
    "serviceId": "1",
    "title": "House Rent",
    "icon": "assets/images/electricity.png",
  },
  {
    "serviceId": "1",
    "title": "Internet Bundle",
    "icon": "assets/images/electricity.png",
  },
];
