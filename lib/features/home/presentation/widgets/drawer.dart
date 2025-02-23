import 'package:azan_reminder/core/constants/exports.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:azan_reminder/core/common/cubit/app_user/app_user_cubit.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).colorScheme.primary,
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/header_image.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.transparent),
                accountName: BlocBuilder<AppUserCubit, AppUserState>(
                  builder: (context, state) {
                    if (state is AppUserLoggedIn) {
                      return Text(
                        state.user.name,
                        style: TextStyle(color: Colors.white),
                      );
                    }
                    return Text('Guest', style: TextStyle(color: Colors.white));
                  },
                ),
                accountEmail: BlocBuilder<AppUserCubit, AppUserState>(
                  builder: (context, state) {
                    if (state is AppUserLoggedIn) {
                      return Text(
                        state.user.email,
                        style: TextStyle(color: Colors.white),
                      );
                    }
                    return Text(
                      'guest@example.com',
                      style: TextStyle(color: Colors.white),
                    );
                  },
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Icon(Icons.person, size: 40, color: Colors.white),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.white),
              title: Text('Home', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pushNamed(context, RoutesName.home);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.white),
              title: Text('Settings', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Navigator.pushNamed(context, RoutesName.settings);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.white),
              title: Text('Sign Out', style: TextStyle(color: Colors.white)),
              onTap: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    RoutesName.auth,
                    (route) => false,
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
