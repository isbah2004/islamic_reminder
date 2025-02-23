import 'package:azan_reminder/core/constants/exports.dart';

class LocationCard extends StatefulWidget {
  const LocationCard({super.key});

  @override
  State<LocationCard> createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {
  String selectedCountry = 'Pakistan';
  String selectedCity = 'Lahore';
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
              'Location',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: selectedCountry,
                    items: [
                      DropdownMenuItem(
                        value: 'Pakistan',
                        child: Text('Pakistan'),
                      ),
                      // Add other countries here
                    ],
                    onChanged:
                        (value) => setState(() => selectedCountry = value!),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: DropdownButton<String>(
                    value: selectedCity,
                    items: [
                      DropdownMenuItem(value: 'Lahore', child: Text('Lahore')),
                    ],
                    onChanged: (value) => setState(() => selectedCity = value!),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
