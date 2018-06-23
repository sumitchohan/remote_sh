import numpy as np
import cv2
from matplotlib import pyplot as plt
import datetime

MIN_MATCH_COUNT = 10
# Initiate SIFT detector
sift = cv2.xfeatures2d.SIFT_create()
f = open('source.txt', "r")
lines = list(f)
dictSourcedes={}
for line in lines:
    print(line)
    parts=line.split(',')
    print(parts[0])    
    img1 = cv2.imread(parts[1],0)          # queryImage
    # find the keypoints and descriptors with SIFT
    kp1, des1 = sift.detectAndCompute(img1,None)
    dictSourcedes[parts[0]]=des1
    print(len(des1))       


print (datetime.datetime.now().strftime("%H:%M:%S.%f"))

img2 = cv2.imread('box_in_scene.png',0) # trainImage
kp2, des2 = sift.detectAndCompute(img2,None)

FLANN_INDEX_KDTREE = 0
index_params = dict(algorithm = FLANN_INDEX_KDTREE, trees = 5)
search_params = dict(checks = 50)

flann = cv2.FlannBasedMatcher(index_params, search_params)

matches = flann.knnMatch(dictSourcedes['src1'],des2,k=2)

# store all the good matches as per Lowe's ratio test.
good = []
for m,n in matches:
    if m.distance < 0.7*n.distance:
        good.append(m) 
print('good matches - '+repr(len(good)))
if len(good)>MIN_MATCH_COUNT: 
    dst_pts = np.float32([ kp2[m.trainIdx].pt for m in good ]).reshape(-1,1,2)
    print (datetime.datetime.now().strftime("%H:%M:%S.%f"))
    print (len(dst_pts))
    sums=dst_pts.sum(axis=0)
    x=sums[0][0]/len(dst_pts)
    y=sums[0][1]/len(dst_pts)
    print(x)
    print(y)  
else:
    print ("Not enough matches are found - %d/%d" % (len(good),MIN_MATCH_COUNT))
