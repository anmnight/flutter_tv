import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/extensions.dart';
import '../../arch/change_notifier_provider.dart';
import '../../business/movies_bloc.dart';
import '../widgets/scroll_snap_list.dart';
import '../widgets/tv_movie_card.dart';
import 'google_main_movie_model.dart';

class GoogleMainListLayout extends StatelessWidget {
  const GoogleMainListLayout({
    Key? key,
  }) : super(key: key);

  Widget _buildItem(context, movie) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(15),
      child: TvMovieCard(
        blockOnFocus: (isFocus) {
          if (isFocus) {
            ChangeNotifierProvider.of<GoogleMainMovieModel>(context,
                    listen: false)
                ?.update(movie);
          }
        },
        focusOffsetChange: (value) {},
        movie: movie,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MoviesBloc>(
      create: (_) => MoviesBloc()..add(MoviesEvent.initializing),
      child: BlocBuilder<MoviesBloc, MoviesState>(builder: (context, state) {
        if (state is MoviesLoadedState) {
          return SizedBox(
            width: kTvSize.width,
            height: 120,
            child: ScrollSnapList(
              selectedItemAnchor: SelectedItemAnchor.START,
              shrinkWrap: false,
              updateOnScroll: true,
              itemCount: state.movies.length,
              initialIndex: 0,
              itemSize: 180,
              itemBuilder: (buildContext, index) =>
                  _buildItem(context, state.movies[index]),
              onItemFocus: (index) {
                printDebug("index : $index");
              },
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
