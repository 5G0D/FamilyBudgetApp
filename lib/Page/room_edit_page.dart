import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:family_budget/Extansions/snack_bar_utils.dart';
import 'package:family_budget/Server/Controller/room_controller.dart';
import 'package:family_budget/room.dart';
import 'package:family_budget/user.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:family_budget/model/model.dart';

class RoomEditPage extends StatefulWidget {
  const RoomEditPage({Key? key}) : super(key: key);

  @override
  _RoomEditPageState createState() => _RoomEditPageState();
}

class _RoomEditPageState extends State<RoomEditPage> {
  Uint8List _roomImageBlob = Uint8List(0);
  final _roomFormKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile?.path.isNotEmpty ?? false) {
      setState(() {
        _roomImageBlob = File(pickedFile!.path).readAsBytesSync();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff5537a1),
        title: const Text('Редактирование комнаты'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        alignment: Alignment.topCenter,
        child: Form(
          key: _roomFormKey,
          child: Column(
            children: [
              SizedBox(
                width: 250,
                height: 250,
                child: ClipOval(
                  child: Image.memory(
                    _roomImageBlob,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _getFromGallery();
                },
                child: const Text('Выбрать изображение'),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _nameController,
                style: const TextStyle(fontSize: 18),
                decoration: const InputDecoration(
                  labelText: "Название комнаты",
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff5537a1)),
                  ),
                ),
                validator: (value) => (value?.isEmpty ?? true)
                    ? "Название комнаты не может быть пустым"
                    : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(
                    const Size(200, 40),
                  ),
                ),
                onPressed: () async {
                  if (_roomFormKey.currentState!.validate()) {
                    if (await RoomController.update(
                      Room.params.room_id!,
                      _nameController.text,
                      base64Encode(_roomImageBlob),
                      context: context,
                    )) {
                      Room.params.name = _nameController.text;
                      Room.params.avatar = _roomImageBlob;
                      Room.params.date_modify =
                          DateTime.now().millisecondsSinceEpoch;
                      await Room.params.save();

                      SnackBarUtils.Show(
                          context, 'Изменения комнаты сохранены');
                    }
                  }
                },
                child: const Text('Сохранить'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = Room.params.name!;
    _roomImageBlob = Room.params.avatar!;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
