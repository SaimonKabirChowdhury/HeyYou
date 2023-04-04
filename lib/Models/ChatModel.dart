class ChatModel{
  String? name;
  String? currentMsg;
  bool? isGroup = false;
  String? time;
  String? status;
  bool? select = false;
  int? id;

  ChatModel({ this.name,  this.isGroup,  this.time, this.currentMsg, this.status, this.select =false, this.id});

}