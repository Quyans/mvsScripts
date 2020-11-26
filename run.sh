HOME=/home/hadoop/leedua/
BIN=${HOME}mvsbuild/bin/
FILTER=false
DEBUG=false
#INPUT_MVS=/home/hadoop/data/data/1kmMesh/scene_1km.mvs
RAW_MVS=/home/hadoop/data/data/yq/Mesh/scene_test/scene_mesh.mvs
INPUT_MVS=/home/hadoop/data/data/yq/Mesh/scene_test/scene_mesh_filtered.mvs
FILTER_FILE=/home/hadoop/data/data/yq/Mesh/scene_test/pairName.txt
WD=/home/hadoop/data/data/yq/output_data/undistorted_images
#WD=/home/hadoop/data/data/yq/output_data_25726/undistorted_images

case "$1" in
  "-f")FILTER=true;;
  "-d")DEBUG=true;;
  *);;
esac

cd ${BIN}
if  [ "${FILTER}" == false ];then
if [ "${DEBUG}" == false ];then
./RefineMesh ${INPUT_MVS} --scales 2 -w ${WD} >> ${HOME}scripts/out.log
else
gdb --args RefineMesh ${RAW_MVS} --scales 2 -w ${WD}
fi
else
./ViewFilter ${RAW_MVS} -w ${WD} -f ${FILTER_FILE} 
#gdb --args ViewFilter ${INPUT_MVS} -w ${WD} -f ${FILTER_FILE} 
fi
cd ${HOME}
