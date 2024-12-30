import 'package:flutter/material.dart';
import 'package:flutter_movies_app/constants.dart';
import 'package:flutter_movies_app/models/movie.dart';
import 'package:flutter_movies_app/utilities/extensions.dart';
import 'package:flutter_movies_app/utilities/helper_functions.dart';
import 'package:flutter_movies_app/widgets/icon_with_text.dart';

class MovieHomeTile extends StatelessWidget {
  const MovieHomeTile({
    super.key,
    required this.movie,
    re,
    required this.onTap,
  });

  final Movie movie;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height * 0.2,
        child: Row(
          children: [
            Expanded(
              child: Image.network(
                '$posterBasePath${movie.posterPath}',
                fit: BoxFit.fitHeight,
                errorBuilder: (context, error, stackTrace) => SizedBox(
                  child: Icon(Icons.no_photography_outlined),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, style: context.textTheme?.titleLarge),
                    SizedBox(height: 10),
                    IconWithText(icon: Icons.star_border_outlined, text: movie.voteAverage.toStringAsFixed(1)),
                    IconWithText(icon: Icons.movie, text: getYearFromDate(movie.releaseDate)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
