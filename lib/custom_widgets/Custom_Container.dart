

import 'package:flutter/material.dart';
import 'package:sds_assistor/Tabs/Checklistpage/Body.dart';



class CustomContainer extends StatefulWidget {
  final String category;
  final String actionItem;
  final String priority;
  final int index;


  const CustomContainer({
    super.key,
    required this.category,
    required this.actionItem,
    required this.priority,
    required this.index,

  });

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
   @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    '${widget.index+1}. '+widget.category,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Text(
                    widget.priority,
                    style: TextStyle(
                      color: widget.priority == 'high'
                          ? Colors.red
                          : widget.priority == 'medium'
                          ? Colors.orange
                          : Colors.green,
                    ),
                  )
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.actionItem),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Check the box once the above action has been completed',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Checkbox(
                    value: validation_map.value[widget.index],
                    onChanged: (value) {
                      setState(() {
                        validation_map.value[widget.index] = !validation_map.value[widget.index]!;


                      });
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
