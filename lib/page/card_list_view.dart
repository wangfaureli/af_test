import 'package:flutter/material.dart';
import 'package:af_test/fixture.dart';
import 'package:af_test/page/page2.dart';

class CardList extends StatelessWidget {
  const CardList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.black,
    body:GestureDetector(
      child: buildGridView(),
      onTap: () => {
      Navigator.push(
      context,
      MaterialPageRoute(
      builder: (context) => const Page2()),)
      },
    ),
  );

  Widget buildGridView() => GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 1,
      childAspectRatio: 1,
      mainAxisSpacing: 3,
      crossAxisSpacing: 8,
      mainAxisExtent: 200,
    ),
    itemCount: itemData.length,
    padding: const EdgeInsets.all(4),
    itemBuilder: (context, index ) {
      final item = itemData.elementAt(index);
      print(item.image);
      return buildNumber(index + 1, item.image, item.title);
    },
  );

  Widget buildNumber(int number, String image, String title ) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover)
    ),
    // color: const Color.fromARGB(0xff, 0xb7, 0x51, 0x1a),
  child: GridTile(
      header: Text(
        "CHAPITRE $number",
        textAlign: TextAlign.center,
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
      footer: Text(
        "$number",
      ),
    ),
  );
}

