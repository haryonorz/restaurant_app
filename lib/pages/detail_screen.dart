part of 'pages.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const DetailScreen({
    required this.restaurant,
    Key? key,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool foodExpanded = false;
  bool drinkExpanded = false;

  Widget _buildAppBar({List<Widget>? actions}) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 200,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      iconTheme: IconThemeData(
        color: Theme.of(context).primaryColor,
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: widget.restaurant.pictureId,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16.0),
              bottomRight: Radius.circular(16.0),
            ),
            child: Image.network(
              ApiService().urlImage + widget.restaurant.pictureId,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
          ),
        ),
      ),
      actions: actions,
    );
  }

  Widget _buildBody(Restaurant restaurant) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurant.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            const WidgetSpan(
                              child: Icon(
                                Icons.location_on,
                                size: 16,
                                color: blue,
                              ),
                            ),
                            TextSpan(
                              text:
                                  ' ${restaurant.address}, ${restaurant.city}',
                            )
                          ],
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        children: [
                          const WidgetSpan(
                            child: Icon(
                              Icons.star,
                              size: 18,
                              color: yellow,
                            ),
                          ),
                          TextSpan(
                            text: ' ${restaurant.rating.toStringAsFixed(2)}',
                          )
                        ],
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(color: yellow),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          restaurant.categories != null
              ? _buildListCategories(restaurant.categories!)
              : Container(),
          const SizedBox(
            height: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              restaurant.description,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          const SizedBox(
            height: 32.0,
          ),
          if (restaurant.reviews != null)
            _buildListMenu(restaurant.menu!)
          else
            Container(),
          const SizedBox(
            height: 32.0,
          ),
          if (restaurant.reviews != null)
            _buildListReview(restaurant.reviews!)
          else
            Container(),
          const SizedBox(
            height: 24,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return DialogAddReview(
                        id: widget.restaurant.id,
                      );
                    });
              },
              child: Text(
                'Add Review',
                style: Theme.of(context)
                    .textTheme
                    .button
                    ?.copyWith(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }

  Widget _buildListCategories(List<Categories> categories) {
    return SizedBox(
      height: 25,
      child: ListView.builder(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: index == 0 ? 16.0 : 8.0),
            child: ItemCategories(name: categories[index].name),
          );
        },
      ),
    );
  }

  Widget _buildListMenu(Menu menu) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Menu',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        ExpansionPanelList(
          expandedHeaderPadding: const EdgeInsets.symmetric(
            vertical: 0.0,
          ),
          elevation: 0.0,
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              if (index == 0) {
                foodExpanded = !isExpanded;
              } else {
                drinkExpanded = !isExpanded;
              }
            });
          },
          children: [
            ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: Text(
                    'Foods',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                );
              },
              body: menu.foods.isNotEmpty
                  ? Column(
                      children: menu.foods
                          .map((e) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: ItemMenu(
                                  name: e.name,
                                ),
                              ))
                          .toList(),
                    )
                  : Text(
                      'No food',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
              isExpanded: foodExpanded,
            ),
            ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: Text(
                    'Drinks',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                );
              },
              body: menu.foods.isNotEmpty
                  ? Column(
                      children: menu.drinks
                          .map((e) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: ItemMenu(
                                  name: e.name,
                                ),
                              ))
                          .toList(),
                    )
                  : Text(
                      'No drink',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
              isExpanded: drinkExpanded,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildListReview(List<Review> reviews) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Reviews',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        if (reviews.isNotEmpty)
          SizedBox(
            height: 110,
            child: ListView.builder(
              itemCount: reviews.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: ItemReview(review: reviews[index]),
              ),
            ),
          )
        else
          const ViewEmpty(message: "No review"),
      ],
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            _buildAppBar(),
          ];
        },
        body: Consumer<DetailRestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.hasData) {
              return _buildBody(state.result.restaurants);
            } else if (state.state == ResultState.noData) {
              return Center(
                child: Text(
                  state.message,
                  style: Theme.of(context)
                      .textTheme
                      .overline
                      ?.copyWith(color: grey),
                ),
              );
            } else if (state.state == ResultState.error) {
              return Center(
                child: Text(
                  state.message,
                  style: Theme.of(context)
                      .textTheme
                      .overline
                      ?.copyWith(color: grey),
                ),
              );
            } else {
              return const Center(child: Text(''));
            }
          },
        ),
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          _buildAppBar(
            actions: [
              Consumer<DatabaseProvider>(
                builder: (context, provider, child) {
                  return FutureBuilder<bool>(
                    future: provider.isFavorite(widget.restaurant.id),
                    builder: (context, snapshot) {
                      var isBookmarked = snapshot.data ?? false;
                      return isBookmarked
                          ? CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () =>
                                  provider.removeFavorite(widget.restaurant.id),
                              child: const Icon(CupertinoIcons.heart_fill),
                            )
                          : CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () =>
                                  provider.addFavorite(widget.restaurant),
                              child: const Icon(CupertinoIcons.heart),
                            );
                    },
                  );
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Consumer<DetailRestaurantProvider>(
              builder: (context, state, _) {
                if (state.state == ResultState.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.state == ResultState.hasData) {
                  return Center(
                    child: _buildBody(state.result.restaurants),
                  );
                } else if (state.state == ResultState.noData) {
                  return Center(
                    child: ViewEmpty(message: state.message),
                  );
                } else if (state.state == ResultState.error) {
                  return Center(
                    child: ViewError(message: state.message),
                  );
                } else {
                  return const Center(child: Text(''));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailRestaurantProvider>(
      create: (_) => DetailRestaurantProvider(
          apiService: ApiService(), id: widget.restaurant.id),
      child: PlatformWidget(
        androidBuilder: _buildAndroid,
        iosBuilder: _buildIos,
      ),
    );
  }
}
