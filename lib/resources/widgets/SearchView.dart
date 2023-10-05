import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  final Function(String)? onSearchChanged;

  const SearchView({super.key, this.onSearchChanged});

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Search',
            ),
            onChanged: (value) {
              if (widget.onSearchChanged != null) {
                widget.onSearchChanged!(value);
              }
            },
          ),
        ),
        const SizedBox(width: 8),
        StyledButton(
          onPressed: () async {
            if (widget.onSearchChanged != null) {
              widget.onSearchChanged!(_controller.text);
            }
          },
          child: const Row(
            children: [
              Icon(Icons.search),
              SizedBox(width: 4),
              Text('SEARCH'),
            ],
          ),
        ),
      ],
    );
  }
}

class StyledButton extends StatelessWidget {
  const StyledButton({required this.child, required this.onPressed, super.key});
  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: Theme.of(context).primaryColor,
          side: const BorderSide(),
        ),
        onPressed: onPressed,
        child: child,
      );
}