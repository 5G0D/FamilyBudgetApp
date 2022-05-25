import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:family_budget/Dialogs/account_exit_dialog.dart';
import 'package:family_budget/Dialogs/room_exit_dialog.dart';
import 'package:family_budget/Extansions/snack_bar_utils.dart';
import 'package:family_budget/Server/Controller/room_controller.dart';
import 'package:family_budget/Server/Response/room_response.dart';
import 'package:family_budget/model/model.dart';
import 'package:family_budget/room.dart';
import 'package:family_budget/user.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RoomCreatePage extends StatefulWidget {
  const RoomCreatePage({Key? key}) : super(key: key);

  @override
  _RoomCreatePageState createState() => _RoomCreatePageState();
}

class _RoomCreatePageState extends State<RoomCreatePage> {
  Uint8List _roomImageBlob = base64Decode('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');
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
        title: const Text('Создание комнаты'),
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
                    //Выход
                    if (User.params.roomId != null && (await roomExitDialog(context)) == 'YES'){
                      if (!await Room.roomExit(context: context)){
                        return;
                      }
                    }
                    //Вход
                    RoomResponse? response = await RoomController.create(_nameController.text, base64Encode(_roomImageBlob), context: context);
                    if (response != null){
                      await Room.roomEnter(response);
                      SnackBarUtils.Show(context, "Комната успешно создана");
                      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                    }
                  }
                },
                child: const Text('Создать'),
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
  }

  @override
  void dispose(){
    _nameController.dispose();
    super.dispose();
  }
}