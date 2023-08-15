


call flutter build web --web-renderer html 
rem --release


call surge .\build\web --domain %1.surge.sh
