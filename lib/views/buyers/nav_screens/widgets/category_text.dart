import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryText extends StatelessWidget {
  final List<String> _categoryLabel = ["food", "vegetable", "egg", "tea", "test1", "test2", "test3", "test4"];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Categories",
            style: TextStyle(
              fontSize: 19,
            ),
          ),
          Container(
            height: 40,
            child: Row(
              children: [
                Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categoryLabel.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ActionChip(
                              backgroundColor: Colors.yellow.shade900,
                                onPressed: (){},
                                label: Center(
                                  child: Text(
                              _categoryLabel[index],
                              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                                )),
                          );
                        })),
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.arrow_forward_ios)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
