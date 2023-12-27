import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health/Chat_App/Models/chat_room_model.dart';
import 'package:health/Chat_App/Models/firebase_helper.dart';
import 'package:health/Chat_App/Models/user_models.dart';
import 'package:health/Chat_App/Pages/Chat_Room.dart';
import 'package:health/Chat_App/Pages/Search_Page.dart';
import 'package:health/Resources/AppColors/app_colors.dart';

class Home extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;

  const Home({Key? key, required this.userModel, required this.firebaseUser}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.purple,
        centerTitle: true,
        title: Text("Messages"),
        // actions: [
        //   IconButton(
        //     onPressed: () async {
        //       await FirebaseAuth.instance.signOut();
        //       Navigator.popUntil(context, (route) => route.isFirst);
        //       Navigator.pushReplacement(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) {
        //             return LoginScreen();
        //           }
        //         ),
        //       );
        //     },
        //     icon: Icon(Icons.exit_to_app),
        //   ),
        // ],
      ),
      body: SafeArea(
        child: Container(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Chat Rooms").where("participants.${widget.userModel.uid}", isEqualTo: true).snapshots(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.active) {
                if(snapshot.hasData) {
                  QuerySnapshot chatRoomSnapshot = snapshot.data as QuerySnapshot;

                  return ListView.builder(
                    
                    itemCount: chatRoomSnapshot.docs.length,
                    itemBuilder: (context, index) {
                      ChatRoomModel chatRoomModel = ChatRoomModel.fromMap(chatRoomSnapshot.docs[index].data() as Map<String, dynamic>);

                      Map<String, dynamic> participants = chatRoomModel.participants!;

                      List<String> participantKeys = participants.keys.toList();
                      participantKeys.remove(widget.userModel.uid);

                      return FutureBuilder(
                        future: FirebaseHelper.getUserModelById(participantKeys[0]),
                        builder: (context, userData) {
                          if(userData.connectionState == ConnectionState.done) {
                            if(userData.data != null) {
                              UserModel targetUser = userData.data as UserModel;

                              return Card(
                                elevation: 5,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return ChatRoomPage(
                                          chatroom: chatRoomModel,
                                          firebaseUser: widget.firebaseUser,
                                          userModel: widget.userModel,
                                          targetUser: targetUser,
                                        );
                                      }),
                                    );
                                  },
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(targetUser.profilePic.toString()),
                                  ),
                                  title: Text(targetUser.fullname.toString()),
                                  subtitle: (chatRoomModel.lastMessage.toString() != "") ? Text(chatRoomModel.lastMessage.toString()) : Text("Say hi to your new friend!", style: TextStyle(
                                    color: Theme.of(context).colorScheme.secondary,
                                  ),),
                                ),
                              );
                            }
                            else {
                              return Container();
                            }
                          }
                          else {
                            return Container();
                          }
                        },
                      );
                    },
                  );
                }
                else if(snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                else {
                  return Center(
                    child: Text("No Chats"),
                  );
                }
              }
              else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.purple,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SearchPage(userModel: widget.userModel, firebaseUser: widget.firebaseUser);
          }));
        },
        child: Icon(Icons.search),
      ),
    );
  }
}