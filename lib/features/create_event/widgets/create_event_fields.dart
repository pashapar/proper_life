// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';

// class CreateEventFields extends StatefulWidget {
//   const CreateEventFields({
//     super.key,
//   });

//   @override
//   State<CreateEventFields> createState() => _CreateEventFieldsState();
// }

// class _CreateEventFieldsState extends State<CreateEventFields> {
//   final _fbKey = GlobalKey<FormBuilderState>();

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return ListView.builder(itemCount: 1, itemBuilder: (context, i) {
//       return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 12),
//       child: FormBuilder(
//         key: _fbKey,
//         child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           FormBuilderTextField(name: 'eventName',
//           decoration: const InputDecoration(
//                     labelText: 'Write the event name...'),),
//           const SizedBox(
//             height: 10,
//           ),
//           FormBuilderTextField(name: 'eventCity',
//           decoration: const InputDecoration(
//                     labelText: 'Write the event city...'),),
//           const SizedBox(
//             height: 10,
//           ),
//           FormBuilderTextField(name: 'location',
//           decoration: const InputDecoration(
//                     labelText: 'Write the event location...'),),
//           const SizedBox(
//             height: 10,
//           ),
//           FormBuilderTextField(name: 'date&time',
//           decoration: const InputDecoration(
//                     labelText: 'Chose day and time when event start'),),
//           const SizedBox(
//             height: 10,
//           ),
//           FormBuilderTextField(name: 'description',
//           maxLines: 7,
//           decoration: const InputDecoration(
//                     labelText: 'Write the event description...'),),
//           const SizedBox(
//             height: 10,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Text(
//                 'Add content',
//                 style: theme.textTheme.bodyLarge,
//               ),
//               const Icon(
//                 Icons.attach_file_rounded,
//                 size: 30,
//                 color: Color(0x99000000),
//               )
//             ],
//           ),
//           Center(
//             child: Text(
//               'Your Event Card',
//               style: theme.textTheme.bodyMedium,
//             ),
//           ),
//         ],
//       ),)
//     );
//     });
//   }
// }
