part of 'widgets.dart';

class ViewEmpty extends StatelessWidget {
  final String message;

  const ViewEmpty({
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
