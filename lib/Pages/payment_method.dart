import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kcash/models/card_model.dart';
import 'package:kcash/utils/colors.dart';


class PaymentMethod extends StatefulWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  int current = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Choose Payment Method"),
      ),
      body: Stack(
        children: [
          ListView(
            physics: ClampingScrollPhysics(),
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 16, bottom: 15, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Account Card",
                      style: GoogleFonts.nunito(
                          color: greenColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 19),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                height: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: greyOverlayColor),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        left: 85,
                        top: 20,
                        child: Text(
                         "Add New Option",
                          style: GoogleFonts.nunito(
                              fontSize: 26,
                              color: greenColor,
                              fontWeight: FontWeight.w700),
                        )),
                    Positioned(
                      left: 20,
                      top: 10,
                      child:  Container(
                          height: 50,
                          width:50,
                          decoration: BoxDecoration(
                              color: greyOverlayColor,
                              shape: BoxShape.circle
                          ),
                          child: Icon(Icons.add, size: 35, color: greenColor,)
                      ),
                    ),

                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(15),
                height: 170,
                child: ListView.builder(
                    itemCount: cards.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            current = index;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PaymentMethod()));
                          });
                        },
                        child: AccountCard(
                          cards[index].cvv,
                          cards[index].balance,
                          cards[index].cardNumber,
                          cards[index].type,
                          current == index,
                          this,
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 16, bottom: 15, top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Other Method",
                      style: GoogleFonts.nunito(
                          color: greenColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 19),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 13, right: 13),
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: whiteColor),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        left: 75,
                        top: 20,
                        child: Text(
                          "Bank Transfer",
                          style: GoogleFonts.nunito(
                              fontSize: 20,
                              color: blackGrey,
                              fontWeight: FontWeight.w700),
                        )),
                    Positioned(
                        left: 75,
                        bottom: 20,
                        child: Text(
                          "1234 1234 1234 1234",
                          style: GoogleFonts.nunito(
                              fontSize: 13,
                              color: blackGrey,
                              fontWeight: FontWeight.w300),
                        )),

                    Positioned(
                      left: 10,
                      top: 10,
                      bottom: 10,
                      child:  Container(
                          height: 50,
                          width:50,
                          decoration: BoxDecoration(
                              color: greyOverlayColor,
                              shape: BoxShape.circle
                          ),
                          child: Icon(Icons.account_balance, size: 30, color: greenColor,)
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 13, top: 8, right: 13),
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: whiteColor),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        left: 75,
                        top: 20,
                        child: Text(
                          "Mobile Transfer",
                          style: GoogleFonts.nunito(
                              fontSize: 20,
                              color: blackGrey,
                              fontWeight: FontWeight.w700),
                        )),
                    Positioned(
                        left: 75,
                        bottom: 20,
                        child: Text(
                          "+(250) 785 194 260",
                          style: GoogleFonts.nunito(
                              fontSize: 13,
                              color: blackGrey,
                              fontWeight: FontWeight.w300),
                        )),

                    Positioned(
                      left: 10,
                      top: 10,
                      bottom: 10,
                      child:  Container(
                          height: 50,
                          width:50,
                          decoration: BoxDecoration(
                              color: greyOverlayColor,
                              shape: BoxShape.circle
                          ),
                          child: Icon(Icons.phone_android_sharp, size: 30, color: greenColor,)
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class AccountCard extends StatefulWidget {
  final String accountId;
  final String balance;
  final String number;
  final String type;
  final bool isSelected;
  _PaymentMethodState context;

  AccountCard(this.accountId, this.balance, this.number, this.type,
      this.isSelected, this.context);

  @override
  _AccountCardState createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
  final format = NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3),
      height: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: widget.isSelected ? whiteColor : whiteColor),
      child: Stack(
        children: <Widget>[
          Positioned(
              left: 70,
              top: 16,
              child: Text(
                widget.type == "1" ? "My Wallet" : "Personal Saving",
                style: GoogleFonts.nunito(
                    fontSize: 20,
                    color: blackGrey,
                    fontWeight: FontWeight.w700),
              )),
          Positioned(
              left: 70,
              top: 43,
              child: Text(
                "FRW",
                style: GoogleFonts.nunito(
                    fontSize: 11,
                    color: blackGrey,
                    fontWeight: FontWeight.w300),
              )),
          Positioned(
              left: 100,
              top: 40,
              child: Text(
                format.format(int.parse(widget.balance)).toString(),
                style: GoogleFonts.nunito(
                    fontSize: 18,
                    color: blackGrey,
                    fontWeight: FontWeight.w300),
              )),
          Positioned(
              right: 10,
              top: 30,
              child:  Container(
                  height: 25,
                  width:25,
                  decoration: BoxDecoration(
                      color: greyOverlayColor,
                      shape: BoxShape.circle
                  ),
                  child: Icon(Icons.arrow_forward_ios, size: 15, color: greenColor,)
              ),
          ),
          Positioned(
            top: 10,
            left: 5,
            bottom: 10,
            child: widget.type == "1"
                ? Image.asset(
                    "assets/images/wallet_saving.png",
                    width: 60,
                    height: 60,
                  )
                : Image.asset(
                    "assets/images/personal.png",
                    width: 60,
                    height: 60,
                  ),
          ),
        ],
      ),
    );
  }
}
