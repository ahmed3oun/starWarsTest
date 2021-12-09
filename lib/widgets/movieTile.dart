import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:star_wars_api/model/movie.model.dart';

class MovieTile extends StatelessWidget {
  final double height;
  final double width;
  final Movie movie;

  const MovieTile({
    Key? key,
    required this.movie,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          _moviePosterWidget(
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6WQqXxaAYlb3GCqpe53BuSO_s0F2mEriOAQ&usqp=CAU",
          ),
          _movieInfoWidget(),
        ],
      ),
    );
  }

  Widget _moviePosterWidget(String imgUrl) {
    return Container(
      height: height * 0.9,
      width: width * 0.30,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imgUrl),
        ),
      ),
    );
  }

  _movieInfoWidget() {
    return Container(
      height: height,
      width: width * 0.70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: width * 0.50,
                child: Text(
                  movie.title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Text(
                "Director : ${movie.director}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, height * 0.02, 0, 0),
            child: Text(
              ' Cre: ${movie.created}\n Released at : ${movie.release_date}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, height * 0.07, 0, 0),
            child: Text(
              movie.opening_crawl,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 9,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
