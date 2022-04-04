part of 'widgets.dart';

class CustomAppBar extends StatelessWidget {
  final Widget title;
  final List<Widget>? androidMenu;
  final Widget? iosMenu;
  final Widget body;

  const CustomAppBar({
    required this.title,
    this.androidMenu,
    this.iosMenu,
    required this.body,
    Key? key,
  }) : super(key: key);

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: SafeArea(
          child: title,
        ),
        actions: androidMenu,
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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        trailing: iosMenu,
      ),
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
