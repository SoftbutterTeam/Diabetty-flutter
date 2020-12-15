import 'dart:math';

import 'package:diabetty/blocs/team_manager.dart';
import 'package:diabetty/ui/screens/teams/components/sub_page_background.dart';
import 'package:diabetty/ui/screens/teams/components/sub_page_header.dart';
import 'package:diabetty/ui/screens/therapy/components/InputTextField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SupportScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, ValueNotifier<bool> isLoading, __) =>
            SupportScreen(isLoading: isLoading.value),
      ),
    );
  }
}

class SupportScreen extends StatefulWidget {
  final bool isLoading;
  const SupportScreen({Key key, this.isLoading}) : super(key: key);

  @override
  _SupportScreenState createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  String initialCountry = 'GB';
  PhoneNumber number = PhoneNumber(isoCode: 'GB');

  String phoneNo;
  TeamManager teamManager;

  @override
  void initState() {
    teamManager = Provider.of<TeamManager>(context, listen: false);

    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SubPageBackground(
        header: SubPageHeader(
          text: 'Support',
          backFunction: () {
            Navigator.pop(context);
            // _back();
          },
          saveFunction: () async {
            if (validatePhoneNo()) {
              print(await teamManager.requestToSupport(phoneNo));
              print(phoneNo);
              Navigator.pop(context);
            }
          },
        ),
        child: _body(context));
  }

  Widget _body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: _buildBody(size),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(Size size) {
    return Column(
      children: [
        SizedBox(height: min(50, size.height * 0.03)),
        Text('Please enter desired supporters number',
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: Colors.orange[800])),
        SizedBox(height: min(50, size.height * 0.01)),
        _buildPhoneNo(context),
        SizedBox(height: min(50, size.height * 0.02)),
        // _buildSupportNameField(),
      ],
    );
  }

  InputTextField _buildSupportNameField() {
    return InputTextField(
      stackIcons: null,
      controller: nameController,
      placeholder: "Friend's Nick Name (optional)",
      initalName: '',
      onChanged: (val) {
        print(val);
        setState(() {});
        // or widget.manager.updateListeners();
      },
    );
  }

  Widget _buildPhoneNo(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Form(
      key: formKey,
      child: Container(
        //  height: 50,
        padding: EdgeInsets.symmetric(horizontal: min(30, size.width * 0.1)),
        child: InternationalPhoneNumberInput(
          onInputChanged: (PhoneNumber numb) {
            setState(() {
              phoneNo = numb.phoneNumber;
            });
          },
          onInputValidated: (bool value) {
            print(value);
          },
          selectorConfig: SelectorConfig(
            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
            //    backgroundColor: Colors.black,
          ),
          ignoreBlank: false,
          //  autoValidateMode: AutovalidateMode.disabled,
          selectorTextStyle: TextStyle(color: Colors.black),
          initialValue: number,
          textFieldController: controller,
        ),
      ),
    );
  }

  bool validatePhoneNo() {
    return formKey.currentState.validate();
  }

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');

    setState(() {
      this.number = number;
    });
  }
}
