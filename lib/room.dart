import 'dart:convert';

import 'package:family_budget/model/model.dart';

class Room {
  static late RoomParam _roomParams;
  static RoomParam get params => _roomParams;

  static update() async {
    _roomParams = RoomParam();
    try {
      List rooms = (await RoomParam()
          .select()
          .status
          .not
          .equals(0)
          .orderByDesc("date_modify")
          .toList());
      if (rooms.isNotEmpty) {
        _roomParams = rooms.first;
      }
    } catch (e) {}
  }

  //Убрать!!
  static newRoomInit() async {
    await RoomParam().select().delete();
    _roomParams = RoomParam.withFields(1, DateTime.now().millisecondsSinceEpoch, 1, "test",  base64Decode(
        'iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAAuIwAALiMBeKU/dgAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAAQ5SURBVGiB7dhbiFVVGAfwnzM6RioJqRVmJZjaPbJMJUrsohVUUBZ080oPXainIsT3svIpSgr0QYuQIDCzQpRA1HookhC0i44wmhUVmWPlZaaHtXez9p6z9+xzDvS0/7Bg7bP+33996+xvfWt9mxo1atSoUaOGYU3yL8MCXIIO9GArvmrTjxm4HRPRh258jH1t6g7C5fgU/QXtC8xqQXd2Yluk+wmmt+n7f1iAYyWTpe0fLG5CdwlOVtA9hvntLuJaHM8Jf47VeBXbhVBIx07jjgq68xNuancG2xLN1Qa/peO4utVFDMPuSOxXjf+ZmTgU8Q5iZInuWcIeSPnduL4B765kzpS3s/klBNwcifQlz0WYjhMR/9ES7uMR7wSmlXDnyr7xm6q5nsWqSGBzBf4bEf+9Et7GiPd6Bd0tEf+lIlJHicCUqL+9woTbov6l/7du2UJGRf0TFSaMOaMKWYxoQ3d0EalsIUei/pUVJrwq6h8u4R1oQ7enAn8QHjEQm7/h3BLuSHwf8V8s4a6IeN+iq4Q7Dr9H/Icr+p5Bl/BWUpGtGr/aEXhHNhONK9GdgL8i/nrZcEsxRtgfKe+w8kWX4rFIqB8/4EnhcLpCOMn35DgrchpjkxZjZc7mayxKNK/BU0IIxpyylF4Jr+QEy9pG4SCdgNdwNBo7Kpzc4xPO+03ormp3ESmWo7dkotPCv9yBG/FjCfcIbki4K2WvKvnWi2VVHOysMH4/FgoncBG/Q9jwo4WD8bwSzTG4R7gw3ouLK/hwSkgM/UNwG+I2g+O/mdaLZ3FB0p5T/laHantwazMLGC7si/iOk7Ye4cqwDmuFTHaoAa8fSxtoLyvgHkq01ibaW4Qslef14WVDR5IufJQzPok1wg21qKKchQ2Rzd8ap8ouoW5JeRsUF2TDhL20Rgit2KdNGqdshDh/N2ewE1OLDHKYGdn9ofGtoUO2SJtZUXsaduV821Awh2dyxPXK64o8xgkFUmp/SwPO3Gj8jPLbQh4jE59iH5/OkybLVoJbVIjDBtgeaRzAddHYDKHoSse3DbIeGp3CR4lU40+5rPdWNNiDc1qYhPAxIY7nPuxPWpw8TgnnTSsYK5sI3kwHxstWd5UOoAKMwg7Z19+o7cDZbcyzPNLqlYTokujHw1oLKUJS2F/geKO2T3kBVoZO2QvtouGYFxE2CZuwWUzGZ8LBl6IHH+C75Hkq7sOFyfO0xGaOcI40gzP4EE8kz/Ngr4GVLWxSkPDvxJ9vTuF5xefIC7L7aLfWouChSOMb+Dn6YXYLgksj+z48UMHmQdnNv7iFeedE9j91Cllgl3D4bVatjo6xDucn/bdVu3LvxSQD6fkiIXM2g7Q424kvm7QdhEmyG3hKOT2DqTnbie060w7ujhw52IJ9d2R/ZzuODG/HGL8YCIlWFrJGyHiEz6M1atSoUaNGjXbwLy8V2V9tscpUAAAAAElFTkSuQmCC'),
        "ENTER");
    await _roomParams.save();
  }

  static roomExit() async {
    _roomParams = RoomParam();

    await Category().select().delete();
    await Operation().select().delete();
    await RoomMember().select().delete();
    await RoomParam().select().delete();
    await Chat().select().delete();
  }
}
