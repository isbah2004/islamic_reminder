import 'package:azan_reminder/core/constants/exports.dart';

class NaatCard extends StatefulWidget {
  const NaatCard({super.key});

  @override
  State<NaatCard> createState() => _NaatCardState();
}

class _NaatCardState extends State<NaatCard> {
  String selectedTune = 'TLP Naat';
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
        child: Row(
          children: [
            Expanded(
              child: DropdownButton<String>(
                value: selectedTune,
                items: [
                  DropdownMenuItem(value: 'TLP Naat', child: Text('TLP Naat')),
                  // Add other tunes here
                ],
                onChanged: (value) => setState(() => selectedTune = value!),
              ),
            ),
            SizedBox(width: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              child: Text(
                'Play',
                style: AppTheme.defaultTextStyle(color: AppPallete.whiteColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
