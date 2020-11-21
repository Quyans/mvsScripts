# from pyspark import SparkConf, SparkContext

#import SceneReconstruct
#import PackScene
import datetime
import threading
import os
import subprocess
import time

def CmdFileGen(scenename, index, slaveIndex):
    f1 = open('/home/hadoop/zzy/sshreconstruct/test.sh', 'w')
    headtext = "#!/bin/bash\n"
    sshhead = "ssh hadoop@slave" + str(slaveIndex) + " << sshoff\n"
    cmdtext = "/home/hadoop/zzy/colmap/build/src/exe/colmap delaunay_mesher " + " --input_path "\
              + basepath + "Colmap_In_" + str(index)  +  "/dense" +  " --output_path " + meshpath + "scene_mesh_" + str(index) + ".ply"  + "\n"
    exittext = "exit\n"
    endtext = "sshoff\n"
    f1.writelines([headtext, sshhead, cmdtext, exittext, endtext] )


#scenepath = "/home/hadoop/zzy/scene/scene1718/"
basepath = "/home/hadoop/data/data/yq/"
#segscenepath = basepath + "Seg/"
scenepath=basepath + "Colmap_In_"
meshpath = basepath + "Mesh/"
emptyscenepath=basepath + "Mesh/"
#imgpath = "/home/hadoop/zzy/scene/scene1718/"
#partexepath="/home/hadoop/zzy/openMVSnew_partion/openMVS_build/bin/ReconstructMesh"
mergeexepath="/home/hadoop/zzy/openMVS_merge/openMVS_build/bin/ReconstructMesh"
segscenenum = 9
executornum = 9
num = int(segscenenum / executornum)
res = int(segscenenum % executornum)

#config = " -d 3"

begintime=time.time()

# make directory

os.popen("mkdir " + meshpath)
for i in range(0, executornum - 1):
    os.popen("ssh slave" + str(i+1) + " rm -r " + meshpath)
    os.popen("ssh slave" + str(i+1) + " mkdir " + meshpath)

#scene = PackScene.PackScene()
#scene.loadScene(scenepath + "scene_dense.mvs")

#scene.SaveMesh(scenepath + "scene_dense_nocompress", 1)
#scene.ReleaseScene()


#SceneReconstruct.segScene(scenepath + "scene_dense.mvs", imgpath, segscenenum)
#succsee=os.system(partexepath)
#os.popen("mv scene_*.mvs " + segscenepath)

#segendtime=time.time()
#segtime=segendtime- begintime
#print("seg time is %0.2f s\n"%segtime)

#for i in range(0, num):
#    for j in range(1, executornum):
#        os.popen("scp " + segscenepath + "scene_" + str(executornum * i + j - 1) + ".mvs" + " hadoop@slave"\
#        + str(j) + ":" + segscenepath)

    
# for i in range(0, res):
#     os.popen("scp " + segscenepath + "scene_" + str(segscenenum - 1 -i) + ".mvs" + " spark@slave1:" + segscenepath)
#     os.popen("scp " + segscenepath + "scene_" + str(segscenenum - 1 -i) + ".mvs" + " spark@slave2:" + segscenepath)



scenenames = []
sceneinfo = []
for i in range(0, segscenenum):
    sceneinfo.append(scenepath + str(i) + "/dense")
    sceneinfo.append(i)
    scenenames.append(sceneinfo)
    sceneinfo = []
    #print scenenames[i]

 
processlist = []

 
for i in range(0, num):

    
       
    if i != 0:
        for j in range(0, executornum ):
            processlist[(i - 1)* (executornum) + j].wait()
            #processlist[(i - 1)* (executornum) + 1].wait()
            #processlist[(i - 1)* (executornum) + 2].wait()
    
    for j in range(1, executornum):
        CmdFileGen(scenenames[i * executornum + j][0], i * executornum + j, j)
        child = subprocess.Popen("/home/hadoop/zzy/sshreconstruct/test.sh",shell = True)
        processlist.append(child)
        time.sleep(5)
              
    child = subprocess.Popen("/home/hadoop/zzy/colmap/build/src/exe/colmap delaunay_mesher " +"--input_path " + scenenames[i  * executornum ][0]\
                     + " --output_path " + meshpath + "scene_mesh_" + str(i * executornum) + ".ply", shell= True)
    #print ("/home/hadoop/zzy/colmap/build/src/exe/colmap delaunay_mesher " +"--inputpath " + scenenames[i  * executornum ][0]\
    #                 + " --output_path " + meshpath + "scene_mesh_" + str(i * executornum) + ".ply")
    processlist.append(child)
    #time.sleep(10)
  
for i in range(0, executornum):
    processlist[(num - 1)* (executornum) + i].wait()

resendtime=time.time()
restime=resendtime- begintime
print("reconstruct mesh time is %0.2f s\n"%restime)

# for i in range(0, res):
#     CmdFileGen(scenenames[segscenenum - 1 - i][0], segscenenum - 1 - i, res - i)
#     child = subprocess.Popen("/home/sparkreconstruct/test.sh",shell = True)
#     processlist.append(child)
#     
# for i in range(0, res):
#     processlist[segscenenum - 1 - i].wait()
 


# merge the scene
for i in range(1, executornum):
    os.popen("scp" + " hadoop@slave" + str(i) + ":" + meshpath + "scene_mesh* " + meshpath )
 
#scene_all = PackScene.PackScene()
#scene_tmp = PackScene.PackScene()
 
#scene_all.loadScene(meshpath + 'scene_mesh_0.mvs');
#for i in range(1, segscenenum):
#    scene_tmp.loadScene(meshpath + 'scene_mesh_' + str(i) + '.mvs');
#    scene_all.AddScene(scene_tmp.scene)

#scene_all.CleanAndSaveMesh(meshpath + "allscene")  
succsee=os.system(mergeexepath + " " + emptyscenepath + " " +meshpath + " " + str(segscenenum))   

mergeendtime=time.time()
mergetime=mergeendtime- resendtime
print("merge time is %0.2f s\n"%mergetime)

endtime=time.time()
runtime=endtime-begintime
print("run time is %0.2f s\n"%runtime)

print "susscesful"
print "----------------------------------------------"
