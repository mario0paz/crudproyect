import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models.dart';
import 'service_crude.dart';

class TaskFormModal extends StatefulWidget {
  final Task? task;

  const TaskFormModal({Key? key, this.task}) : super(key: key);

  @override
  _TaskFormModalState createState() => _TaskFormModalState();
}

class _TaskFormModalState extends State<TaskFormModal> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _desc;
  late DateTime _date;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      isEditing = true;
      _name = widget.task!.name;
      _desc = widget.task!.desc;
      _date = widget.task!.date;
    } else {
      _name = '';
      _desc = '';
      _date = DateTime.now();
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (isEditing) {
        updateTask(widget.task!.id, _name, _desc, _date);
      } else {
        createTask(_name, _desc, _date);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: _name,
                decoration:
                    const InputDecoration(labelText: 'Nombre de la tarea'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El nombre no puede estar vacio';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                initialValue: _desc,
                decoration: const InputDecoration(labelText: 'Descripcion'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo no puede estar vacio';
                  }
                  return null;
                },
                onSaved: (value) {
                  _desc = value!;
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(isEditing ? 'Actualizar' : 'Crear'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
