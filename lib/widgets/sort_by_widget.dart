import 'package:flutter/material.dart';

class SortBy extends StatelessWidget {
  const SortBy({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20,),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Icon(Icons.arrow_drop_down),
              Text("Sort by", style: TextStyle(fontWeight: FontWeight.bold),),
            ],
          ),
        ),
        Container(
          color: Colors.black,
          height: 1,
          width: 310,
        ),
      ],
    );
  }
}
