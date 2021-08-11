class SendAccountModel {
  String name;
  String profile;
  String account_number;


  SendAccountModel(this.name, this.profile, this.account_number);
}

List<SendAccountModel> send_accounts = cardData
    .map(
      (item) => SendAccountModel(
    item['name'].toString(),
    item['profile'].toString(),
    item['account_number'].toString(),
  ),
).toList();

var cardData = [
  {
    "name": "Qonics Developing Team",
    "profile": "assets/images/profile.png",
    "account_number": "A789-8134-5778",
  },

];
