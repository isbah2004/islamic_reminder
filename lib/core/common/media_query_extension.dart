import 'package:azan_reminder/core/constants/exports.dart';

extension MediaQueryExtension on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

  double widthPercentage(double percentage) {
    return width * (percentage / 100);
  }

  double heightPercentage(double percentage) {
    return height * (percentage / 100);
  }
}