import 'package:flutter/material.dart';

//
// class DropDown extends StatefulWidget {
//   const DropDown({super.key, required this.selectedItem, required this.onChanges, required this.items});
//
//   final selectedItem;
//
//   final onChanges;
//   final List items;
//
//   @override
//   State<DropDown> createState() => _DropDownState();
// }
//
// class _DropDownState extends State<DropDown> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       margin: const EdgeInsets.only(bottom: 10.0),
//       width: MediaQuery.of(context).size.width,
//       decoration: BoxDecoration(
//           border: Border.all(
//             color: Colors.black12,
//           ),
//           borderRadius: const BorderRadius.all(Radius.circular(9))),
//       child: DropdownButtonFormField(
//         //  isDense: false,
//         isExpanded: true,
//         menuMaxHeight: 300,
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         decoration: const InputDecoration.collapsed(hintText: ''),
//         style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600),
//         value: widget.selectedItem,
//         onChanged: widget.onChanges,
//         items: widget.items! //<String>['Dog', 'Cat', 'Tiger', 'Lion']
//             .map<DropdownMenuItem>((value) {
//           return DropdownMenuItem(
//             value: value['name'],
//             child: Row(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(100.0),
//                   child: value['base64Image'] == null
//                       ? Image.network(
//                           "https://static.everypixel.com/ep-pixabay/0329/8099/0858/84037/3298099085884037069-head.png",
//                           height: 25,
//                           width: 25,
//                           fit: BoxFit.cover,
//                         )
//                       : Image.memory(
//                           base64Decode(value['base64Image'].toString()),
//                           height: 25,
//                           width: 25,
//                           fit: BoxFit.cover,
//                           errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
//                             return Image.asset(
//                               "assets/images/user.png",
//                               fit: BoxFit.cover,
//                               height: 40.0,
//                               width: 40.0,
//                             );
//                           },
//                         ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: Text(
//                     value['name']!,
//                     style: const TextStyle(fontSize: 14.0),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
// Multi-select dialog widget
class MultiSelectDialog extends StatefulWidget {
  final List<Map<String, dynamic>> items;
  final List<Map<String,dynamic>> selectedItems;

  const MultiSelectDialog({super.key, required this.items, required this.selectedItems});

  @override
  _MultiSelectDialogState createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<MultiSelectDialog> {
  // Temporary list to hold the selections inside the dialog
  List<Map<String,dynamic>> _tempSelectedItems = [];

  @override
  void initState() {
    super.initState();
    _tempSelectedItems = List.from(widget.selectedItems); // Copy initial selections
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Ingredient'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items.map((item) {
            return CheckboxListTile(
              title: Text(item['name']),
              value: _tempSelectedItems.contains(item),
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    _tempSelectedItems.add(item);
                  } else {
                    _tempSelectedItems.remove(item);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop(_tempSelectedItems); // Return selected items
          },
        ),
      ],
    );
  }
}
