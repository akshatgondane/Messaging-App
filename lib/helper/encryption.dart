import 'dart:convert';

import 'package:encrypt/encrypt.dart' as enc;

class Encryption
{
  final key = enc.Key.fromUtf8('H4WtkvK4qyehIe2kjQfH7we1xIHFK67e'); //32 length
  final iv = enc.IV.fromUtf8('HgNRbGHbDSz9T0CC');

  String encrypt(String str)
  {
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.ctr, padding: null));
    final encrypted = encrypter.encrypt(str, iv: iv);
    final ciphertext = encrypted.base64;

    return ciphertext;
  }

  String decrypt(String str)
  {
    final decrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.ctr, padding: null));
    final decrypted = decrypter.decryptBytes(enc.Encrypted.fromBase64(str), iv: iv);
    final decryptedData = utf8.decode(decrypted);

    return decryptedData;

  }
}