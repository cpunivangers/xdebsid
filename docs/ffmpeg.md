# Conversion vidéo

## Qualité DVD (480)
ffmpeg -i Coline.mp4 -s hd480 -r 30 -vcodec libx264 ~/Vidéos/Coline_480.mp4

## Qualité HD Ready (720)
ffmpeg -i Coline.mp4 -s hd720 -r 30 -vcodec libx264 ~/Vidéos/Coline_720.mp4

## Qualité Full HD (1080)
ffmpeg -i Coline.mp4 -s hd1080 -r 30 -vcodec libx264 ~/Vidéos/Coline_1080.mp4

## webm 480
ffmpeg  -i Coline.mp4 -codec:v libvpx -quality good -cpu-used 0 -b:v 600k -maxrate 600k -bufsize 1200k -qmin 10 -qmax 42 -vf scale=-1:480 -threads 4 -codec:a libvorbis -b:a 128k ~/Vidéos/Coline_480p.webm

## webm 720
ffmpeg -i Coline.mp4 -codec:v libvpx -quality good -cpu-used 0 -b:v 2000k -maxrate 2000k -bufsize 4000k -qmin 10 -qmax 42 -vf scale=-1:720 -threads 4 -codec:a libvorbis -b:a 128k ~/Vidéos/Coline_720p.webm

## webm 1080
ffmpeg -i Coline.mp4 -codec:v libvpx -quality good -cpu-used 0 -b:v 4000k -maxrate 4000k -bufsize 8000k -qmin 10 -qmax 42 -vf scale=-1:1080 -threads 4 -codec:a libvorbis -b:a 128k ~/Vidéos/Coline_1080p.webm
