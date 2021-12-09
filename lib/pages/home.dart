// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:star_wars_api/model/movie.model.dart';
import 'package:star_wars_api/service/moviesService.dart';
import 'package:star_wars_api/widgets/movieTile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late MovieService _movieService;
  late double _deviceHeight;
  late double _deviceWidth;
  var _movies = <Movie>[];

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _movieService = MovieService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Star Wars"),
        //backgroundColor: Colors.transparent,
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.9),
        brightness: Brightness.light,

        actions: [
          IconButton(
            onPressed: () => print("search ..."),
            icon: const Icon(Icons.search_rounded),
          ),
        ],
      ),
      body: Container(
        height: _deviceHeight,
        width: _deviceWidth,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            _backgroundWidget(_deviceHeight, _deviceWidth),
            _movieListViewWidget(_deviceHeight, _deviceWidth),
          ],
        ),
      ),
    );
  }

  _backgroundWidget(double deviceHeight, double deviceWidth) {
    return Container(
      height: deviceHeight,
      width: deviceWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0.5),
          image: const DecorationImage(
            image: NetworkImage(
              "https://dailymars-cdn-fra1.fra1.digitaloceanspaces.com/wp-content/uploads/2014/08/star-wars1.jpg",
              //"https://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/Star_Wars_Logo.svg/1200px-Star_Wars_Logo.svg.png",
              //"https://imgsrc.cineserie.com/2019/05/star-wars-une-troisieme-serie-live-action-en-preparation.jpg?ver=1"
              //"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYRt7t9wgvuDpcKqXb63npqEHxzMkqXPLrFPSLSWydOqbHQ24VI4u3WpE7KsPJoC1KjmI&usqp=CAU"),
              //,
            ),
            fit: BoxFit.cover,
          )),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
      ),
    );
  }

  _movieListViewWidget(double deviceHeight, double deviceWidth) {
    /* final List<Movie> _movies = [
      Movie(
        "2014-12-10T14:23:31.880000Z",
        "George Lucas",
        "It is a period of civil war.\rRebel spaceships, striking\rfrom a hidden base, have won\rtheir first victory against\r\nthe evil Galactic Empire.\r\n\r\nDuring the battle, Rebel\r\nspies managed to steal secret\r\nplans to the Empire's\r\nultimate weapon, the DEATH\r\nSTAR, an armored space\r\nstation with enough power\r\nto destroy an entire planet.\r\n\r\nPursued by the Empire's\r\nsinister agents, Princess\r\nLeia races home aboard her\r\nstarship, custodian of the\rstolen plans that can save her\rpeople and restore\rfreedom to the galaxy....",
        "The Empire Strikes Back",
        "1980-05-17",
        "https://swapi.dev/api/films/1/",
      ),
      Movie(
        "2014-12-10T14:23:31.880000Z",
        " Lucas John",
        "It is a period of civil war.\rRebel spaceships, striking\rfrom a hidden base, have won\rtheir first victory against\r\nthe evil Galactic Empire.\r\n\r\nDuring the battle, Rebel\r\nspies managed to steal secret\r\nplans to the Empire's\r\nultimate weapon, the DEATH\r\nSTAR, an armored space\r\nstation with enough power\r\nto destroy an entire planet.\r\n\r\nPursued by the Empire's\r\nsinister agents, Princess\rLeia races home aboard her\r\nstarship, custodian of the\rstolen plans that can save her people and restore\rfreedom to the galaxy....",
        "The Deadth Note",
        "1980-05-17",
        "https://swapi.dev/api/films/1/",
      ),
      Movie(
        "2014-12-10T14:23:31.880000Z",
        "Albert Smith",
        "It is a period of civil war.\rRebel spaceships, striking\rfrom a hidden base, have won\rtheir first victory against\r\nthe evil Galactic Empire.\r\n\r\nDuring the battle, Rebel\r\nspies managed to steal secret\rplans to the Empire's\rultimate weapon, the DEATH\rSTAR, an armored space\rstation with enough power\r\nto destroy an entire planet.\r\n\r\nPursued by the Empire's\r\nsinister agents, Princess\r\nLeia races home aboard her\r\nstarship, custodian of the\rstolen plans that can save her\rpeople and restore\rfreedom to the galaxy....",
        "Never Back  down",
        "1990-05-17",
        "https://swapi.dev/api/films/2/",
      ),
    ]; */
    //final _movies = await _movieService.getMovies();
    setState(() {
      _movieService.getMovies().then((_movies) => {this._movies = _movies});
    });
    if (this._movies.length == 0) {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
    } else {
      return ListView.builder(
        itemBuilder: (_context, _count) {
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: _deviceHeight * 0.01,
              horizontal: 0,
            ),
            child: GestureDetector(
              onTap: () {
                print(_movies[_count].url);
              },
              child: MovieTile(
                movie: _movies[_count],
                height: _deviceHeight * 0.2,
                width: _deviceWidth * 0.85,
              ),
            ),
          );
        },
        itemCount: _movies.length,
      );
    }
  }
}
