class PostModel {
  // Fields representing post details
  int? postId;
  int? id;
  String? name;
  String? email;
  String? body;

  // Constructor to initialize the PostModel fields
  PostModel({this.postId, this.id, this.name, this.email, this.body});

  /// Factory constructor to create a PostModel object from JSON data
  PostModel.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    body = json['body'];
  }

  /// Method to convert a PostModel object to JSON format
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postId'] = this.postId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['body'] = this.body;
    return data;
  }
}
