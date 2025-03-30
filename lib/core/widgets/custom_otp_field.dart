import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:plannify/core/themes/colors.dart';
import 'package:plannify/core/utils/extensions/extensions.dart';

class MyOtpField extends StatefulWidget {
  final void Function(String)? onCompleted;
  final bool isLoading;
  final int length;
  final bool isClear;

  const MyOtpField({
    super.key,
    this.onCompleted,
    this.isLoading = false,
    this.length = 4,
    this.isClear = false,
  });

  @override
  State<MyOtpField> createState() => _MyOtpFieldState();
}

class _MyOtpFieldState extends State<MyOtpField> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MyOtpField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isClear && !oldWidget.isClear) {
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final focusedBorderColor =
        context.inputDecorationTheme.focusedBorder!.borderSide.color;
    final fillColor = context.inputDecorationTheme.fillColor;
    final borderColor =
        context.inputDecorationTheme.enabledBorder!.borderSide.color;

    final defaultPinTheme = PinTheme(
      width: 60.w,
      height: 55.h,
      textStyle: context.textTheme.bodyLarge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
    );

    return Pinput(
      length: widget.length,
      controller: controller,
      focusNode: focusNode,
      readOnly: widget.isLoading,
      closeKeyboardWhenCompleted: true,
      autofocus: true,
      showCursor: true,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          border: Border.all(color: focusedBorderColor, width: 1.5),
        ),
      ),
      submittedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          color: fillColor,
          border: Border.all(color: focusedBorderColor, width: 1.5),
        ),
      ),
      errorPinTheme: defaultPinTheme.copyWith(
        decoration: BoxDecoration(
          color: ColorManager.error,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1.5),
        ),
      ),
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      // onClipboardFound: (value) => controller.setText(value),
      onCompleted: (pin) {
        if (widget.onCompleted != null) {
          widget.onCompleted!(pin);
        }
      },

      cursor: Container(
        margin: const EdgeInsets.only(bottom: 9),
        width: 2,
        height: 30,
        color: ColorManager.primary,
      ),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      enabled: !widget.isLoading,
      hapticFeedbackType: HapticFeedbackType.lightImpact,
    );
  }
}
