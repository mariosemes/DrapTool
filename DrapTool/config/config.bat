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

rem Timestamp creator for overwriting protection
set hour=%time:~0,2%
if "%hour:~0,1%" == " " set hour=0%hour:~1,1%
echo hour=%hour%
set min=%time:~3,2%
if "%min:~0,1%" == " " set min=0%min:~1,1%
echo min=%min%
set secs=%time:~6,2%
if "%secs:~0,1%" == " " set secs=0%secs:~1,1%
echo secs=%secs%
set timestamp=%hour%h%min%m%secs%s

rem Aerender.exe file location
set aerender="C:\Program Files\Adobe\Adobe After Effects CC 2019\Support Files\aerender.exe"