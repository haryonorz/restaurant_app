part of 'pages.dart';

class SettingScreen extends StatelessWidget {
  static const routeName = '/setting';
  static const String settingTitle = 'Setting';

  const SettingScreen({Key? key}) : super(key: key);

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: black,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          settingTitle,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: false,
        border: const Border(bottom: BorderSide(color: Colors.transparent)),
        backgroundColor: Colors.white,
        leading: Row(
          children: [
            CupertinoNavigationBarBackButton(
              color: black,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        middle: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              settingTitle,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return ListView(
          children: [
            Material(
              child: ListTile(
                title: const Text('Dark Theme'),
                trailing: Switch.adaptive(
                  value: provider.isDarkTheme,
                  onChanged: (value) {
                    provider.enableDarkTheme(value);
                  },
                ),
              ),
            ),
            // Material(
            //   child: ListTile(
            //     title: Text('Scheduling News'),
            //     trailing: Consumer<SchedulingProvider>(
            //       builder: (context, scheduled, _) {
            //         return Switch.adaptive(
            //           value: provider.isDailyNewsActive,
            //           onChanged: (value) async {
            //             if (Platform.isIOS) {
            //               customDialog(context);
            //             } else {
            //               scheduled.scheduledNews(value);
            //               provider.enableDailyNews(value);
            //             }
            //           },
            //         );
            //       },
            //     ),
            //   ),
            // ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
