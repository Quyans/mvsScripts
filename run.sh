# 我的脚本
#SCRIPT=/home/qys/Documents/git_clone/openMVS_orig/openMVS/build/bin

SCRIPT=/home/qys/Documents/git_clone/myOpenMVS/mvsbuild/bin
# 原本的脚本
#SCRIPT=/home/qys/Documents/git_clone/openMVS/build/bin
MVS=/home/qys/Documents/out_MVSTexture
WORK_DIR=/home/qys/Documents/out_MVSTexture

cd ${SCRIPT}

#./TextureMesh --export-type obj ${MVS}/scene_dense_mesh_refine.mvs -w ${WORK_DIR}
sudo gdb --args ./TextureMesh --export-type obj -i  ${MVS}/scene_dense_mesh_refine.mvs -w ${WORK_DIR}
#sudo gdb --args TextureMesh -i ${MVS}/scene_dense_mesh_refine.mvs -w ${WORK_DIR}
