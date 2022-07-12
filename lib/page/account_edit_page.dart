import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:family_budget/Extensions/snack_bar_utils.dart';
import 'package:family_budget/Server/Controller/user_controller.dart';
import 'package:family_budget/Server/Response/user_id_response.dart';
import 'package:family_budget/model/controller/user.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AccountEditPage extends StatefulWidget {
  const AccountEditPage({Key? key}) : super(key: key);

  @override
  _AccountEditPageState createState() => _AccountEditPageState();
}

class _AccountEditPageState extends State<AccountEditPage> {
  Uint8List _avatarBlob = Uint8List(0);
  final _accountFormKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile?.path.isNotEmpty ?? false) {
      setState(() {
        _avatarBlob = File(pickedFile!.path).readAsBytesSync();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff5537a1),
        title: const Text('Редактирование профиля'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        alignment: Alignment.topCenter,
        child: Form(
          key: _accountFormKey,
          child: Column(
            children: [
              SizedBox(
                width: 250,
                height: 250,
                child: ClipOval(
                  child: Image.memory(
                    _avatarBlob,
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
                  labelText: "Имя пользователя",
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
                    ? "Имя пользователя не может быть пустым"
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
                  if (_accountFormKey.currentState!.validate()) {
                    UserIdResponse? response = await UserController.update(User.params.user_id!, name: _nameController.text, photo: base64Encode(_avatarBlob), context: context);
                    if (response != null){
                      User.params.name = _nameController.text;
                      User.params.avatar = _avatarBlob;
                      User.params.date_modify = DateTime.now().millisecondsSinceEpoch;
                      await User.params.save();
                      SnackBarUtils.Show(context, 'Изменения профиля сохранены');
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
    _nameController.text = User.params.name!;
    _avatarBlob = User.params.avatar!;
  }

  @override
  void dispose(){
    _nameController.dispose();
    super.dispose();
  }
}
