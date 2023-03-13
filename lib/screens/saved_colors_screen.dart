// import 'package:color_design_app/screens/color_picker_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../application/color_design_bloc.dart';
// import '../utils/styles.dart';
//
// class SavedColorsScreen extends StatelessWidget {
//   const SavedColorsScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     BlocProvider.of<ColorDesignBloc>(context).add(OnPressedSave());
//     return BlocBuilder<ColorDesignBloc, ColorDesignState>(
//       builder: (context, state) {
//         return WillPopScope(
//           onWillPop: () async {
//             return await Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const ColorPickerScreen(),
//               ),
//             );
//           },
//           child: Scaffold(
//             backgroundColor: Colors.grey.shade100,
//             appBar: AppBar(
//               backgroundColor: Colors.grey.shade100,
//               elevation: 0.0,
//               title: const Text('Library', style: Styles.headingStyle),
//               actions: [
//                 Padding(
//                   padding: const EdgeInsets.only(right: 20),
//                   child: Container(
//                     height: 30,
//                     width: 40,
//                     decoration: Styles.addButtonDecoration,
//                     child: IconButton(
//                       onPressed: () {
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const ColorPickerScreen(),
//                           ),
//                         );
//                       },
//                       icon: const Icon(Icons.add),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             body: ListView.builder(
//               itemCount: state.colorDesignModel.length,
//               itemBuilder: (context, index) {
//                 final colorData = state.colorDesignModel[index];
//
//                 final Color rgbaColor = Color.fromRGBO(
//                   colorData.red.toInt(),
//                   colorData.green.toInt(),
//                   colorData.blue.toInt(),
//                   colorData.opacity,
//                 );
//
//                 return Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 7),
//                       child: SizedBox(
//                         height: 100,
//                         child: Card(
//                           color: Colors.grey.shade300,
//                           elevation: 10.0,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           margin: const EdgeInsets.only(left: 20, right: 20, top: 8),
//                           child: Padding(
//                             padding: const EdgeInsets.only(bottom: 8, left: 3, right: 3),
//                             child: ListTile(
//                               leading: Padding(
//                                 padding: const EdgeInsets.only(top: 7),
//                                 child: SizedBox(
//                                   width: 45,
//                                   height: 45,
//                                   child: CircleAvatar(backgroundColor: rgbaColor),
//                                 ),
//                               ),
//                               title: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     colorData.colorName,
//                                     style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade800),
//                                   ),
//                                   const SizedBox(height: 2.0),
//                                   Text(
//                                     colorData.colorNotes,
//                                     style: const TextStyle(fontSize: 13, color: Colors.black54),
//                                   ),
//                                   const SizedBox(height: 5.0),
//                                   Text(
//                                     '0x${rgbaColor.value.toRadixString(16).toUpperCase()}',
//                                     style: const TextStyle(fontSize: 10.0, color: Colors.grey),
//                                   ),
//                                 ],
//                               ),
//                               trailing: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text('R: ${colorData.red.toInt()}', style: Styles.colorStyle),
//                                   Text('G: ${colorData.green.toInt()}', style: Styles.colorStyle),
//                                   Text('B: ${colorData.blue.toInt()}', style: Styles.colorStyle),
//                                   Text('A: ${colorData.opacity.toStringAsFixed(1)}', style: Styles.colorStyle),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:color_design_app/application/color_picker_bloc/color_design_bloc.dart';
import 'package:color_design_app/application/saved_color_bloc/saved_color_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/styles.dart';

class SavedColorsScreen extends StatelessWidget {
  const SavedColorsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SavedColorBloc(),
      child: BlocBuilder<SavedColorBloc, SavedColorState>(
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async {
              Navigator.pop(context);
              return false;
            },
            child: Scaffold(
              backgroundColor: Colors.grey.shade100,
              appBar: AppBar(
                backgroundColor: Colors.grey.shade100,
                elevation: 0.0,
                iconTheme: const IconThemeData(color: Colors.black),
                centerTitle: true,
                title: const Text('Library', style: Styles.headingStyle),
              ),
              body: ListView.builder(
                itemCount: state.colorDesignModel.length,
                itemBuilder: (context, index) {
                  final colorData = state.colorDesignModel[index];

                  final Color rgbaColor = Color.fromRGBO(
                    colorData.red.toInt(),
                    colorData.green.toInt(),
                    colorData.blue.toInt(),
                    colorData.opacity,
                  );
                  return Dismissible(
                    // key: ValueKey(colorData),
                    key: const Key('colors'),

                    onDismissed: (direction) {
                      context.read<ColorDesignBloc>().add(OnRemoveColor(index: index));
                      // context.read<SavedColorBloc>().add(OnColorDeleted(index: index));
                      // // Remove the item from the data source.
                      // setState(() {
                      //   List<ColorDesignModel>.from(state.colorDesignModel).removeAt(index);
                      // });
                      //
                      // // Then show a snackbar.
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Center(child: Text('${colorData.colorName} Color is Deleted from Color\'s Library')),
                        backgroundColor: Colors.red,
                      ));
                    },
                    // Show a red background as the item is swiped away.
                    background: Container(color: Colors.red),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 7),
                          child: SizedBox(
                            height: 100,
                            child: Card(
                              color: Colors.grey.shade300,
                              elevation: 10.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              margin: const EdgeInsets.only(left: 20, right: 20, top: 8),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8, left: 3, right: 3),
                                child: ListTile(
                                  leading: Padding(
                                    padding: const EdgeInsets.only(top: 7),
                                    child: SizedBox(
                                      width: 45,
                                      height: 45,
                                      child: CircleAvatar(backgroundColor: rgbaColor),
                                    ),
                                  ),
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        colorData.colorName,
                                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade800),
                                      ),
                                      const SizedBox(height: 2.0),
                                      Text(
                                        colorData.colorNotes,
                                        style: const TextStyle(fontSize: 13, color: Colors.black54),
                                      ),
                                      const SizedBox(height: 5.0),
                                      Text(
                                        '0x${rgbaColor.value.toRadixString(16).toUpperCase()}',
                                        style: const TextStyle(fontSize: 10.0, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  trailing: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('R: ${colorData.red.toInt()}', style: Styles.colorStyle),
                                      Text('G: ${colorData.green.toInt()}', style: Styles.colorStyle),
                                      Text('B: ${colorData.blue.toInt()}', style: Styles.colorStyle),
                                      Text('A: ${colorData.opacity.toStringAsFixed(1)}', style: Styles.colorStyle),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

// import 'package:color_design_app/application/color_picker_bloc/color_design_bloc.dart';
// import 'package:color_design_app/application/saved_color_bloc/saved_color_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../utils/styles.dart';
//
// class SavedColorsScreen extends StatefulWidget {
//   const SavedColorsScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SavedColorsScreen> createState() => _SavedColorsScreenState();
// }
//
// class _SavedColorsScreenState extends State<SavedColorsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => SavedColorBloc(),
//       child: BlocBuilder<SavedColorBloc, SavedColorState>(
//         builder: (context, state) {
//           return WillPopScope(
//             onWillPop: () async {
//               Navigator.pop(context);
//               return false;
//             },
//             child: Scaffold(
//               backgroundColor: Colors.grey.shade100,
//               appBar: AppBar(
//                 backgroundColor: Colors.grey.shade100,
//                 elevation: 0.0,
//                 iconTheme: const IconThemeData(color: Colors.black),
//                 centerTitle: true,
//                 title: const Text('Library', style: Styles.headingStyle),
//               ),
//               body: ListView.builder(
//                 itemCount: state.colorDesignModel.length,
//                 itemBuilder: (context, index) {
//                   final colorData = state.colorDesignModel[index];
//
//                   final Color rgbaColor = Color.fromRGBO(
//                     colorData.red.toInt(),
//                     colorData.green.toInt(),
//                     colorData.blue.toInt(),
//                     colorData.opacity,
//                   );
//                   return Dismissible(
//                     key: ValueKey(colorData),
//                     // key: const Key('colors'),
//                     onDismissed: (direction) {
//                       context.read<ColorDesignBloc>().add(OnRemoveColor(index: index));
//                       // // Remove the item from the data source.
//                       // setState(() {
//                       //   List<ColorDesignModel>.from(state.colorDesignModel).removeAt(index);
//                       // });
//                       //
//                       // // Then show a snackbar.
//                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                         content: Center(child: Text('${colorData.colorName} Color is Deleted from Color\'s Library')),
//                         backgroundColor: Colors.red,
//                       ));
//                     },
//                     // Show a red background as the item is swiped away.
//                     background: Container(color: Colors.red),
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 7),
//                           child: SizedBox(
//                             height: 100,
//                             child: Card(
//                               color: Colors.grey.shade300,
//                               elevation: 10.0,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                               ),
//                               margin: const EdgeInsets.only(left: 20, right: 20, top: 8),
//                               child: Padding(
//                                 padding: const EdgeInsets.only(bottom: 8, left: 3, right: 3),
//                                 child: ListTile(
//                                   leading: Padding(
//                                     padding: const EdgeInsets.only(top: 7),
//                                     child: SizedBox(
//                                       width: 45,
//                                       height: 45,
//                                       child: CircleAvatar(backgroundColor: rgbaColor),
//                                     ),
//                                   ),
//                                   title: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         colorData.colorName,
//                                         style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade800),
//                                       ),
//                                       const SizedBox(height: 2.0),
//                                       Text(
//                                         colorData.colorNotes,
//                                         style: const TextStyle(fontSize: 13, color: Colors.black54),
//                                       ),
//                                       const SizedBox(height: 5.0),
//                                       Text(
//                                         '0x${rgbaColor.value.toRadixString(16).toUpperCase()}',
//                                         style: const TextStyle(fontSize: 10.0, color: Colors.grey),
//                                       ),
//                                     ],
//                                   ),
//                                   trailing: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text('R: ${colorData.red.toInt()}', style: Styles.colorStyle),
//                                       Text('G: ${colorData.green.toInt()}', style: Styles.colorStyle),
//                                       Text('B: ${colorData.blue.toInt()}', style: Styles.colorStyle),
//                                       Text('A: ${colorData.opacity.toStringAsFixed(1)}', style: Styles.colorStyle),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
