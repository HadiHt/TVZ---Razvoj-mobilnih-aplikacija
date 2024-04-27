import 'package:flutter/material.dart';

class WorkoutDetailsScreen extends StatelessWidget {

  int imageIndex = 0;

  WorkoutDetailsScreen({required this.imageIndex});

  @override
  Widget build(BuildContext context) {
    List<String> gifAsset = [];
    switch (imageIndex) {
      case 0:
        gifAsset.add('assets/bi1.gif');
        gifAsset.add('assets/bi2.gif');
        gifAsset.add('assets/bi3.gif');
        gifAsset.add('assets/bi4.gif');
        break;
      case 1:
        gifAsset.add('assets/tri1.gif');
        gifAsset.add('assets/tri2.gif');
        gifAsset.add('assets/tri3.gif');
        gifAsset.add('assets/tri4.gif');
        break;
      case 2:
        gifAsset.add('assets/chest1.gif');
        gifAsset.add('assets/chest2.gif');
        gifAsset.add('assets/chest3.gif');
        gifAsset.add('assets/chest4.gif');
        break;
      case 3:
        gifAsset.add('assets/back1.gif');
        gifAsset.add('assets/back2.gif');
        gifAsset.add('assets/back3.gif');
        gifAsset.add('assets/back4.gif');
        break;
      case 4:
        gifAsset.add('assets/shoulder1.gif');
        gifAsset.add('assets/shoulder2.gif');
        gifAsset.add('assets/shoulder3.gif');
        gifAsset.add('assets/shoulder4.gif');
        break;
      default:
        print("ERROR getting index for exercise");
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Exercises'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                ),
                itemCount: gifAsset.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Card(
                      child: Image.asset(
                        gifAsset[index],
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}