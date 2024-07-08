import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideosplayerScreen extends StatefulWidget {
  const VideosplayerScreen({super.key});

  @override
  State<VideosplayerScreen> createState() => _VideosplayerScreenState();
}

class _VideosplayerScreenState extends State<VideosplayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
@override
 void initState() {
  _controller 
  = VideoPlayerController.networkUrl
  (Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',));
  _initializeVideoPlayerFuture = _controller.initialize();
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: const Text("Butterfly videos",
          style: TextStyle(fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black),),
      ),
      body: FutureBuilder(future: _initializeVideoPlayerFuture,
      
      
       builder: (context,snapshot){
        

        if(snapshot.connectionState == ConnectionState.done){
        return AspectRatio(
          
          aspectRatio: _controller.value.aspectRatio,
          
          child: VideoPlayer(_controller),
          );
        
        
        }
        else{
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
       }),
       floatingActionButton: FloatingActionButton(onPressed: (){

setState(() {
  if(_controller.value.isPlaying){
    _controller.pause();

  }
  else{
    _controller.play();
  }
});

       },
       child:  Icon(_controller.value.isPlaying? Icons.pause: Icons.play_arrow),
       
       ),
    );
  }
}