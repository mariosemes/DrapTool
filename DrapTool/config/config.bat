rem General settings
set scriptpath=C:\DrapTool

rem Set the quality output for MP4 optimizarion
set mp4quality=24

rem Video converter settings for MP4 to WEBM
set mp4towebm=-c:v libvpx -crf 10 -b:v 1M -c:a libvorbis

rem Video converter settings for MP4 to ogg
set mp4toogg=-c:v libtheora -q:v 7 -c:a libvorbis -q:a 4

rem Video converter settings for AVI to MP4
set avitomp4=-strict -2

rem Video converter settings for MOV to MP4
set movtomp4=-vcodec h264 -acodec mp2

rem Video converter settings for MKV to MP4
set mkvtomp4=-codec copy