# 我的脚本
#SCRIPT=/home/qys/Documents/git_clone/openMVS_orig/openMVS/build/bin

SCRIPT=/home/qys/Documents/git_clone/myOpenMVS/mvsbuild/bin
# 原本的脚本
#SCRIPT=/home/qys/Documents/git_clone/openMVS/build/bin
MVS=/home/qys/Documents/out_MVSTexture
WORK_DIR=/home/qys/Documents/graduate_code/testMVS/TJLGout
imgs=/home/qys/Documents/graduate_code/testMVS/TJLGImgs

cd ${WORK_DIR}

openMVG_main_SfMInit_ImageListing -i ${imgs} -d /home/qys/Documents/git_clone/openMVG/src/openMVG/exif/sensor_width_database/sensor_width_camera_database.txt -o ${WORK_DIR}

openMVG_main_ComputeFeatures -i ${WORK_DIR}/sfm_data.json -o ${WORK_DIR}

openMVG_main_ComputeMatches -i ${WORK_DIR}/sfm_data.json -o ${WORK_DIR}

openMVG_main_IncrementalSfM -i ${WORK_DIR}/sfm_data.json -m ${WORK_DIR} -o ${WORK_DIR}/reconstruction

openMVG_main_ComputeSfM_DataColor -i ${WORK_DIR}/reconstruction/sfm_data.bin -o ${WORK_DIR}/colored.ply

openMVG_main_ComputeStructureFromKnownPoses -i ${WORK_DIR}/reconstruction/sfm_data.bin -m ${WORK_DIR} -o ${WORK_DIR}/reconstruction/robust.bin -f ${WORK_DIR}/matches.f.bin

openMVG_main_openMVG2openMVS -i ${WORK_DIR}/reconstruction/robust.bin -o scene.mvs

${SCRIPT}/DensifyPointCloud scene.mvs
${SCRIPT}/ReconstructMesh -d 4 scene_dense.mvs
${SCRIPT}/RefineMesh --resolution-level=4 scene_dense_mesh.mvs



#./TextureMesh --export-type obj ${MVS}/scene_dense_mesh_refine.mvs -w ${WORK_DIR}
#sudo gdb --args ./TextureMesh --export-type obj -i  ${MVS}/scene_dense_mesh_refine.mvs -w ${WORK_DIR}
#sudo gdb --args TextureMesh -i ${MVS}/scene_dense_mesh_refine.mvs -w ${WORK_DIR}
