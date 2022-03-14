part of 'widgets.dart';

class ViewError extends StatelessWidget {
  final String message;

  const ViewError({
    required this.message,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: Theme.of(context).textTheme.overline?.copyWith(color: grey),
    );
  }
}
