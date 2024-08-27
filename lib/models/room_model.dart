class ChatRoom {
  String? id;
  String? lastMessage;
  String? lastMessageTime;
  
  String? createdAt;

  List? members;

  ChatRoom({
    required this.id,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.members,
  
    required this.createdAt,
  
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      id: json['id'],
    
      createdAt: json['created_at'],

      lastMessage: json['last_message'],

      lastMessageTime: json['last_message_time'],

      members: json['members'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      
      'created_at': createdAt,

      'last_message': lastMessage,

      'last_message_time': lastMessageTime,

      'members': members,
    };
  }
}
