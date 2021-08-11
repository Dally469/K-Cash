import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kcash/Pages/transfer_summary.dart';
import 'package:kcash/utils/colors.dart';

class TransferForm extends StatefulWidget {
 final String receiver;


 TransferForm(this.receiver);

  @override
  _TransferFormState createState() => _TransferFormState();
}

class _TransferFormState extends State<TransferForm> {
  final _controller = TextEditingController();
  static const _locale = 'en';
  String _formatNumber(String s) => NumberFormat.decimalPattern(_locale).format(int.parse(s));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
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
                            "Send form",
                            style: GoogleFonts.nunito(
                                color: whiteColor, fontSize: 25),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 150,
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("assets/images/profile.png"))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.receiver,
                    style: GoogleFonts.nunito(color: blackGrey, fontWeight: FontWeight.w700, fontSize: 18),
                  )
                ],
              ),
            ),
            Container(
              height: 180,
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Amount",
                        contentPadding: EdgeInsets.all(15.0),
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          borderSide: new BorderSide(
                              color: whiteColor
                          ),

                        ),
                        filled: true,
                        fillColor: colorWhiteOriginal,
                      ),
                      onChanged: (string) {
                        string = '${_formatNumber(string.replaceAll(',', ''))}';
                        _controller.value = TextEditingValue(
                          text: string,
                          selection: TextSelection.collapsed(offset: string.length),
                        );
                      },
                      controller: _controller,
                      //fillColor: Colors.green
                      validator: (val) {
                        if(val!.length==0) {
                          return "Amount cannot be empty";
                        }else{
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      _showMyCard();
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: greyOverlayColor),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                              left: 60,
                              top: 17,
                              bottom: 15,
                              child: Text(
                                "Tap to Load Money",
                                style: GoogleFonts.nunito(
                                    fontSize: 18,
                                    color: blackGrey,
                                    fontWeight: FontWeight.w700),
                              )),
                          Positioned(
                            left: 10,
                            top: 15,
                            bottom: 15,
                            child:  Container(
                                height: 40,
                                width:40,
                                decoration: BoxDecoration(
                                    color: greyOverlayColor,
                                    shape: BoxShape.circle
                                ),
                                child: Icon(Icons.touch_app, size: 20, color: blackGrey,)
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
                        child: Text("Continue", style: GoogleFonts.nunito(fontSize: 20),)
                    ),
                    textColor: whiteColor,
                    hoverColor: primaryColor,
                    color: greenColor,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TransferSummary()));
                    })
            )
          ],
        ),

      ),
    );
  }
  Future<void> _showMyCard() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
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

