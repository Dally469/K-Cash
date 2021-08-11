class GroupModel {
  String id;
  String name;
  String profile;


  GroupModel(this.id, this.name, this.profile);
}

List<GroupModel> groups = cardData
    .map(
      (item) => GroupModel(
    item['id'].toString(),
    item['name'].toString(),
    item['profile'].toString(),
  ),
).toList();

var cardData = [
  {
    "1": "32",
    "name": "Top up weww weewwwrwrwe",
    "profile": "assets/images/profile.png",
  },
  {
    "1": "43",
    "name": "Payment",
    "profile": "assets/images/profile.png",
  },
  {
    "1": "12",
    "name": "Transfer",
    "profile": "assets/images/profile.png",
  },
  {
    "1": "3",
    "name": "Withdraw",
    "profile": "assets/images/profile.png",
  },
];
