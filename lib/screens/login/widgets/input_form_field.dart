import 'package:flutter/material.dart';


class FormInputField extends StatelessWidget {
  const FormInputField({
    super.key,
    required this.controller,
    required this.prefixText,
    this.onChange,
    this.prefixColor,
    this.hintText = '',
    this.obscure,
    this.maxLines = 1,
    this.autoFillHints,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.color,
  });

  final TextEditingController controller;
  final String prefixText;
  final Function(String value)? onChange;
  final Color? prefixColor;
  final String hintText;
  final bool? obscure;
  final Color? color;
  final int maxLines;
  final Iterable<String>? autoFillHints;
  final TextInputType keyboardType;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: MediaQuery.of(context).size.width*0.12,
          margin: const EdgeInsets.only(left: 5,right: 5,top: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15)
          ),
          child: TextField(
            controller: controller,
            obscureText: obscure ?? false,
            maxLines: maxLines,
            autofillHints: autoFillHints ?? <String>[],
            keyboardType: keyboardType,
            cursorColor: prefixColor ?? const Color(0xff1A9BCA).withOpacity(0.6),
            textInputAction: TextInputAction.done,
            textCapitalization: TextCapitalization.words,
            onChanged: (value) {onChange!(value);},
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              suffixIcon: icon,
              hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w400
              ),
              hintText: prefixText,
              border: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(25.0),
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(25.0),
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(25.0),
                ),
              ),
              contentPadding: const EdgeInsets.all(15),
            ),
            //textDirection: appLanguage.isEn ? TextDirection.ltr : TextDirection.rtl,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color ?? const Color(0xff1A9BCA),
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
