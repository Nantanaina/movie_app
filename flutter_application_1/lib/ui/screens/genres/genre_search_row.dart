import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/ui/theme/theme.dart';

typedef OnSearch = void Function(String searchString);

class GenreSearchRow extends ConsumerStatefulWidget {
  final String searchText;
  final OnSearch onSearch;
  const GenreSearchRow(this.searchText, this.onSearch, {super.key});

  @override
  ConsumerState<GenreSearchRow> createState() => _GenreSearchRowState();
}

class _GenreSearchRowState extends ConsumerState<GenreSearchRow> {
  late TextEditingController movieTextController =
      TextEditingController(text: widget.searchText);
  final FocusNode textFocusNode = FocusNode();

  @override
  void dispose() {
    movieTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    movieTextController.text = widget.searchText;
    return Row(mainAxisSize: MainAxisSize.max, children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: TextField(
            style: const TextStyle(color: Colors.white),
            focusNode: textFocusNode,
            keyboardType: TextInputType.text,
            enableSuggestions: false,
            autofocus: false,
            // 1
            onSubmitted: (value) {
              widget.onSearch(value);
            },
            // 2
            controller: movieTextController,
            autocorrect: false,
            // 3
            decoration: InputDecoration(
              filled: true,
              focusColor: searchBarBackground,
              focusedBorder: null,
              enabledBorder: null,
              fillColor: searchBarBackground,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              hintText: 'movie name, genre',
              hintStyle: body1Regular.copyWith(color: posterBorder),
              // 4
              suffixIcon: IconButton(
                onPressed: () {
                  movieTextController.clear();
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ), // Close icon
              ),
              // 5
              prefixIcon: IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  widget.onSearch(movieTextController.text);
                },
              ),
            ),
          ),
        ),
      )
    ]);
  }
}