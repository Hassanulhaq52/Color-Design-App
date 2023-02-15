import 'package:color_design_app/screens/color_picker_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../application/color_design_bloc.dart';
import '../constants/constants.dart';

class SavedColorsScreen extends StatelessWidget {
  const SavedColorsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorDesignBloc, ColorDesignState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey.shade400,
          appBar: AppBar(
            backgroundColor: Colors.grey.shade400,
            elevation: 0.0,
            bottomOpacity: 0.0,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Container(
                  height: 30,
                  width: 40,
                  decoration: Constants.addButtonDecoration,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ColorPickerScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.add,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: state.colorDesignModel.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 70),
                    child: SizedBox(
                      height: 120,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 8),
                        child: ListTile(
                          leading: SizedBox(
                            width: 45,
                            height: 45,
                            child: CircleAvatar(
                              backgroundColor: Color.fromRGBO(
                                state.slider1Value.toInt(),
                                state.slider2Value.toInt(),
                                state.slider3Value.toInt(),
                                state.slider4Value,
                              ),
                            ),
                          ),

                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${state.colorName}',
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                              Text(
                                '${state.colorNotes}',
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.grey),
                              ),
                              // Text(
                              //   '${snapshot.data![index].date} at ${snapshot.data![index].time}',
                              //   style: const TextStyle(
                              //       fontSize: 8.0, color: Colors.grey),
                              // ),
                            ],
                          ),

                          // subtitle: Text(account.description),
                          trailing: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'R: ${state.slider1Value.toInt()}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'G: ${state.slider2Value.toInt()}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'B: ${state.slider3Value.toInt()}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'A: ${state.slider4Value.toInt()}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
