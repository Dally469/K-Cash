import 'dart:collection';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kcash/Pages/transfer_form.dart';
import 'package:kcash/Pages/transfer_summary.dart';
import 'package:kcash/models/card_model.dart';
import 'package:kcash/models/group_model.dart';
import 'package:kcash/models/send_account_model.dart';
import 'package:kcash/models/transaction_model.dart';
import 'package:kcash/utils/colors.dart';
import 'package:provider/provider.dart';

class Transfer extends StatefulWidget {
  const Transfer({Key? key}) : super(key: key);

  @override
  _TransferState createState() => _TransferState();
}

class OnGoingOrdersViewModel extends ChangeNotifier {}

class _TransferState extends State<Transfer>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late TabController _tabController;

  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3)
      ..addListener(_tabListener);
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  _tabListener() {
    setState(() {});
  }

  _scrollListener() {
    final current = _scrollController.position.pixels;
    final max = _scrollController.position.maxScrollExtent;
    if (max <= current) {
      if (_tabController.index == 0) {
        // Provider.of<OnGoingOrdersViewModel>(context, listen: false).loadMoreOrders();
      } else {
        print('Load more completed.');
      }
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_tabListener);
    _tabController.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      controller: _scrollController,
      physics: AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      slivers: <Widget>[
        SliverAppBar(
          floating: false,
          elevation: 0,
          backgroundColor: greenColor,
          pinned: false,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("My Orders",
                style: TextStyle(
                  color: Colors.white,
                )),
          ),
          bottom: TabBar(
            controller: _tabController,
            labelColor: greenColor,
            unselectedLabelColor: whiteColor,
            indicatorColor: orangeColor,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(35), // Creates border
                color: Colors.white),
            tabs: [
              Tab(text: "My Account"),
              Tab(text: "People"),
              Tab(text: "Groups"),
            ],
          ),
        ),
        CupertinoSliverRefreshControl(
          onRefresh: () {
            if (_tabController.index == 0) {
              print('Refresh on going.');
            } else {
              print('Refresh completed.');
            }
            return Future.delayed(Duration(seconds: 2));
          },
        ),
        SliverFillRemaining(
          child: TabBarView(
            children: [
              _Account(),
              _People(),
              _Group(),
            ],
            controller: _tabController,
          ),
          fillOverscroll: true,
          hasScrollBody: true,
        )
      ],
    ));
  }
}

class _Account extends StatelessWidget {
  final format = NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: cards.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            TransferForm(cards[index].cardHolder)));
              },
              child: Container(
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                      height: 140,
                      width: MediaQuery.of(context).size.width - 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colorWhiteOriginal,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                              left: 20,
                              top: 10,
                              child: Text(
                                cards[index].type == "1"
                                    ? "My Wallet"
                                    : "Personal Saving",
                                style: GoogleFonts.nunito(
                                    fontSize: 16,
                                    color: greenColor,
                                    fontWeight: FontWeight.w700),
                              )),
                          Positioned(
                              top: 20,
                              right: 20,
                              child: cards[index].type == "1"
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
                              top: 40,
                              child: cards[index].type == "1"
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
                              top: 40,
                              child: Text(
                                "Balance",
                                style: GoogleFonts.nunito(
                                    fontSize: 15,
                                    color: blackColor,
                                    fontWeight: FontWeight.w300),
                              )),
                          Positioned(
                              left: 100,
                              top: 68,
                              child: Text(
                                "FRW",
                                style: GoogleFonts.nunito(
                                    fontSize: 12,
                                    color: blackColor,
                                    fontWeight: FontWeight.w400),
                              )),
                          Positioned(
                              left: 135,
                              top: 65,
                              child: Text(
                                format
                                    .format(int.parse(cards[index].balance))
                                    .toString(),
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
            );
          }),
    );
  }
}

class _People extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: cards.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            TransferForm(cards[index].cardHolder)));
              },
              child: Container(
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                      height: 140,
                      width: MediaQuery.of(context).size.width - 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colorWhiteOriginal,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                              left: 20,
                              top: 10,
                              child: Text(
                                cards[index].type == "1"
                                    ? "My Wallet"
                                    : "Personal Saving",
                                style: GoogleFonts.nunito(
                                    fontSize: 16,
                                    color: greenColor,
                                    fontWeight: FontWeight.w700),
                              )),
                          Positioned(
                              top: 20,
                              right: 20,
                              child: cards[index].type == "1"
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
                              top: 40,
                              child: cards[index].type == "1"
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
                              top: 40,
                              child: Text(
                                "Balance",
                                style: GoogleFonts.nunito(
                                    fontSize: 15,
                                    color: blackColor,
                                    fontWeight: FontWeight.w300),
                              )),
                          Positioned(
                              left: 100,
                              top: 68,
                              child: Text(
                                "FRW",
                                style: GoogleFonts.nunito(
                                    fontSize: 12,
                                    color: blackColor,
                                    fontWeight: FontWeight.w400),
                              )),
                          Positioned(
                              left: 135,
                              top: 65,
                              child: Text(
                                "ss",
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
            );
          }),
    );
  }
}

class _Group extends StatefulWidget {
  const _Group({Key? key}) : super(key: key);

  @override
  __GroupState createState() => __GroupState();
}

class __GroupState extends State<_Group> {
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: groups.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  current = index;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TransferSummary()));
                });
              },
              child: GroupCard(
                groups[index].id,
                groups[index].name,
                groups[index].profile,
                current == index,
                this,
              ),
            );
          }),
    );
  }
}

class GroupCard extends StatefulWidget {
  final String groupId;
  final String title;
  final String photo;
  final bool isSelected;
  __GroupState context;

  GroupCard(
      this.groupId, this.title, this.photo, this.isSelected, this.context);

  @override
  _GroupCardState createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: widget.isSelected ? greenOverlayColor : colorWhiteOriginal,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            height: 55,
            width: 55,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage(
                      widget.isSelected ? widget.photo : widget.photo)),
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: widget.isSelected ? greenColor : greenColor),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: widget.isSelected ? greenColor : greenColor),
              ),
            ],
          )
        ],
      ),
    );
  }
}
