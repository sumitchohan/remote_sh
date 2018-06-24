import numpy as np
import cv2
from matplotlib import pyplot as plt
import datetime
from wsgiref.simple_server import make_server
from pyramid.config import Configurator
from pyramid.response import Response

# Initiate SIFT detector
sift = cv2.xfeatures2d.SIFT_create()
f = open('source.txt', "r")
lines = list(f)
dictSourcedes={}
for line in lines:
    print(line)
    parts=line.split(',')
    print(parts[0])    
    print(parts[1])
    img1 = cv2.imread(parts[1],0)          # queryImage
    # find the keypoints and descriptors with SIFT
    kp1, des1 = sift.detectAndCompute(img1,None)
    dictSourcedes[parts[0]]=des1
    print(len(des1))       


print (datetime.datetime.now().strftime("%H:%M:%S.%f"))



def click(request):
    x = request.matchdict.get('x', -1)
    print (x)
    y = request.matchdict.get('y', -1)
    print (y) 
    return Response('click!' % request.matchdict) 


def findObject(request):
    src = request.matchdict.get('src', -1)
    print (src)
    target = request.matchdict.get('target', -1)
    print (target) 
    img2 = cv2.imread(target,0) # trainImage - target = box_in_scene.png
    kp2, des2 = sift.detectAndCompute(img2,None)
    
    FLANN_INDEX_KDTREE = 0
    index_params = dict(algorithm = FLANN_INDEX_KDTREE, trees = 5)
    search_params = dict(checks = 50)

    flann = cv2.FlannBasedMatcher(index_params, search_params)
    
    matches = flann.knnMatch(dictSourcedes[src],des2,k=2)
    minMatchCount=len(dictSourcedes[src])/40
    print('min match count - ' + repr(minMatchCount))
    # store all the good matches as per Lowe's ratio test.
    good = []
    x=0
    y=0
    found = 'n'
    for m,n in matches:
    	if m.distance < 0.7*n.distance:
    		good.append(m) 
    print('good matches - '+repr(len(good)))
    if len(good)>minMatchCount: 
    	dst_pts = np.float32([ kp2[m.trainIdx].pt for m in good ]).reshape(-1,1,2)
    	print (datetime.datetime.now().strftime("%H:%M:%S.%f"))
    	print (len(dst_pts))
    	sums=dst_pts.sum(axis=0)
    	x=sums[0][0]/len(dst_pts)
    	y=sums[0][1]/len(dst_pts)
    	print(x)
    	print(y)  
    	found = 'y'
    else:
    	print ("Not enough matches are found - %d/%d" % (len(good),minMatchCount))
    return Response(found+'_'+repr(x)+','+repr(y)) 

if __name__ == '__main__':
    with Configurator() as config:
        config.add_route('click', '/click/{x}/{y}')
        config.add_view(click, route_name='click') 
        config.add_route('findObject', '/findObject/{src}/{target}')
        config.add_view(findObject, route_name='findObject') 
        app = config.make_wsgi_app()
    server = make_server('0.0.0.0', 8911, app)
    server.serve_forever()
