import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:synctone/modules/player/bloc/song_player_cubit.dart';
import 'package:synctone/modules/player/bloc/song_player_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:synctone/widgets/now_playing_image.dart';
import 'package:synctone/widgets/settings_menu_widget.dart';

import '../main/main_controller.dart';

class PlayerScreen extends StatefulWidget {
  PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  MainController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.playerTitle),
          leading: const SettingsMenuWidget(),
        ),
        body: Obx(() {
          return BlocProvider(
              key: ValueKey(controller.currentSong.value),
              create: (_) => SongPlayerCubit()..loadSong(controller.currentSong.value.audioUrl),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      NowPlayingImage(song: controller.currentSong.value),
                      _songPlayer()
                    ],
                  ),
                ),
              )
          );
        })
    );
  }

  Widget _songPlayer() {
    return BlocBuilder<SongPlayerCubit,SongPlayerState>(
        builder: (context, state){
          if(state is SongPlayerLoading) {
            return const CircularProgressIndicator();
          }
          if(state is SongPlayerLoaded) {
            return Column(
              children: [
                Slider(
                  value: context.read<SongPlayerCubit>().songPosition.inSeconds.toDouble(),
                  min: 0.0,
                  max: context.read<SongPlayerCubit>().songDuration.inSeconds.toDouble(),
                  onChanged: (value) {},
                  activeColor: const Color(0xFF8400C4) ,
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatDuration(
                          context.read<SongPlayerCubit>().songPosition
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: (){
                        context.read<SongPlayerCubit>().playOrPauseSong();

                      },
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF8400C4)
                        ),
                        child: Icon(
                          context.read<SongPlayerCubit>().audioPlayer.playing
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      formatDuration(
                          context.read<SongPlayerCubit>().songDuration
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 20),


              ],
            );
          }
          return Container();
        }
    );
  }
  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2,'0')}:${seconds.toString().padLeft(2,'0')}';
  }
}