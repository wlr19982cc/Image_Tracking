# -*- coding: UTF-8 -*-
import os
import cv2
import time
 
# 图片合成视频
def picvideo(size):
 
    # fps(帧率)：1秒钟有n张图片写进去
    fps = 30

    # 导出路径
    file_path = "E:/track/track_4.mp4"  

    # 不同视频编码对应不同视频格式
    fourcc = cv2.VideoWriter_fourcc('m', 'p', '4', 'v') 

    video = cv2.VideoWriter(file_path, fourcc, fps, size)
    num = 0

    while(num<=2000):
        item = "E:/track/4/image" + str(num) + ".png"
        img = cv2.imread(item)  
        video.write(img)        # 把图片写进视频
        num += 1
 
    video.release() #释放
 
picvideo((640,360))
