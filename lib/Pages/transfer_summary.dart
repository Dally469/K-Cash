import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kcash/utils/colors.dart';

class TransferSummary extends StatefulWidget {
  const TransferSummary({Key? key}) : super(key: key);

  @override
  _TransferSummaryState createState() => _TransferSummaryState();
}

class _TransferSummaryState extends State<TransferSummary> {
  final _controller = TextEditingController();
  static const _locale = 'en';
  String _formatNumber(String s) => NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency => NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
           Column(
            children: [
              Container(
                height: 112,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: greenColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40))),
                child: Stack(
                  children: [
                    Positioned(
                        top: 40,
                        left: 10,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              size: 27,
                              color: whiteColor,
                            ))),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Center(
                        child: Positioned(
                            top: 80,
                            left: 50,
                            right: 50,
                            child: Text(
                              "Transfer summary",
                              style: GoogleFonts.nunito(
                                  color: whiteColor, fontSize: 25),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 300,
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: colorWhiteOriginal),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                              left: 70,
                              top: 18,
                              child: Text(
                                "Ishimwe Test",
                                style: GoogleFonts.nunito(
                                    fontSize: 15,
                                    color: blackGrey,
                                    fontWeight: FontWeight.w700),
                              )),
                          Positioned(
                              left: 70,
                              bottom: 18,
                              child: Text(
                                "7888887878",
                                style: GoogleFonts.nunito(
                                    fontSize: 14,
                                    color: blackGrey,
                                    fontWeight: FontWeight.w300),
                              )),
                          Positioned(
                            left: 10,
                            top: 10,
                            bottom: 10,
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: greenColor,
                                  image: DecorationImage(
                                      image: AssetImage(
                                        "assets/images/profile.png",
                                      ))),
                            ),
                          ),
                          Positioned(
                            right: 10,
                            top: 20,
                            child: Text(
                              "Amount"
                            ),
                          ),
                          Positioned(
                            right: 10,
                            top: 40,
                            child: Text(
                              "5,000",
                              style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  color: blackGrey,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "Transfer from",
                          style: GoogleFonts.nunito(
                              color: greenColor, fontSize: 17)
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 13, right: 13),
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: greyOverlayColor),
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
                                child: Icon(Icons.account_balance, size: 30, color: blackGrey,)
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
          Positioned(
            bottom: 30,
              right: 40,
              left: 40,
              child: RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(25))),
                  icon: Icon(Icons.arrow_forward, size: 25,),
                  label: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text("Transfer NOW", style: GoogleFonts.nunito(fontSize: 20),)
                  ),
                  textColor: whiteColor,
                  hoverColor: primaryColor,
                  color: greenColor,
                  onPressed: () {
                    _showMyCard();
                  })
          )

        ],
      ),
    );
  }
  Future<void> _showMyCard() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 90,
            margin: EdgeInsets.symmetric(vertical: 1),
            child: Column(
              children: [
                Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        color: greyOverlayColor, shape: BoxShape.circle),
                    child: Icon(
                      Icons.check_circle_outline_rounded,
                      color: greenColor,
                      size: 35,
                    )
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      'Transfer Successful',
                      style: GoogleFonts.nunito(color: greenColor)
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Back home'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

