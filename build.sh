HOME=/home/hadoop/leedua/
cd ${HOME}mvsbuild

DEBUG="Release";
case "$1" in
  "-d")DEBUG="DEBUG";;
  *);;
esac

cmake . ../openMVS -DCMAKE_BUILD_TYPE=${DEBUG} -DVCG_ROOT=${HOME}vcglib

cmake --build . -j64 --target RefineMesh
cmake --build . -j64 --target ViewFilter
cmake --build . -j64 --target TextureMesh
