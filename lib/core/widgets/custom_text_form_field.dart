import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plannify/core/themes/constants/images.dart';
import 'package:plannify/core/utils/extensions/extensions.dart';
import 'package:plannify/core/utils/helpers/image_handler.dart';

import '../themes/colors.dart';

class MyTextFormField extends StatefulWidget {
  const MyTextFormField({
    super.key,
    this.hintText,
    this.onSaved,
    this.onFieldSubmitted,
    this.validator,
    this.controller,
    this.keyboardType,
    required this.title,
    this.obscureText = false,
    this.initialValue,
    this.onChanged,
  });
  final String? hintText;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String title;
  final bool? obscureText;
  final String? initialValue;
  final void Function(String)? onChanged;

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  bool isObscure = true;

  String? _defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return widget.title.isNotEmpty
          ? "${widget.title} cannot be empty"
          : "Field cannot be empty";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          alignment: AlignmentDirectional.centerStart,
          padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
          child: Text(widget.title, style: context.textTheme.bodyMedium),
        ),
        TextFormField(
          initialValue: widget.initialValue,
          style: context.textTheme.bodyMedium,
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          obscureText: widget.obscureText == true ? isObscure : false,
          validator: widget.validator ?? _defaultValidator,
          onFieldSubmitted: widget.onFieldSubmitted,
          onSaved: widget.onSaved,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            errorStyle: context.textTheme.bodyMedium?.copyWith(
              color: ColorManager.error,
            ),
            errorMaxLines: 2,
            hintText: widget.hintText,
            suffixIcon:
                widget.obscureText == true
                    ? IconButton(
                      icon: ImageHandler.image(
                        isObscure
                            ? ImageManager.nonVisibleIcon
                            : ImageManager.visibleIcon,
                        color: ColorManager.grayMedium,
                      ),
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                    )
                    : null,
          ),
        ),
      ],
    );
  }
}
