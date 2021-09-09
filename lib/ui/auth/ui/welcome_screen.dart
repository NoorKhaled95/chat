import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maan_application_1/ui/auth/ui/login_screen.dart';
import 'package:maan_application_1/ui/helpers/route_helper.dart';
import 'package:maan_application_1/widgets/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  static final routeName = 'welcomehPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/back.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 10),
              child: Text("Instantly chat with friends",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 50.0,
                        fontWeight: FontWeight.w900),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 0.8),
              child: Text(
                  "Keep connection, Exchange information, Keep your favourites a touch away",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        color: Colors.white, fontSize: 18.0, height: 1.5),
                  )),
            ),
            SizedBox(
              height: 22.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: CustomButton(
                  title: 'Get started',
                  function: () => RouteHelper.routeHelper
                      .goAndReplacePage(LoginScreen.routeName)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 20.0),
                  child: Text("©2021,Noor Khaled",
                      style: GoogleFonts.lato(
                        textStyle:
                            TextStyle(color: Colors.white, fontSize: 10.0),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
