import 'package:flutter/material.dart';
import 'package:maan_application_1/ui/auth/models/register_request.dart';
import 'package:maan_application_1/ui/auth/provider/auth_provider.dart';
import 'package:maan_application_1/ui/auth/ui/widgets/custom_textfield.dart';
import 'package:maan_application_1/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatelessWidget {
  static final routeName = 'editScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
        backgroundColor: Color(0XFFE79215),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Consumer<AuthProvider>(builder: (context, provider, x) {
            return Form(
              key: provider.editKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextfeild(
                      label: 'User Name',
                      controller: provider.userNameController,
                    ),
                    CustomTextfeild(
                      label: 'Phone',
                      controller: provider.phoneController,
                      textInputType: TextInputType.phone,
                    ),
                    CustomTextfeild(
                      label: 'Country',
                      controller: provider.countryController,
                    ),
                    CustomTextfeild(
                      label: 'City',
                      controller: provider.cityController,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: 15, left: 20),
                                  child: Text('Gender')),
                              RadioListTile(
                                  title: Text('Male'),
                                  value: Gender.male,
                                  groupValue: provider.selectedGender,
                                  onChanged: (value) {
                                    provider.saveGender(value);
                                  }),
                              RadioListTile(
                                  title: Text('Female'),
                                  value: Gender.female,
                                  groupValue: provider.selectedGender,
                                  onChanged: (value) {
                                    Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .saveGender(value);
                                  })
                            ],
                          ),
                        ),
                      ],
                    ),
                    CustomButton(title: 'Save', function: provider.editProfile),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
