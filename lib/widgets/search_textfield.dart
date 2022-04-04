part of 'widgets.dart';

class SearchTextField extends StatefulWidget {
  final bool readOnly;
  final bool autoFocus;
  final Function()? onTap;
  final Function(String)? onChanged;

  const SearchTextField({
    required this.readOnly,
    required this.autoFocus,
    this.onTap,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final String hint = "Type here..";

  Widget _buildAndroid(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: lightGrey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        readOnly: widget.readOnly,
        autofocus: widget.autoFocus,
        onTap: widget.onTap,
        onChanged: widget.onChanged,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(color: grey),
          prefixIcon: const Icon(
            Icons.search,
            color: grey,
          ),
        ),
        style: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoTextField(
      readOnly: widget.readOnly,
      autofocus: widget.autoFocus,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      textAlignVertical: TextAlignVertical.center,
      placeholder: hint,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: lightGrey,
      ),
      prefix: const Padding(
        padding: EdgeInsets.only(left: 16.0),
        child: Icon(
          CupertinoIcons.search,
          color: grey,
        ),
      ),
      placeholderStyle: const TextStyle(color: grey),
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
