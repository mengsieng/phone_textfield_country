import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String phoneNumber;
  String phoneIsoCode;
  bool visible = false;
  String confirmedNumber = '';

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    print(number);
    setState(() {
      phoneNumber = number;
      phoneIsoCode = isoCode;
    });
  }

  onValidPhoneNumber(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      visible = true;
      confirmedNumber = internationalizedPhoneNumber;
    });
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('International Phone Input Example'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Spacer(flex: 1),
            InternationalPhoneInput(
              controller: controller,
              onPhoneNumberChange: onPhoneNumberChange,
              initialPhoneNumber: phoneNumber,
              initialSelection: phoneIsoCode,
              enabledCountries: ['+855', '+1'],
              labelText: "Phone Number",
            ),
            SizedBox(height: 20),
            InternationalPhoneInput(
              decoration: InputDecoration.collapsed(hintText: '(123) 123-1234'),
              onPhoneNumberChange: onPhoneNumberChange,
              initialPhoneNumber: phoneNumber,
              initialSelection: phoneIsoCode,
              enabledCountries: ['+855', '+1'],
              showCountryCodes: false,
              showCountryFlags: true,
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.black,
            ),
            SizedBox(height: 50),
            InternationalPhoneInputText(
              onValidPhoneNumber: onValidPhoneNumber,
            ),
            Visibility(
              child: Text(confirmedNumber),
              visible: visible,
            ),
            Spacer(flex: 2),
            RaisedButton(
              child: Text('Request Pin'),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  print(controller.value);
                }
                // authProvider.requestPin(textEditingController.text);
              },
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
