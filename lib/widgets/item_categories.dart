part of 'widgets.dart';

class ItemCategories extends StatelessWidget {
  final String name;

  const ItemCategories({
    required this.name,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: grey),
      ),
      child: Center(
        child: Text(
          name,
          style: Theme.of(context).textTheme.caption?.copyWith(color: grey),
        ),
      ),
    );
  }
}
