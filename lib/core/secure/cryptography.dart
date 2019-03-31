import 'package:encrypt/encrypt.dart';

Encrypted encrypt(final String target, final String key, {ivLength = 16}) =>
    Encrypter(
      AES(
        Key.fromUtf8(key),
        IV.fromLength(ivLength),
      ),
    ).encrypt(target);

String decrypt(final Encrypted target, final String key, {ivLength = 16}) =>
    Encrypter(
      AES(
        Key.fromUtf8(key),
        IV.fromLength(ivLength),
      ),
    ).decrypt(target);
