import 'package:azan_reminder/core/constants/exports.dart';

class AlarmCard extends StatefulWidget {
  const AlarmCard({super.key});

  @override
  State<AlarmCard> createState() => _AlarmCardState();
}

class _AlarmCardState extends State<AlarmCard> {
  bool isAlarmOn = true;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          border: Border(
            top: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 4,
            ),
          ),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Azan Alarm',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Next Prayer: Fajr - 4:45 AM',
              style: AppTheme.defaultTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppPallete.black,
              ),
            ),
            Text(
              'Countdown: 01:23:45',
              style: AppTheme.defaultTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: AppPallete.black,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Azan Alarm',
                  style: AppTheme.defaultTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppPallete.borderColor,
                  ),
                ),
                Switch(
                  value: isAlarmOn,
                  onChanged: (value) => setState(() => isAlarmOn = value),
                  activeColor: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
            DropdownButton<String>(
              value: 'Khadim Hussain Rizvi',
              menuWidth: context.width / 1.1,

              focusColor: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: .2),
              borderRadius: BorderRadius.circular(8),
              dropdownColor: AppPallete.whiteColor,
              items: [
                DropdownMenuItem(
                  value: 'Khadim Hussain Rizvi',
                  child: Text('Khadim Hussain Rizvi'),
                ),
              ],
              onChanged: (value) {},
              style: TextStyle(color: Colors.black),
              underline: Container(
                height: 1,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
