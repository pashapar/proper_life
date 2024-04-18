import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proper_life/features/events_nearby/widgets/widgets.dart';
import 'package:proper_life/features/my_events/my_events.dart';
import 'package:proper_life/features/profile/view/profile_screen.dart';
import 'package:proper_life/generated/l10n.dart';

class EventNearbyScreen extends StatefulWidget {
  const EventNearbyScreen({super.key});

  @override
  State<EventNearbyScreen> createState() => _EventNearbyScreenState();
}

class _EventNearbyScreenState extends State<EventNearbyScreen> {
  // final _eventsNeardyBloc = EventsNearbyBloc();
  // TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // _loadEventsNearby();
    // _eventsNeardyBloc.add(LoadEventsNearby());
    super.initState();
    _fetchUser();
  }

  void logOut(NavigatorState navigator) async {
    await FirebaseAuth.instance.signOut();
    navigator.pushNamedAndRemoveUntil(
      '/',
      (route) => false,
    );
  }

  var _selectedPageIndex = 0;
  final _pageController = PageController();
  String curUser = '';
  String curUsername = '';

  Future<void> _fetchUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final userId = currentUser.uid;
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        setState(() {
          curUser = userData['name'];
          curUsername = userData['userName'] ??
              ''; // Update selectedCity with userCity from Firebase
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: theme.iconTheme,
        title: Text(
          "ProPer life",
          style: theme.textTheme.titleLarge,
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                Color(0xff9257ff),
                Color(0xff5900ff),
              ])),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () => Fluttertoast.showToast(
                  msg: S.of(context).verySoonWillBeAbleToConnecting,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 4,
                  backgroundColor: const Color(0xffe7d9ff),
                  textColor: const Color(0xbf000000),
                  fontSize: 16.0),
              icon: const Icon(
                Icons.person_pin_circle_outlined,
                color: Colors.white,
                size: 33,
              ))
        ],
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (value) {
          setState(() => _selectedPageIndex = value);
        },
        children: [
          const EventsNearbyList(),
          MyEventScreen(
            userId: FirebaseAuth.instance.currentUser!.uid,
          ),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _openPage,
        showUnselectedLabels: false,
        unselectedItemColor: const Color(0xff959595),
        selectedItemColor: theme.primaryColor,
        elevation: 5,
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home_rounded),
              label: S.of(context).eventsNearby),
          BottomNavigationBarItem(
              icon: const Icon(Icons.view_day_outlined),
              label: S.of(context).myEvents),
          BottomNavigationBarItem(
              icon: const Icon(Icons.account_circle_outlined),
              label: S.of(context).profile)
        ],
      ),
      drawer: Drawer(
          backgroundColor: theme.scaffoldBackgroundColor,
          width: 300,
          elevation: 10,
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    SizedBox(
                      height: 150,
                      child: DrawerHeader(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        decoration: BoxDecoration(color: theme.primaryColor),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(curUser.toString(),
                                  style: theme.textTheme.titleMedium!
                                      .copyWith(fontSize: 22)),
                              Text(
                                curUsername.toString(),
                                style: theme.textTheme.titleMedium!
                                    .copyWith(fontSize: 18),
                              )
                            ]),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        S.of(context).home,
                        style: theme.textTheme.bodyMedium!
                            .copyWith(fontSize: 20, color: theme.primaryColor),
                      ),
                      leading: Icon(
                        Icons.home_rounded,
                        color: theme.primaryColor,
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed('/eventNearby');
                      },
                    ),
                    ListTile(
                      title: Text(
                        S.of(context).settings,
                        style: theme.textTheme.bodyMedium!
                            .copyWith(fontSize: 20, color: theme.primaryColor),
                      ),
                      leading: Icon(
                        Icons.miscellaneous_services_rounded,
                        color: theme.primaryColor,
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed('/settings');
                      },
                    ),
                    ListTile(
                      title: Text(
                        S.of(context).becomeAnOrganiser,
                        style: theme.textTheme.bodyMedium!
                            .copyWith(fontSize: 20, color: theme.primaryColor),
                      ),
                      leading: Icon(
                        Icons.auto_graph_rounded,
                        color: theme.primaryColor,
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed('/eventNearby/becomeOrganiser');
                      },
                    ),
                    ListTile(
                      title: Text(
                        'Bug report',
                        style: theme.textTheme.bodyMedium!
                            .copyWith(fontSize: 20, color: theme.primaryColor),
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed('/eventNearby/bugReport');
                      },
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: ListTile(
                  title: Text(
                    S.of(context).exit,
                    style: theme.textTheme.bodyMedium!
                        .copyWith(fontSize: 20, color: theme.primaryColor),
                  ),
                  leading: Icon(
                    Icons.exit_to_app_rounded,
                    color: theme.primaryColor,
                  ),
                  onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: Text(S.of(context).areYouSure),
                            content: Text(
                                S.of(context).areYouWantLogOutFromYourAccount),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(S.of(context).cancel)),
                              TextButton(
                                  onPressed: () {
                                    logOut(Navigator.of(context));
                                  },
                                  child: Text(S.of(context).logOut)),
                            ],
                          )),
                  // () {
                  //   FirebaseService().logOut();
                  // },
                ),
              ),
            ],
          )),
    );
  }

  void _openPage(int index) {
    setState(() => _selectedPageIndex = index);
    _pageController.jumpToPage(index);
    // _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  // Future<void> _loadEventsNearby() async {
  //   _eventsNearby =
  //       await GetIt.I<AbstractEventsNearbyRepository>().getEventsNearby();
  //       setState(() {});
  // }
}
