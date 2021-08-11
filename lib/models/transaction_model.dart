class TransactionModel {
  String transaction_title;
  String amount;
  String type;
  String date;
  String status;
  String icon;

  TransactionModel(this.transaction_title, this.amount, this.type, this.date,
      this.status, this.icon);
}

List<TransactionModel> transactions = cardData
    .map(
      (item) => TransactionModel(
          item['transaction_title'].toString(),
          item['amount'].toString(),
          item['type'].toString(),
          item['date'].toString(),
          item['status'].toString(),
          item['icon'].toString()
      ),
    )
    .toList();

var cardData = [
  {
    "transaction_title": "WASAC Water",
    "amount": "8500",
    "type": "payment",
    "date": "18-8-2021",
    "status": "1",
    "icon": "assets/images/water.png",
  },
  {
    "transaction_title": "Electricity",
    "amount": "20000",
    "type": "buy",
    "date": "10-7-2021",
    "status": "0",
    "icon": "assets/images/electricity.png",
  },
  {
    "transaction_title": "Airtime MTN",
    "amount": "300",
    "type": "payment",
    "date": "29-5-2021",
    "status": "1",
    "icon": "assets/images/airtime.png",
  },
  {
    "transaction_title": "WASAC Water",
    "amount": "9000",
    "type": "payment",
    "date": "18-8-2020",
    "status": "1",
    "icon": "assets/images/water.png",
  },
  {
    "transaction_title": "WASAC Water",
    "amount": "8500",
    "type": "payment",
    "date": "18-8-2021",
    "status": "1",
    "icon": "assets/images/water.png",
  },
  {
    "transaction_title": "Electricity",
    "amount": "20000",
    "type": "buy",
    "date": "10-7-2021",
    "status": "0",
    "icon": "assets/images/electricity.png",
  },
  {
    "transaction_title": "Airtime MTN",
    "amount": "300",
    "type": "payment",
    "date": "29-5-2021",
    "status": "1",
    "icon": "assets/images/airtime.png",
  },
  {
    "transaction_title": "WASAC Water",
    "amount": "9000",
    "type": "payment",
    "date": "18-8-2020",
    "status": "1",
    "icon": "assets/images/water.png",
  },
  {
    "transaction_title": "WASAC Water",
    "amount": "8500",
    "type": "payment",
    "date": "18-8-2021",
    "status": "1",
    "icon": "assets/images/water.png",
  },
  {
    "transaction_title": "Electricity",
    "amount": "20000",
    "type": "buy",
    "date": "10-7-2021",
    "status": "0",
    "icon": "assets/images/electricity.png",
  },
  {
    "transaction_title": "Airtime MTN",
    "amount": "300",
    "type": "payment",
    "date": "29-5-2021",
    "status": "1",
    "icon": "assets/images/airtime.png",
  },
  {
    "transaction_title": "WASAC Water",
    "amount": "9000",
    "type": "payment",
    "date": "18-8-2020",
    "status": "1",
    "icon": "assets/images/water.png",
  },


];
