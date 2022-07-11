import 'package:crud_final/shared/component.dart';
import 'package:flutter/material.dart';

class AddTaskScreen extends StatelessWidget {

  TextEditingController titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomTextFormField(
                controller: titleController,
                keyboardType: TextInputType.text,
                validator: (String? value) {
                  if (value!.isEmpty){
                    return 'Please add your tittle';
                  }
                },
                label: 'Title',
                hintText: 'Add your Title',
                prefixIcon: Icons.title)
          ],
        ),
      ),
    );
  }
}