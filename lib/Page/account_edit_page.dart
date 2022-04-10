import 'dart:io';
import 'dart:typed_data';

import 'package:family_budget/user.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:family_budget/model/model.dart';

class AccountEditPage extends StatefulWidget {
  const AccountEditPage({Key? key}) : super(key: key);

  @override
  _AccountEditPageState createState() => _AccountEditPageState();
}

class _AccountEditPageState extends State<AccountEditPage> {
  Uint8List? _avatarBlob;
  final _accountFormKey = GlobalKey<FormState>();

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
        child: FutureBuilder(
          future: UserParam().getById(User.userID),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              UserParam _userParam = snapshot.data ?? UserParam();

              Widget _avatar = const SizedBox.shrink();
              if (_avatarBlob?.isEmpty ?? true) {
                _avatarBlob = _userParam.avatar;
              }
              if (_avatarBlob?.isNotEmpty ?? false) {
                _avatar = Image.memory(
                  _avatarBlob!,
                  fit: BoxFit.cover,
                );
              }

              return Form(
                key: _accountFormKey,
                child: Column(
                  children: [
                    SizedBox(
                      width: 250,
                      height: 250,
                      child: ClipOval(
                        child: _avatar,
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
                      initialValue: _userParam.name,
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
                      onChanged: (value) {
                        _userParam.name = value;
                      },
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
                      onPressed: () {
                        if (_accountFormKey.currentState!.validate()) {
                          _userParam.avatar = _avatarBlob;
                          _userParam.date_modify = DateTime.now().millisecondsSinceEpoch;
                          _userParam.save();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Изменения сохранены',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }
                      },
                      child: const Text('Сохранить'),
                    ),
                  ],
                ),
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
