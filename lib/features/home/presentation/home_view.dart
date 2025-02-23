import 'package:azan_reminder/core/constants/exports.dart';
import 'package:azan_reminder/features/home/presentation/widgets/alarm_card.dart';
import 'package:azan_reminder/features/home/presentation/widgets/custom_appbar.dart';
import 'package:azan_reminder/features/home/presentation/widgets/drawer.dart';
import 'package:azan_reminder/features/home/presentation/widgets/location_card.dart';
import 'package:azan_reminder/features/home/presentation/widgets/naat_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(endDrawer: CustomDrawer(),
      body: Column(
        children: [
          CustomAppbar(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  AlarmCard(),
                  SizedBox(height: 16),
                  LocationCard(),
                  SizedBox(height: 16),
                  NaatCard(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'Prayer Times',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Calender',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
