part of 'widgets.dart';

class ItemReview extends StatelessWidget {
  final Review review;

  const ItemReview({
    required this.review,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(23.0),
              child: Image.asset(
                "images/default_photo.png",
                height: 46,
              ),
            ),
            const SizedBox(width: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  review.name,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(color: black),
                ),
                Text(
                  review.date,
                  style: Theme.of(context)
                      .textTheme
                      .overline
                      ?.copyWith(color: grey),
                ),
                const SizedBox(height: 12.0),
                Text(
                  review.review,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(color: black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
