HOME=/home/qys/Documents/git_clone/myOpenMVS/
cd ${HOME}mvsbuild

DEBUG="Release";
case "$1" in
  "-d")DEBUG="RelWithDebInfo";;
  *);;
esac

cmake . ../openMVS-1 -DCMAKE_BUILD_TYPE=${DEBUG} -DVCG_ROOT=${HOME}vcglib

cmake --build . -j 4 --target TextureMesh
