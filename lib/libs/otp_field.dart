import 'package:flutter/material.dart';

class OTPField extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;
  final Function(String) onChange;

  const OTPField(this.controller, this.autoFocus, this.onChange, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 50,
      child: TextField(
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: controller,
        maxLength: 1,
        cursorColor: Theme
            .of(context)
            .primaryColor,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            counterText: '',
            hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
        onChanged: onChange,
      ),
    );
  }
}

class OTPTextField extends StatefulWidget {
  const OTPTextField({Key? key}) : super(key: key);


  @override
  State<OTPTextField> createState() => _OTPTextFieldState();
}

class _OTPTextFieldState extends State<OTPTextField> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> wList = [];
    final List<TextEditingController> cList = [];

    for (var i; i < 5; i++) {
      final controller = TextEditingController();
      wList.add(OTPField(controller, (i == 0) ? true : false, (p0) => null))
      cList.add(controller);
    }


    return;
  }
}

