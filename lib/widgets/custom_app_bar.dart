part of 'widgets.dart';

class CustomAppBar extends StatelessWidget {
  final Widget title;
  final List<Widget>? menu;
  final Widget body;

  const CustomAppBar({
    required this.title,
    this.menu,
    required this.body,
    Key? key,
  }) : super(key: key);

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: SafeArea(
          child: title,
        ),
        actions: menu,
      ),
      body: body,
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          middle: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              title,
            ],
          ),
          transitionBetweenRoutes: false,
          border: const Border(bottom: BorderSide(color: Colors.transparent)),
          backgroundColor: Colors.white,
          trailing: Row(
            children: menu ?? [],
          )),
      child: body,
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
