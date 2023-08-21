


call flutter build web --web-renderer html --no-tree-shake-icons
rem --release


call surge .\build\web --domain %1.surge.sh  
