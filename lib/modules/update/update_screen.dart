import 'package:crud_final/repositories/base_repositories.dart';
import 'package:crud_final/modules/top_level_cubit/states.dart';
import 'package:crud_final/shared/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class UpdateTaskScreen extends StatelessWidget {

  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController descController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late int id;
  UpdateTaskScreen({required this.id});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BaseRepositories, TodoStates>(
      listener: (BuildContext context, state) 
      {
        if(state is SuccessUpdatingDataFromDatabaseState)
        {
          Navigator.pop(context);
        }
      },
      builder: (BuildContext context, Object? state) {
        var cubit = BaseRepositories.get(context);
        return Scaffold(
        appBar: AppBar(
          title: const Text('Update Your Task'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextFormField(
                      controller: titleController,
                      keyboardType: TextInputType.text,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please add your Title';
                        }
                      },
                      label: 'Title',
                      hintText: 'Add your Title',
                      prefixIcon: Icons.title),
                  const SizedBox(
                    height: 10.0,
                  ),
                  CustomTextFormField(
                      controller: timeController,
                      keyboardType: TextInputType.datetime,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please add your Time';
                        }
                      },
                      label: 'Time',
                      hintText: 'Add your Time',
                      prefixIcon: Icons.watch_later_outlined, 
                      onTap: (){
                        showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value){
                          timeController.text = value!.format(context);
                        }).catchError((error){
                          timeController.clear();
                        });
                      }),
                  const SizedBox(
                    height: 10.0,
                  ),
                  CustomTextFormField(
                      controller: dateController,
                      keyboardType: TextInputType.datetime,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please add your Date';
                        }
                      },
                      label: 'Date',
                      hintText: 'Add your Date',
                      prefixIcon: Icons.calendar_month_outlined, 
                      onTap: (){
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.parse('2020-05-10'),
                                lastDate: DateTime.now())
                            .then((value) {
                          dateController.text = DateFormat.yMMMd().format(value!);
                        }).catchError((error)
                        {
                          dateController.clear();
                        });
                      }),
                  const SizedBox(
                    height: 10.0,
                  ),
                  CustomTextFormField(
                      controller: descController,
                      lines: 5,
                      keyboardType: TextInputType.text,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please add your Description';
                        }
                      },
                      label: 'Description',
                      hintText: 'Add your Description',
                      prefixIcon: Icons.wysiwyg),
                  const SizedBox(
                    height: 10.0,
                  ),
                  MaterialButton(
                    height: 40.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                    minWidth: double.infinity,
                    color: Colors.deepOrange,
                    onPressed: () {
                        if(_formKey.currentState!.validate())
                        {
                          cubit.updateDataIntoDatabase(
                            title: titleController.text,
                            date: dateController.text,
                            time: timeController.text,
                            description: descController.text, id: id);
                        }
                      },
                      child: const Text('Update Task'),
                    )
                  ],
                ),
            ),
          ),
        ),
      );
      },
    );
  }
}