// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/models/message_content.dart';
import 'package:flutter_project_labour_app/models/room.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/endpoints.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_project_labour_app/util/storage_access.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:bubble/bubble.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ContractorChatScreen extends StatefulWidget {
  static String id = 'FeedbackChatScreen';
  final Room room;

  const ContractorChatScreen({super.key, required this.room});

  @override
  _ContractorChatScreen createState() => _ContractorChatScreen();
}

class _ContractorChatScreen extends State<ContractorChatScreen> {
  final _formKey = GlobalKey<FormState>();
  final ScrollController _controller = ScrollController();

  TextEditingController messageTextController = TextEditingController();
  bool isMessageSent = false;
  bool oldDataFetched = false;

  List<MessageContent> _messages = [];

  WebSocketChannel? channel;

  String accessToken = '';

  Future fetchWorkoutFeedbackTillNow() async {
    var token = await StorageAccess.getToken();
    if (token == null) {
      return;
    }
    var response = await http.get(
      Uri.parse('${Endpoints.contractorGetMessages}?room_id=${widget.room.id}'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode < 299) {
      var body = jsonDecode(response.body);
      if (body['data'] != null) {
        var jobs = (body['data'] as List);
        var messages = <MessageContent>[];
        for (var job in jobs) {
          messages.add(MessageContent.fromJson(job));
        }
        setState(() {
          _messages.addAll(messages);
        });
      }
    } else {
      Fluttertoast.showToast(
        msg: 'Some problem occurred while connecting to the server!',
        backgroundColor: const Color(0xFF272833).withOpacity(0.8),
      );
    }
    debugPrint('Old messages Loaded');
    setState(() {
      oldDataFetched = true;
    });
  }

  void onStart() async {
    var token = await StorageAccess.getToken();
    if (token == null) {
      return;
    }

    await fetchWorkoutFeedbackTillNow();

    channel = IOWebSocketChannel.connect(
      '${Endpoints.contractorChatStream}?room_id=${widget.room.id}',
      headers: {'Authorization': 'Bearer $token'},
    );

    channel!.stream.listen((message) {
      if (kDebugMode) {
        print('MESSAGE: $message');
      }
      var data = jsonDecode(message);
      isMessageSent = false;
      var currentTime = DateTime.now();
      setState(() {
        debugPrint(MessageContent(
          labourMessage: data['labour_message'],
          contractorMessage: "",
          time: currentTime,
        ).toString());
        _messages.insert(
          0,
          MessageContent(
            labourMessage: data['labour_message'],
            contractorMessage: "",
            time: currentTime,
          ),
        );
      });
    });
  }

  @override
  void initState() {
    super.initState();
    onStart();
  }

  void _sendMessage() {
    final message = messageTextController.text.trim();
    if (message.isNotEmpty) {
      channel!.sink.add('{"contractor_message": "$message"}');
      messageTextController.clear();
      setState(() {
        var currentTime = DateTime.now();
        isMessageSent = true;
        debugPrint(MessageContent(
          labourMessage: "",
          contractorMessage: message,
          time: currentTime,
        ).toString());
        _messages.insert(
          0,
          MessageContent(
            labourMessage: "",
            contractorMessage: message,
            time: currentTime,
          ),
        );
      });
    }
  }

  @override
  void dispose() {
    channel!.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.room.contractorName,
            style: authHeading,
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Stack(
                children: [
                  if (!oldDataFetched)
                    Container(
                      height: screenHeight * 0.7,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 200,
                            child: Lottie.network(
                              'https://lottie.host/6bff57cf-c1eb-4b72-ba12-6497ee66710d/zPBJsKYOxb.json',
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Loading Your Feedbacks!',
                            style: authInfoHeading,
                          )
                        ],
                      ),
                    )
                  else if (_messages.isEmpty)
                    const Center(
                        child: Text(
                      'No Chat\'s Found!\nGet Started With Your FeedBacks',
                      textAlign: TextAlign.center,
                    ))
                  else
                    ListView.builder(
                      reverse: true,
                      itemCount: _messages.length,
                      controller: _controller,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        if (_messages[index].contractorMessage.trim().isEmpty) {
                          debugPrint(_messages[index].toString());
                          return MessageBubble(
                            sender: "You",
                            text: _messages[index].contractorMessage,
                            isMe: true,
                            dateTime: _messages[index].time.toString(),
                            currentTime: _messages[index].time.toString(),
                          );
                        } else {
                          return MessageBubble(
                            sender: widget.room.labourName,
                            text: _messages[index].labourMessage,
                            isMe: false,
                            dateTime: _messages[index].time.toString(),
                            currentTime: _messages[index].time.toString(),
                          );
                        }
                      },
                    ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 14, right: 14, top: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please';
                        }
                        return null;
                      },
                      controller: messageTextController,
                      maxLines: 10,
                      minLines: 1,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                          color: Color(0xFFA3A4A4),
                          fontSize: 14,
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w400,
                        ),
                        contentPadding: const EdgeInsets.only(
                          left: 30,
                          top: 15,
                          bottom: 15,
                        ),
                        hintText: 'Type your message here...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(
                            color: Color(0xFFE5E5E5),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(
                            color: Color(0xFFE5E5E5),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(
                            color: Color(0xFFE5E5E5),
                          ),
                        ),
                        errorStyle: const TextStyle(
                          fontSize: 0,
                        ),
                      ),
                      onFieldSubmitted: (value) {
                        if (_formKey.currentState!.validate()) {
                          _sendMessage();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      right: 10,
                    ),
                    decoration: const ShapeDecoration(
                      color: primaryRed,
                      shape: OvalBorder(),
                    ),
                    child: IconButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _sendMessage();
                        }
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 23,
            )
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatefulWidget {
  MessageBubble({
    required this.sender,
    required this.text,
    required this.isMe,
    required this.dateTime,
    required this.currentTime,
  });

  final String sender;
  final String text;
  final bool isMe;
  final String dateTime;
  final String currentTime;

  @override
  _MessageBubbleState createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > 300) {
      isExpanded = false;
    } else {
      isExpanded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime createdAt = DateTime.parse(widget.currentTime);

    String formattedCreatedAt =
        DateFormat('dd MMM yyyy, HH:mm').format(createdAt);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment:
            widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment:
                  widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            ),
          ),
          Bubble(
            radius: const Radius.circular(16),
            margin: widget.isMe
                ? const BubbleEdges.fromLTRB(80, 1, 0, 1)
                : const BubbleEdges.fromLTRB(0, 1, 80, 1),
            color: widget.isMe ? primaryRed : const Color(0xFFEFEFEF),
            nip: widget.isMe ? BubbleNip.rightBottom : BubbleNip.leftBottom,
            showNip: true,
            nipOffset: 5,
            nipWidth: 2,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Column(
                crossAxisAlignment: widget.isMe
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6, bottom: 6),
                    child: isExpanded
                        ? Text(
                            widget.text,
                            textAlign:
                                widget.isMe ? TextAlign.right : TextAlign.left,
                            style: TextStyle(
                              fontSize: 15,
                              color: widget.isMe ? Colors.white : Colors.black,
                            ),
                          )
                        : LimitedBox(
                            // maxHeight: 50,
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Text(
                                      isExpanded
                                          ? widget.text
                                          : '${widget.text.length > 300 ? widget.text.substring(0, 300) : widget.text}',
                                      textAlign: widget.isMe
                                          ? TextAlign.right
                                          : TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: widget.isMe
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                  if (widget.text.length > 300)
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: // Show the "Show More" button if the text exceeds a certain length
                                          GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isExpanded = !isExpanded;
                                          });
                                        },
                                        child: Text(
                                          isExpanded
                                              ? 'Show Less'
                                              : 'Show More',
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              textAlign: widget.isMe
                                  ? TextAlign.right
                                  : TextAlign.left,
                            ),
                          ),
                  ),
                  Text(
                    formattedCreatedAt,
                    style: TextStyle(
                        color: widget.isMe ? Colors.white : Colors.black,
                        fontStyle: FontStyle.italic,
                        fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
