class OperationModel {
  String name;
  String activeIcon;
  String inActiveIcon;


  OperationModel(this.name, this.activeIcon, this.inActiveIcon);
}

List<OperationModel> operations = cardData
    .map(
      (item) => OperationModel(
          item['name'].toString(),
          item['activeIcon'].toString(),
          item['inActiveIcon'].toString(),
      ),
    ).toList();

var cardData = [
  {
    "name": "Top up",
    "activeIcon": "assets/images/electricity_white.png",
    "inActiveIcon": "assets/images/electricity.png",
  },
  {
    "name": "Payment",
    "activeIcon": "assets/images/electricity_white.png",
    "inActiveIcon": "assets/images/electricity.png",
  },
  {
    "name": "Transfer",
    "activeIcon": "assets/images/transfer_white.png",
    "inActiveIcon": "assets/images/transfer.png",
  },
  {
    "name": "Withdraw",
    "activeIcon": "assets/images/withdraw_white.png",
    "inActiveIcon": "assets/images/withdraw.png",
  },
];
