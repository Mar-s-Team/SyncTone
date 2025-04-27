class ApiEndpoints {
  static const artists = 'artists/?';
  static const artistsAlbums = 'artists/albums/?';
  static const albums = 'albums/?';
  static const albumsTracks = 'albums/tracks/?';
  static const playlists = 'playlists/?';
  static const playlistsTracks = 'playlists/tracks/?';
  static const tracks = 'tracks/?include=musicinfo';
  static const newReleases = '${tracks}&order=releasedate_desc&groupby=artist_id&boost=popularity_month';
  static const trendingSpanish = '${tracks}&lang=es&groupby=artist_id&order=listens_week_desc';

  static String trackById(String id){
    return '${tracks}&id=$id';
  }

}