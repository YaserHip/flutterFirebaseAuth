import 'package:flutter/material.dart';

class OTPField extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;

  const OTPField(this.controller, this.autoFocus, {Key? key}) : super(key: key);

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
        cursorColor: Theme.of(context).primaryColor,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            counterText: '',
            hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
        onChanged: (value) {
          FocusScope.of(context).nextFocus();
        },
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
  String textO = "";

  @override
  Widget build(BuildContext context) {
    final List<Widget> wList = [];
    final List<TextEditingController> cList = [];

    for (var i = 0; i < 3; i++) {
      var controller = TextEditingController();
      controller.addListener(() {
        setState(() {
          textO = "";
          for (var element in cList) {
            textO += element.text;
          }
        });
      });
      cList.add(controller);
      wList.add(OTPField(controller, (i == 0) ? true : false));
    }

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return wList[index];
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          width: 8,
        );
      },
      shrinkWrap: true,
      itemCount: wList.length,
    );
  }
}
