import 'package:azan_reminder/core/constants/exports.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool loading;

  const CustomButton({super.key, required this.text, required this.onPressed, required this.loading});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF059669),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child:loading?CircularProgressIndicator(color: AppPallete.whiteColor,): Text(text, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
