import 'package:flutter/material.dart';
import 'package:maan_application_1/ui/auth/models/register_request.dart';
import 'package:maan_application_1/ui/auth/provider/auth_provider.dart';
import 'package:maan_application_1/ui/chat/ui/edit_screen.dart';
import 'package:maan_application_1/ui/chat/ui/widgets/item_widget.dart';
import 'package:maan_application_1/ui/helpers/route_helper.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  static final routeName = 'profilePage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0XFFE79215),
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.white,
            ),
            onPressed: () {
              // Provider.of<AuthProvider>(context, listen: false).logout();
              RouteHelper.routeHelper.goToPage(EditScreen.routeName);
            },
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Consumer<AuthProvider>(
          builder: (context, provider, x) {
            return provider.userModel == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          provider.updateUserImage();
                        },
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 23),
                            child: provider.userModel.imageUrl != null
                                ? Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        color: Color(0XFFE79215),
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                provider.userModel.imageUrl))),
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      provider.userModel.userName[0]
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        color: Color(0XFFE79215),
                                        shape: BoxShape.circle),
                                  ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Text(
                          provider.userModel.userName,
                          style:
                              Provider.of<AuthProvider>(context, listen: false)
                                  .headingStyleName,
                        ),
                      ),
                      ItemWidget(
                          'Email', provider.userModel.email, Icons.email),
                      ItemWidget('User Name', provider.userModel.userName,
                          Icons.person),
                      ItemWidget('Country', provider.userModel.country,
                          Icons.location_on),
                      ItemWidget(
                          'City', provider.userModel.city, Icons.location_on),
                      ItemWidget(
                          'Phone', provider.userModel.phoneNumber, Icons.phone),
                      ItemWidget(
                        'Gender',
                        provider.userModel.gender == Gender.male
                            ? 'Male'
                            : 'Female',
                        provider.userModel.gender == Gender.male
                            ? Icons.male
                            : Icons.female,
                      )
                    ],
                  );
          },
        ),
      ),
    );
  }
}
