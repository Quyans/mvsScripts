# 我的脚本
#SCRIPT=/home/qys/Documents/git_clone/openMVS_orig/openMVS/build/bin

SCRIPT=/home/qys/Documents/git_clone/myOpenMVS/mvsbuild/bin
# 原本的脚本
#SCRIPT=/home/qys/Documents/git_clone/openMVS/build/bin
MVS=/home/qys/Documents/out_MVSTexture
WORK_DIR=/home/qys/Documents/graduate_code/testMVS/TJLGout
imgs=/home/qys/Documents/graduate_code/testMVS/TJLGImgs

cd ${SCRIPT}

./TextureMesh --export-type obj -i ${WORK_DIR}/scene_dense_mesh_refine.mvs -w ${imgs} -o ${WORK_DIR}/texture
#sudo gdb --args ./TextureMesh --export-type obj -i  ${MVS}/scene_dense_mesh_refine.mvs -w ${WORK_DIR}
#sudo gdb --args TextureMesh -i ${MVS}/scene_dense_mesh_refine.mvs -w ${WORK_DIR}
