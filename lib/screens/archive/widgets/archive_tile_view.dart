import 'package:flutter/material.dart';

class ArchiveTileView extends StatelessWidget {
  final Function(String) onTap;
  const ArchiveTileView({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          onTap("item");
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          height: 150,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(),
          ),
        ),
      ),
    );
  }
}
