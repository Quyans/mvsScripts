HOME=/home/hadoop/leedua/
BIN=${HOME}mvsbuild/bin/

INPUT_MVS=/home/hadoop/data/data/1kmMesh/scene_1km.mvs
WD=/home/hadoop/data/data/yq/output_data_25726/undistorted_images

cd ${BIN}
./RefineMesh ${INPUT_MVS} --scales 2 -w ${WD}
 
cd ${HOME}
