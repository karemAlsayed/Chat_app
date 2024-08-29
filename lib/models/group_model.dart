class GroupRoom {
  String? id;
  String? name;
  String? image;
  List? members;
  List? admin;
  String? lastMessage;
  String? lastMessageTime;
  String? createdAt;

  GroupRoom({
    this.id,
    this.name,
    this.image,
    this.members,
    this.admin,
    this.lastMessage,
    this.lastMessageTime,
    this.createdAt,
  });

  factory GroupRoom.fromJson(Map<String, dynamic> json) {
    return GroupRoom(
      id: json['id']??'',
      name: json['name']??'',
      image: json['image']??'',
      members: json['members']??[],
      admin: json['admin']??[],
      lastMessage: json['last_message']??'',
      lastMessageTime: json['last_message_time']??'',
      createdAt: json['created_at']??'',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'members': members,
      'admin': admin,
      'last_message': lastMessage,
      'last_message_time': lastMessageTime,
      'created_at': createdAt,
    };
  }
}
