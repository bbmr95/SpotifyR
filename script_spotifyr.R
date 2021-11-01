library(spotifyr)
library(dplyr)
library(Hmisc)
library(readxl)

setwd('C:/Users/mosqu/OneDrive/Escritorio/RSTUDIO')
Sys.setenv(SPOTIFY_CLIENT_ID = '3f8718cf44964c5e88b5058c828e4626')
Sys.setenv(SPOTIFY_CLIENT_SECRET = '89a1e4e2566944668bb90fed660bc5ab')
access_token <- get_spotify_access_token()


vector_date = c(
format(Sys.Date(),'%d'),
format(Sys.Date(),'%m'),
format(Sys.Date(),'%y')
)

fn_id_artists = function(vec) {
  pre_base_artist_0 = c()
  for (x in vec) {
    off = 0
    t = 0
    while (t == 0) {
      call = get_label_artists(x, limit = 20, offset = off)
      if (nrow(call) != 0) {
        pre_base_artist_0 = c(pre_base_artist_0, c(id_artist = call[,3]))
        off = off + 20
        message(off)
      } else {
        t = 1
      }
    }
  }
  return(pre_base_artist_0)
}

fn_id_albums = function(vec) {
  c = 0
  list_ = vec
  pre_base_albums_0 = c()
  for (y in 1:length(list_)) {
    for (x in c(list_[[y]])) {
      off = 0
      t = 0
      while (t == 0) {
        call = get_artist_albums(x, limit = 50, offset = off, include_groups = c("album", "single"))
        if (is.null(nrow(call)) == F) {
          pre_base_albums_0 = c(pre_base_albums_0, c(id_albums = call[,6]))
          off = off + 50
        } else {
          t = 1
        }
      }
      c = c + 1
      message(c)
    }
  }
  pre_base_albums_0 = split(pre_base_albums_0, ceiling(seq_along(pre_base_albums_0)/20))
  return(pre_base_albums_0)
}

fn_id_tracks = function(vec) {
  list_ = vec
  pre_base_tracks_0 = c()
  for (y in 1:length(list_)) {
    for (x in c(list_[[y]])) {
      pre_base_tracks_0 = c(pre_base_tracks_0, c(id_tracks = get_album_tracks(x, limit = 50)[,7]))
    }
  }
  pre_base_tracks_0 = split(pre_base_tracks_0, ceiling(seq_along(pre_base_tracks_0)/50))
  return(pre_base_tracks_0)
}


# creación de listas
listas = list(fn_id_artists('Kids on Coffee'),fn_id_albums(fn_id_artists('Kids on Coffee')),fn_id_tracks(fn_id_albums(fn_id_artists('Kids on Coffee'))))

lista_bases = list(data.frame(),data.frame(),data.frame())


# Base de artistas
for (x in 1:length(listas[[1]])) {
lista_bases[[1]] = 
  rbind(lista_bases[[1]],
  get_artists(listas[[1]][[x]]) %>%
  tidyr::unnest(cols = 'images') %>% 
  group_by(id, name, popularity, type, followers.total, genres) %>% 
  filter(height == max(height)) %>%
  mutate(fec = Sys.Date(),genres = paste(genres)) %>%
  rename(name_artists = name, followers = followers.total, popularity_artists = popularity, id_artists = id, type_artists = type) %>%
  select(id_artists, name_artists, popularity_artists, type_artists, followers, genres, url, fec)
  )
}


# Base de albums

for (x in 1:length(listas[[2]])) {
lista_bases[[2]] = 
  rbind(lista_bases[[2]],
  get_albums(listas[[2]][[x]]) %>%
  tidyr::unnest(cols = 'images') %>% 
  group_by(id, name, type, popularity, release_date, available_markets, total_tracks, label, genres) %>% 
  filter(height == max(height)) %>%
  mutate(fec = Sys.Date(),available_markets = paste(available_markets), genres = paste(genres)) %>%
  rename(name_album = name, popularity_albums = popularity, type_album = type, id_album = id) %>%
  select(id_album, name_album, type_album, popularity_albums, release_date, available_markets, total_tracks, label, genres, url, fec)
  )
}

# Base de canciones
for (x in 1:length(listas[[3]])) {
lista_bases[[3]] = 
  rbind(lista_bases[[3]],
  merge(
  x = get_tracks(listas[[3]][[x]]) %>% 
    tidyr::unnest(cols = artists, name_sep = '.') %>%
    mutate(fec = Sys.Date(),available_markets = paste(available_markets)) %>%
    rename(id_track = id1, name_track = name1, id_artist = id, artist.name = name, popularity_track = popularity, id_album = album.id) %>%
    select(id_track, name_track, duration_ms, popularity_track, id_album, id_artist, track_number, available_markets, explicit, is_local, fec),
  y = get_track_audio_features(listas[[3]][[x]]) %>%
    rename(id_track = id) %>%
    select(id_track, danceability, energy, loudness, speechiness, acousticness, instrumentalness, liveness, valence, 
           tempo, time_signature, key, mode),
  by = 'id_track',
  all.x = T)
  )
}

remove(fn_id_albums,fn_id_artists,fn_id_tracks,x)

save.image(paste("bases_spotify/kids_on_coffee/20",vector_date[3],"_",vector_date[2],"_",vector_date[1],".RData",sep=''))
