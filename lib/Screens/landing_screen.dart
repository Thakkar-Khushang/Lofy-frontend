import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: screenSize.width,
        child: Padding(
          padding: EdgeInsets.only(top: screenSize.height / 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              spreadRadius: 5,
                              offset: Offset(3, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 74,
                                right: 74,
                                top: 21,
                              ),
                              child: Text(
                                'LOFY',
                                style: TextStyle(
                                  fontSize: 64,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 19, right: 19, top: 0, bottom: 21),
                              child: Text(
                                'A marketplace for local businesses',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )),
                    Positioned(top: -85, child: Image.asset("assets/logo.png"))
                  ]),
              Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Text("Get started as",
                      style: TextStyle(
                        fontSize: 24,
                        // fontWeight: FontWeight.bold,
                      ))),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.black,
                      minimumSize: Size(screenSize.width * 0.5, 60),
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100.0)),
                      ),
                    ),
                    child: Text("Buyer", style: TextStyle(fontSize: 20))),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 23.0),
                child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.black,
                      minimumSize: Size(screenSize.width * 0.5, 60),
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100.0)),
                      ),
                    ),
                    child: Text("Seller", style: TextStyle(fontSize: 20))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
