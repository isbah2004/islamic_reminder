import 'package:azan_reminder/core/constants/exports.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool obscureText;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? nextFocusNode;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.focusNode,
    this.onFieldSubmitted,
    this.nextFocusNode,
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  late ValueNotifier<bool> _obscureTextNotifier;

  @override
  void initState() {
    super.initState();
    _obscureTextNotifier = ValueNotifier<bool>(widget.obscureText);
  }

  @override
  void dispose() {
    _obscureTextNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ValueListenableBuilder<bool>(
        valueListenable: _obscureTextNotifier,
        builder: (context, obscureText, child) {
          return TextFormField(
            focusNode: widget.focusNode,
            controller: widget.controller,
            obscureText: obscureText,
            keyboardType: widget.keyboardType,
            maxLines: 1,
            validator: widget.validator,
            onFieldSubmitted: (value) {
              if (widget.onFieldSubmitted != null) {
                widget.onFieldSubmitted!(value);
              }
              if (widget.nextFocusNode != null) {
                Utils.fieldFocusChange(
                  context,
                  widget.focusNode!,
                  widget.nextFocusNode!,
                );
              }
            },
            decoration: InputDecoration(
              labelText: widget.label,
              prefixIcon: Icon(widget.icon, color: Colors.grey),
              suffixIcon:
                  widget.obscureText
                      ? IconButton(
                        icon: Icon(
                          obscureText ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          _obscureTextNotifier.value = !obscureText;
                        },
                      )
                      : null,
            ),
          );
        },
      ),
    );
  }
}
