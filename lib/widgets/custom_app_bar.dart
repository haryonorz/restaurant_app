part of 'widgets.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: SafeArea(
          child: _customAppBar(context),
        ),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, SearchScreen.routeName),
            icon: const Icon(
              Icons.search,
              color: black,
            ),
          ),
        ],
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [_customAppBar(context)],
        ),
        transitionBetweenRoutes: false,
        border: const Border(bottom: BorderSide(color: Colors.transparent)),
        backgroundColor: Colors.white,
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pushNamed(context, SearchScreen.routeName),
          child: const Icon(CupertinoIcons.search),
        ),
      ),
      child: _buildList(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantsProvider>(
      create: (_) => RestaurantsProvider(apiService: ApiService()),
      child: PlatformWidget(
        androidBuilder: _buildAndroid,
        iosBuilder: _buildIos,
      ),
    );
  }
}
