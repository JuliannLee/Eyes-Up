import 'package:cloud_firestore/cloud_firestore.dart';
class EventModel {
  String? id;
  List<String> gambar;
  String judul;
  String keterangan;
  bool is_like;
  int loveCount;
  EventModel(
  {
    this.id,
    required this.gambar,
    required this.judul,
    required this.keterangan,
    required this.is_like,
    required this.loveCount,
  }
 );
 
 Map<String, dynamic> toMap(){
  return {
    "Gambar" : gambar,
    'Judul': judul,
    'Keterangan' : keterangan,
    'is_like' : is_like,
    'love_count' : loveCount
  };
 }
 EventModel.fromDocSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        gambar = List<String>.from(doc.data()?['Gambar']),
        judul = doc.data()?['Judul'],
        keterangan = doc.data()?['Keterangan'],
        is_like = doc.data()?['is_like'],
        loveCount = doc.data()?['love_count'];
  void toggleLove() {
    is_like = !is_like;
    loveCount += is_like ? 1 : -1;
  }
}
 