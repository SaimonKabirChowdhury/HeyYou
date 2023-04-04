import 'package:socket_io_client/socket_io_client.dart' as io;
class MessageModel {
  String? type;
  String? message;
  String? time;
  io.Socket socket;
  MessageModel( {this.message, this.type, this.time, required this.socket});

}
