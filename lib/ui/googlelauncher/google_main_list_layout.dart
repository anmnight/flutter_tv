import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/arch/change_notifier_provider.dart';
import 'package:flutter_tv/ui/googlelauncher/google_main_movie_model.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../business/movies_bloc.dart';
import '../base/tv_movie_card.dart';

class GoogleMainListLayout extends StatelessWidget {
  GoogleMainListLayout({
    Key? key,
  }) : super(key: key);

  final _itemScrollController = ItemScrollController();

  final double itemWidth = 240.0;

  _moveToItem(int item) {
    Future.delayed(Duration.zero, () {
      _itemScrollController.scrollTo(
        index: item,
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      );
    });
  }

  _handleFocusOffsetChange(index, offset) {
    if (offset.dx < 600) {
      if (index <= 1) {
        _moveToItem(0);
      } else {
        _moveToItem(index - 1);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MoviesBloc>(
      create: (_) => MoviesBloc()..add(MoviesEvent.initializing),
      child: BlocBuilder<MoviesBloc, MoviesState>(builder: (context, state) {
        if (state is MoviesLoadedState) {
          return Container(
            height: 180,
            child: ScrollablePositionedList.builder(
              itemCount: state.movies.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: itemWidth,
                  padding: EdgeInsets.all(20),
                  child: TvMovieCard(
                    blockOnFocus: (isFocus) {
                      if (isFocus) {
                        ChangeNotifierProvider.of<GoogleMainMovieModel>(context,
                                listen: false)
                            ?.update(state.movies[index]);
                      }
                    },
                    focusOffsetChange: (value) {
                      _handleFocusOffsetChange(index, value);
                    },
                    movie: state.movies[index],
                  ),
                );
              },
              shrinkWrap: false,
              scrollDirection: Axis.horizontal,
              itemScrollController: _itemScrollController,
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
