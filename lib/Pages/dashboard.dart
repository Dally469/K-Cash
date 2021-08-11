import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kcash/Pages/transaction_details.dart';
import 'package:kcash/models/operation_model.dart';
import 'package:kcash/models/transaction_model.dart';
import 'package:kcash/utils/colors.dart';
import 'package:kcash/models/card_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kcash/utils/placehoder.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
// CUrrent selected
  int current = 0;
  int currentCard = 0;

  final List<Widget> _children = [
    PlaceholderWidget(Colors.pink),
    PlaceholderWidget(Colors.blueGrey),
    PlaceholderWidget(Colors.orange),
    PlaceholderWidget(Colors.teal)
  ];

  //Handle indicator
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
  final format = NumberFormat("#,##0.00", "en_US");

  ScrollController _scrollController = ScrollController();
  bool closeTopContainer = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        closeTopContainer = _scrollController.offset > 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double operationHeight = size.height * 0.19;
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: Container(
                height: size.height * .6,
                decoration: BoxDecoration(
                    color: greenColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 19,  top: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Hey!",
                        style: GoogleFonts.inter(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: whiteColor),
                      ),
                      Text(
                        "KAREMERA Jones Dev",
                        style: GoogleFonts.inter(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: whiteColor),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 160,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: cards.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentCard = index;
                                  });
                                },
                                child: Card(
                                    cards[index].cardHolder,
                                    cards[index].cardNumber,
                                    cards[index].balance,
                                    cards[index].type,
                                    currentCard == index,
                                    this),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 20, right: 16, bottom: 6, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Operations",
                    style: GoogleFonts.nunito(
                        color: greenColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 19),
                  ),
                  Row(
                    children: map<Widget>(operations, (index, selected) {
                      return Container(
                        alignment: Alignment.centerLeft,
                        height: current == index ? 15 : 6,
                        width: current == index ? 15 : 6,
                        margin: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: current == index ? greenColor : primaryColor,
                        ),
                      );
                    }),
                  )
                ],
              ),
            ),
            Container(
              height: 110,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 15, top: 10),
                  itemCount: operations.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          current = index;
                        });
                      },
                      child: OperationCard(
                          operations[index].name,
                          operations[index].activeIcon,
                          operations[index].inActiveIcon,
                          current == index,
                          this),
                    );
                  }),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, bottom: 10, right: 16, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      height: 33,
                      width: 33,
                      decoration: BoxDecoration(
                          color: greyOverlayColor, shape: BoxShape.circle),
                      child: Icon(
                        Icons.history_outlined,
                        color: greenColor,
                      )),
                  Text(
                    "Transactions",
                    style: GoogleFonts.nunito(
                        color: primaryColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 19),
                  ),
                  IconButton(
                      onPressed: (){
                        showSearch(context: context, delegate: TransactionSearch());
                      },
                      icon: Icon(
                        Icons.search,
                        size: 27,
                        color: blackGrey,
                      ))

                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.only(left: 15, top: 15),
                  shrinkWrap: true,
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          print("Transaction tapped");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      TransactionDetails(transactions[index])));
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10, bottom: 8, right: 10),
                        height: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: whiteColor),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                                left: 55,
                                top: 20,
                                child: Text(
                                  transactions[index].transaction_title,
                                  style: GoogleFonts.nunito(
                                      fontSize: 15,
                                      color: blackGrey,
                                      fontWeight: FontWeight.w700),
                                )),
                            Positioned(
                                left: 55,
                                bottom: 20,
                                child: Text(
                                 format.format(int.parse( transactions[index].amount)),
                                  style: GoogleFonts.nunito(
                                      fontSize: 14,
                                      color: blackGrey,
                                      fontWeight: FontWeight.w300),
                                )),
                            Positioned(
                                right: 10,
                                bottom: 30,
                                child: Text(
                                  transactions[index].status == "1" ? "Successful" : "Pending",
                                  style: GoogleFonts.nunito(
                                      fontSize: 14,
                                      color: transactions[index].status == "1" ? greenColor : orangeColor,
                                      fontWeight: FontWeight.w800),
                                )),

                            Positioned(
                              left: 10,
                              top: 10,
                              bottom: 10,
                              child:  Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage(transactions[index].icon)
                                    )
                                ),

                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class OperationCard extends StatefulWidget {
  final String operation;
  final String selectedIcon;
  final String unselectedIcon;
  final bool isSelected;
  _DashboardState context;

  OperationCard(this.operation, this.selectedIcon, this.unselectedIcon,
      this.isSelected, this.context);

  @override
  _OperationCardState createState() => _OperationCardState();
}

class _OperationCardState extends State<OperationCard> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: FittedBox(
        fit: BoxFit.fill,
        alignment: Alignment.topCenter,
        child: Container(
          margin: EdgeInsets.only(right: 10),
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              color: widget.isSelected ? primaryDarkColor : whiteColor),
          child: Column(
            children: <Widget>[
              FittedBox(
                fit: BoxFit.fill,
                child: Container(
                  height: 40,
                  width: 40,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage(widget.isSelected
                            ? widget.selectedIcon
                            : widget.unselectedIcon)),
                  ),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                widget.operation,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: widget.isSelected ? whiteColor : greenColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Card extends StatefulWidget {
  final String holder;
  final String number;
  final String balance;
  final String type;
  final bool isTapped;
  _DashboardState context;

  Card(this.holder, this.number, this.balance, this.type, this.isTapped,
      this.context);

  @override
  _CardState createState() => _CardState();
}

class _CardState extends State<Card> {
  final format = NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
          child: Row(
           children: [
            Container(
               margin: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
               height: 180,
               width: MediaQuery.of(context).size.width-60,
               decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(15), color: whiteColor),
               child: Stack(
                 children: <Widget>[
                   Positioned(
                       left: 20,
                       top: 10,
                       child: Text(
                         widget.type == "1" ? "My Wallet" : "Personal Saving",
                         style: GoogleFonts.nunito(
                             fontSize: 16,
                             color: greenColor,
                             fontWeight: FontWeight.w700),
                       )),
                   Positioned(
                       top: 20,
                       right: 20,
                       child: widget.type == "1"
                           ? Image.asset(
                         "assets/images/chip.png",
                         width: 20,
                         height: 20,
                       )
                           : Image.asset(
                         "assets/images/chip.png",
                         width: 25,
                         height: 25,
                       )),
                   Positioned(
                       left: 18,
                       bottom: 50,
                       child: widget.type == "1"
                           ? Image.asset(
                         "assets/images/wallet_saving.png",
                         width: 60,
                         height: 60,
                       )
                           : Image.asset(
                         "assets/images/personal.png",
                         width: 40,
                         height: 40,
                       )),
                   Positioned(
                       left: 100,
                       bottom: 100,
                       child: Text(
                         widget.isTapped
                             ? widget.type == "1"
                             ? "Wallet Balance"
                             : "Account Balance"
                             : "",
                         style: GoogleFonts.nunito(
                             fontSize: 12,
                             color: blackColor,
                             fontWeight: FontWeight.w300),
                       )),
                   Positioned(
                       left: 100,
                       bottom: 78,
                       child: Text(
                         widget.isTapped ? "FRW" : "",
                         style: GoogleFonts.nunito(
                             fontSize: 10,
                             color: blackColor,
                             fontWeight: FontWeight.w400),
                       )),
                   Positioned(
                       left: 135,
                       bottom: 60,
                       child: Text(
                         widget.isTapped
                             ? format.format(int.parse(widget.balance)).toString()
                             : "Tap to View",
                         style: GoogleFonts.nunito(
                             fontSize: 25,
                             color: blackColor,
                             fontWeight: FontWeight.w700),
                       ))
                 ],
               ),
             ),
           ],
          ),
        ),
      ),
    );
  }
}


class TransactionSearch extends SearchDelegate<String>{

  final recent_cities = [
    "Kigali",
    "Huye",
    "Musaze",
  ];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: (){
            query = "";
          },
          icon: Icon(Icons.clear)
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: (){
          close(context, "null");
        },
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow,
            progress: transitionAnimation
        )
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final format = NumberFormat("#,##0.00", "en_US");
   final suggestionList = query.isEmpty ? transactions : transactions.where((p) => p.transaction_title.startsWith(query)).toList();
   return ListView.builder(
       itemBuilder: (context, index){
         return GestureDetector(
           onTap: () {
             Navigator.push(
                 context,
                 MaterialPageRoute(
                     builder: (context) =>
                         TransactionDetails(transactions[index])));
           },
           child: Container(
             margin: EdgeInsets.only(left: 10, bottom: 8, right: 10),
             height: 80,
             decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(10),
                 color: whiteColor),
             child: Stack(
               children: <Widget>[
                 Positioned(
                     left: 50,
                     top: 20,
                     child: Text(
                       transactions[index].transaction_title,
                       style: GoogleFonts.nunito(
                           fontSize: 15,
                           color: blackGrey,
                           fontWeight: FontWeight.w700),
                     )),
                 Positioned(
                     left: 50,
                     bottom: 20,
                     child: Text(
                       format.format(int.parse( transactions[index].amount)),
                       style: GoogleFonts.nunito(
                           fontSize: 14,
                           color: blackGrey,
                           fontWeight: FontWeight.w300),
                     )),
                 Positioned(
                     right: 10,
                     bottom: 30,
                     child: Text(
                       transactions[index].status == "1" ? "Successful" : "Pending",
                       style: GoogleFonts.nunito(
                           fontSize: 14,
                           color: transactions[index].status == "1" ? greenColor : orangeColor,
                           fontWeight: FontWeight.w800),
                     )),

                 Positioned(
                   left: 10,
                   top: 10,
                   bottom: 10,
                   child:  Container(
                     height: 35,
                     width:35,
                     decoration: BoxDecoration(
                         shape: BoxShape.circle,
                         image: DecorationImage(
                             image: AssetImage(transactions[index].icon)
                         )
                     ),

                   ),
                 ),
               ],
             ),
           ),
         );
       },
     itemCount: suggestionList.length,
   );
  }
  
}