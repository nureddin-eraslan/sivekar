import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:audioplayer/audioplayer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:share/share.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

import 'services/advert_services.dart';

typedef void OnError(Exception exception);
enum PlayerState { stopped, playing, paused }
const kUrl="https://firebasestorage.googleapis.com/v0/b/hikayem-d5343.appspot.com/o/WhatsApp%20Audio%202020-05-20%20at%2018.56.11%20(online-audio-converter.com).mp3?alt=media&token=7e0a4722-753f-41e3-9e06-d37b76d522d3";
class SiirDetay extends StatefulWidget {

  final DocumentSnapshot siir;


  const SiirDetay({Key key, this.siir}) : super(key: key);
  @override
  _SiirDetayState createState() => _SiirDetayState();
}

class _SiirDetayState extends State<SiirDetay> {
  final AdvertService _advertService = AdvertService();
  double _lowerValue = 50;
  double _upperValue = 180;
  int sayac=0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      /* bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.white,
          color: Colors.pink,
          items: <Widget>[
            Icon(Icons.add, size: 30,color: Colors.white, ),
            Icon(Icons.list, size: 30,color: Colors.white, ),
            Icon(Icons.compare_arrows, size: 30,color: Colors.white,),
          ],


          onTap: (index) {
            //Handle button tap

          },
        ),*/
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,color: Colors.pink,),
            onPressed: (){
              Navigator.pop(context);
            },

          ),
          actions: <Widget>[
            Container(
              height: 20,width: 50,
              child:IconButton(
                  icon: Icon(Icons.share,color: Colors.pink,),
                  onPressed: (){
                    final RenderBox box = context.findRenderObject();
                    Share.share(
                        "ŞiveKarın Sesi:Şiir Uygulaması\n\n"+widget.siir.data['isim']+"\n Adlı Şiiri Seninle Paylaşma istedim: \n\n"+
                            widget.siir.data['yazı'] ,
                        sharePositionOrigin:
                        box.localToGlobal(Offset.zero) &
                        box.size);
                  }
              ),
            )
          ],
          title: Text(widget.siir.data['isim'],
            style: TextStyle(
                fontFamily: 'Caveat',
                color: Colors.pink,
                fontWeight: FontWeight.bold
            ),
          ),
          centerTitle: true,
        ),

        body:

        Container(

          child: Stack(
            children: <Widget>[

              SingleChildScrollView(
                child: Container(

                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        flex:1,
                        child: Container(
                         height: 200,


                          child:FutureBuilder(

                            builder: (_,snapshot){
                              return ListView.builder(
                                itemBuilder: (BuildContext context,int index){
                                sayac++;
                                  return SingleChildScrollView(

                                    child: Container(
                                     // margin: EdgeInsets.only(top:10),
                                      width: 80,
                                      alignment: Alignment.center,
                                      child: Column(
                                        children: <Widget>[

                                      if(index>=0 && index<4)...[
                                    Text(widget.siir.data['misra'][index],style: TextStyle(fontSize: 17),)
                                      ],
                                          if(index==4)...[
                                            Text(" "+"\n")
                                          ],
                                          if(index>=4 && index<8)...[
                                            Text(""+widget.siir.data['misra'][index],style: TextStyle(fontSize: 17),)
                                          ],
                                          if(index==8)...[
                                            Text(" "+"\n")
                                          ],
                                          if(index>=8 && index<12)...[
                                            Text(""+widget.siir.data['misra'][index])
                                          ],
                                          if(index==12)...[
                                            Text(" "+"\n")
                                          ],
                                          if(index>=12 && index<16)...[
                                            Text(""+widget.siir.data['misra'][index])
                                          ],
                                          if(index==16)...[
                                            Text(" "+"\n")
                                          ],
                                          if(index>=16 && index<20)...[
                                            Text(""+widget.siir.data['misra'][index])
                                          ],
                                          if(index==20)...[
                                            Text(" "+"\n")
                                          ],
                                          if(index>=20 && index<24)...[
                                            Text(""+widget.siir.data['misra'][index])
                                          ],
                                          if(index==24)...[
                                            Text(" "+"\n")
                                          ],
                                          if(index>=24 && index<28)...[
                                            Text(""+widget.siir.data['misra'][index])
                                          ],

                                        ],
                                      ),
                                    ),
                                  );
                                },itemCount: widget.siir.data['misra'].length,
                              );
                            },
                          )
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        // color: Colors.black26,
                        height: 250,
                        child: SingleChildScrollView(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Seslendiren : "+widget.siir.data['seslendiren'],
                                  style: TextStyle(fontFamily: 'Indie',fontSize: 24,fontWeight: FontWeight.bold),
                                ),
                                Material(child: _buildPlayer()),
                                if (!kIsWeb)
                                  localFilePath != null ? Text(localFilePath) : Container(),
                                if (!kIsWeb)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        RaisedButton(
                                          onPressed: () => _loadFile(),
                                          child: Text('İndir'),
                                        ),
                                        if (localFilePath != null)
                                          RaisedButton(
                                            onPressed: () => _playLocal(),
                                            child: Text('Oynat'),
                                          ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),

                      ),
                      SizedBox(height: 10,),

                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );

  }

  Duration duration;
  Duration position;

  AudioPlayer audioPlayer;

  String localFilePath;

  PlayerState playerState = PlayerState.stopped;

  get isPlaying => playerState == PlayerState.playing;
  get isPaused => playerState == PlayerState.paused;

  get durationText =>
      duration != null ? duration.toString().split('.').first : '';

  get positionText =>
      position != null ? position.toString().split('.').first : '';

  bool isMuted = false;

  StreamSubscription _positionSubscription;
  StreamSubscription _audioPlayerStateSubscription;

  @override
  void initState() {
    super.initState();
    initAudioPlayer();
    _advertService.showBanner();

  }

  @override
  void dispose() {
    _positionSubscription.cancel();
    _audioPlayerStateSubscription.cancel();
    audioPlayer.stop();
    _advertService.showBanner();
    super.dispose();


  }

  void initAudioPlayer() {
    audioPlayer = AudioPlayer();
    _positionSubscription = audioPlayer.onAudioPositionChanged
        .listen((p) => setState(() => position = p));
    _audioPlayerStateSubscription =
        audioPlayer.onPlayerStateChanged.listen((s) {
          if (s == AudioPlayerState.PLAYING) {
            setState(() => duration = audioPlayer.duration);
          } else if (s == AudioPlayerState.STOPPED) {
            onComplete();
            setState(() {
              position = duration;
            });
          }
        }, onError: (msg) {
          setState(() {
            playerState = PlayerState.stopped;
            duration = Duration(seconds: 0);
            position = Duration(seconds: 0);
          });
        });
  }

  Future play() async {
    await audioPlayer.play(widget.siir.data['ses']);
    setState(() {
      playerState = PlayerState.playing;
    });
  }

  Future _playLocal() async {
    await audioPlayer.play(localFilePath, isLocal: true);
    setState(() => playerState = PlayerState.playing);
  }

  Future pause() async {
    await audioPlayer.pause();
    setState(() => playerState = PlayerState.paused);
  }

  Future stop() async {
    await audioPlayer.stop();
    setState(() {
      playerState = PlayerState.stopped;
      position = Duration();
    });
  }

  Future mute(bool muted) async {
    await audioPlayer.mute(muted);
    setState(() {
      isMuted = muted;
    });
  }

  void onComplete() {
    setState(() => playerState = PlayerState.stopped);
  }

  Future<Uint8List> _loadFileBytes(String url, {OnError onError}) async {
    Uint8List bytes;
    try {
      bytes = await readBytes(url);
    } on ClientException {
      rethrow;
    }
    return bytes;
  }

  Future _loadFile() async {
    final bytes = await _loadFileBytes(widget.siir.data['ses'],
        onError: (Exception exception) =>
            print('_loadFile => exception $exception'));

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/audio.mp3');

    await file.writeAsBytes(bytes);
    if (await file.exists())
      setState(() {
        localFilePath = file.path;
      });

  }



  Widget _buildPlayer() => Container(
    padding: EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(mainAxisSize: MainAxisSize.min, children: [
          IconButton(
            onPressed: isPlaying ? null : () => play(),
            iconSize: 64.0,
            icon: Icon(Icons.play_arrow),
            color: Colors.pink,
          ),
          IconButton(
            onPressed: isPlaying ? () => pause() : null,
            iconSize: 64.0,
            icon: Icon(Icons.pause),
            color: Colors.pink,
          ),
          IconButton(
            onPressed: isPlaying || isPaused ? () => stop() : null,
            iconSize: 64.0,
            icon: Icon(Icons.stop),
            color: Colors.pink,
          ),
        ]),
        if (duration != null)
          Slider(
              inactiveColor: Colors.pink,
              activeColor: Colors.pink,
              value: position?.inMilliseconds?.toDouble() ?? 0.0,
              onChanged: (double value) {
                return audioPlayer.seek((value / 1000).roundToDouble());
              },
              min: 0.0,
              max: duration.inMilliseconds.toDouble()),
        if (position != null) _buildMuteButtons(),
        if (position != null) _buildProgressView()
      ],
    ),
  );

  Row _buildProgressView() => Row(mainAxisSize: MainAxisSize.min, children: [
    Padding(
      padding: EdgeInsets.all(12.0),
      child: CircularProgressIndicator(

        value: position != null && position.inMilliseconds > 0
            ? (position?.inMilliseconds?.toDouble() ?? 0.0) /
            (duration?.inMilliseconds?.toDouble() ?? 0.0)
            : 0.0,
        valueColor: AlwaysStoppedAnimation(Colors.pink),
        backgroundColor: Colors.grey.shade400,
      ),
    ),
    Text(
      position != null
          ? "${positionText ?? ''} / ${durationText ?? ''}"
          : duration != null ? durationText : '',
      style: TextStyle(fontSize: 24.0),
    )
  ]);

  Row _buildMuteButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        if (!isMuted)
          FlatButton.icon(
            onPressed: () => mute(true),
            icon: Icon(
              Icons.headset_off,
              color: Colors.pink,
            ),
            label: Text('Sessize Al', style: TextStyle(color: Colors.pink)),
          ),
        if (isMuted)
          FlatButton.icon(
            onPressed: () => mute(false),
            icon: Icon(Icons.headset, color: Colors.cyan),
            label: Text('Sesliye Al', style: TextStyle(color: Colors.cyan)),
          ),
      ],
    );
  }

}





