class CardModel {
  String cardHolder;
  String cardNumber;
  String balance;
  String cardExpDate;
  String cvv;
  String type;

  CardModel(this.cardHolder, this.cardNumber, this.balance, this.cardExpDate,
      this.cvv, this.type);
}

List<CardModel> cards = cardData
    .map(
      (item) => CardModel(
          item['cardHolder'].toString(),
          item['cardNumber'].toString(),
          item['balance'].toString(),
          item['cardExpDate'].toString(),
          item['cvv'].toString(),
          item['type'].toString()),
    )
    .toList();

var cardData = [
  {
    "cardHolder": "Personal Saving",
    "cardNumber": "**** **** **** 1234",
    "balance": "85000",
    "cardExpDate": "12/25",
    "cvv": "**9",
    "type": "1",
  },
  {
    "cardHolder": "Contribution for EVent",
    "cardNumber": "**** **** **** 7845",
    "balance": "38000",
    "cardExpDate": "12/25",
    "cvv": "**9",
    "type": "2",
  }
];
