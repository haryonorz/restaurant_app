part of 'pages.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';

  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var keyword = "";

  Widget _buildSearchTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Consumer<SearchRestaurantsProvider>(
        builder: (context, state, _) {
          return Hero(
            tag: SearchScreen.routeName,
            child: SearchTextField(
              readOnly: false,
              autoFocus: true,
              onChanged: (text) {
                if (text.isNotEmpty) {
                  setState(() {
                    state.searchRestaurants(text);
                  });
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Consumer<SearchRestaurantsProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.hasData) {
            return ListView.builder(
              itemCount: state.result.restaurants.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: index == 0 ? 12.0 : 0.0),
                  child: ItemRestaurant(
                      restaurant: state.result.restaurants[index]),
                );
              },
            );
          } else if (state.state == ResultState.noData) {
            return Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ViewEmpty(message: state.message),
            );
          } else if (state.state == ResultState.error) {
            return Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ViewError(message: state.message),
            );
          } else {
            return const Center(child: Text(''));
          }
        },
      ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: black,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Search",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchTextField(),
            Expanded(
              child: _buildList(),
            ),
          ],
        ),
      ),
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
            Text(
              "Search",
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 8.0),
            _buildSearchTextField(),
            Expanded(
              child: _buildList(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchRestaurantsProvider>(
      create: (_) => SearchRestaurantsProvider(apiService: ApiService()),
      child: PlatformWidget(
        androidBuilder: _buildAndroid,
        iosBuilder: _buildIos,
      ),
    );
  }
}
