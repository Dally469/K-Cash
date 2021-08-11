import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kcash/Pages/payment_method.dart';
import 'package:kcash/Pages/service_form.dart';
import 'package:kcash/models/services_model.dart';
import 'package:kcash/utils/colors.dart';

class Services extends StatefulWidget {
  const Services({Key? key}) : super(key: key);

  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  int current = 0;
  //Handle indicator
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        ListView(
          physics: ClampingScrollPhysics(),
          children: [
            Container(
              height: size.height * .1,
              decoration: BoxDecoration(
                  color: greenColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40))),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Services",
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600,
                          color: whiteColor,
                          fontSize: 25),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 16, bottom: 15, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "All services",
                    style: GoogleFonts.nunito(
                        color: greenColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 19),
                  ),
                  Row(
                    children: map<Widget>(services, (index, selected) {
                      return Container(
                        alignment: Alignment.centerLeft,
                        height: current == index ? 12 : 8,
                        width: current == index ? 12 : 8,
                        margin: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                          current == index ? greenColor : primaryColor,
                        ),
                      );
                    }),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              height: MediaQuery.of(context).size.height,
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    mainAxisSpacing: 10
                  ),
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        setState(() {
                          current = index;
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PaymentMethod())
                          );
                        });
                      },
                      child: ServiceCard(
                        services[index].serviceId,
                        services[index].title,
                        services[index].icon,
                        current == index,
                        this,
                      ),
                    );
                  }),
            )
          ],
        )
      ]),
    );
  }
}

class ServiceCard extends StatefulWidget {
  final String serviceId;
  final String title;
  final String icon;
  final bool isSelected;
  _ServicesState context;

  ServiceCard(
      this.serviceId, this.title, this.icon, this.isSelected, this.context);

  @override
  _ServiceCardState createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      width: 120,
      height: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: widget.isSelected ? greenOverlayColor : whiteColor),
      child: Column(
        children: <Widget>[
          Container(
            height: 55,
            width: 55,
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage(
                      widget.isSelected ? widget.icon : widget.icon)),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: widget.isSelected ? greenColor : greenColor),
          )
        ],
      ),
    );
  }
}

