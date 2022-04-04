part of 'pages.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  Widget _titleAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Favorite',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }

  Widget _buildList() {
    return Consumer<DatabaseProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Align(
              alignment: Alignment.topCenter,
              child: CircularProgressIndicator());
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
            itemCount: state.favorites.length,
            itemBuilder: (context, index) {
              return ItemRestaurant(restaurant: state.favorites[index]);
            },
          );
        } else {
          return Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ViewError(message: state.message),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: _titleAppBar(context),
      body: _buildList(),
      androidMenu: [
        IconButton(
          onPressed: () =>
              Navigator.pushNamed(context, SettingScreen.routeName),
          icon: const Icon(
            Icons.settings,
            color: black,
          ),
        ),
      ],
      iosMenu: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () =>
                Navigator.pushNamed(context, SettingScreen.routeName),
            child: const Icon(CupertinoIcons.settings),
          ),
        ],
      ),
    );
  }
}
