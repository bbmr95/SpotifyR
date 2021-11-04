# SpotifyR

<a href="https://imgur.com/iBvyd3g"><img src="https://i.imgur.com/iBvyd3g.png" title="source: imgur.com" /></a>
```diff
¿A que se refiere Spotify cuando habla de "popularidad"?
```
Este trabajo consiste en el desarrollo de bases de datos que recogen la información más importante que ofrecen las funciones del API de Spotify referentes a datos sobre artistas, álbumes y canciones (tracks). Actualmente el proyecto sigue en desarrollo en su etapa de <b>automatización</b></p>

<h2>Investigación y observación</h2>
<p>"spotifyr" contiene un conjunto de funciones derivadas de las funciones que tiene el API de Spotify en su propia página para desarrolladores, solamente que las vuelve utilizables bajo el lenguaje R. El primer paso para poder descubrir el potencial que tiene esta información fue revisar todas las funciones listadas en la documentación del paquete</p>

<b><a href="https://cran.r-project.org/web/packages/spotifyr/spotifyr.pdf">Documentación "spotifyr"</a></b>

<p>
De este conjunto de funciones, 5 muestran información que catalogo de alta relevancia por el tipo de información que almacena
</p>

<b>get_artists():</b> Información de artistas (cantidad de seguidores, nivel de popularidad...) <br>
<b>get_albums():</b> Información de albums (cantidad de tracks, tipos de álbumes, nivel de popularidad, fecha de lanzamiento...)<br>
<b>get_tracks():</b> Información de canciones [tracks] (duración en milisegundos, nivel de popularidad...)<br>
<b>get_track_audio_features():</b> Información relacionada <b>características auditivas</b> de tracks (danzabilidad, energía, acusticidad, tempo, etc)<br>
<b>get_track_audio_analysis():</b> Información sobre <b>secciones</b> determinadas por algoritmos de Spotify (secciones, bars, beats, segmentos)<br>

<h2>Ordenamiento y estructura de información</h2>


<img src="https://i.imgur.com/pKW8y63.png"/>



<center> 
  <img src='https://www.giastinchi.com/assets/work-in-progress.jpg' alt="centered image">
</center>
  
  


