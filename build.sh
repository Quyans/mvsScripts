HOME=/home/hadoop/leedua/
cd ${HOME}mvsbuild
cmake . ../openMVS -DCMAKE_BUILD_TYPE=Release -DVCG_ROOT=${HOME}vcglib

make -j64
