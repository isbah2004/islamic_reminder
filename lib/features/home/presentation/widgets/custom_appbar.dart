import 'package:azan_reminder/core/constants/exports.dart';

class CustomAppbar extends StatefulWidget {
  const CustomAppbar({super.key});

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: 120,
      color: Theme.of(context).colorScheme.primary,
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '23 رمضان 1446',
            style: AppTheme.defaultTextStyle(
              fontWeight: FontWeight.w600,
              color: AppPallete.whiteColor,
              fontSize: 20,
            ),
          ),
          IconButton(
            onPressed: () {
             Scaffold.of(context).openEndDrawer();
            },
            icon: Icon(Icons.menu, color: AppPallete.whiteColor, size: 30),
          ),
        ],
      ),
    );
  }
}
