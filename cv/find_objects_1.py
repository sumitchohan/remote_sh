import numpy as np
import cv2
from matplotlib import pyplot as plt
import datetime
from wsgiref.simple_server import make_server
from pyramid.config import Configurator
from pyramid.response import Response

# Initiate SIFT detector
sift = cv2.xfeatures2d.SIFT_create()
# f = open('source.txt', "r")
# lines = list(f)
# dictSourcedes={}
# for line in lines:
#     print(line)
#     parts=line.split(',')
#     print(parts[0])    
#     print(parts[1])
#     img1 = cv2.imread(parts[1],0)          # queryImage
#     # find the keypoints and descriptors with SIFT
#     kp1, des1 = sift.detectAndCompute(img1,None)
#     dictSourcedes[parts[0]]=des1
#     print(len(des1))       

imgth10 = cv2.imread('th10.png',0)
kpth10, desth10 = sift.detectAndCompute(imgth10,None)
imgth9 = cv2.imread('th9.png',0)
kpth9, desth9 = sift.detectAndCompute(imgth9,None)
imgth11 = cv2.imread('th11.png',0)
kpth11, desth11 = sift.detectAndCompute(imgth11,None)
imgarcher = cv2.imread('archer.png',0)
kparcher, desarcher = sift.detectAndCompute(imgarcher,None)
imgbarb = cv2.imread('barb.png',0)
kpbarb, desbarb = sift.detectAndCompute(imgbarb,None)
imgea1 = cv2.imread('ea1.png',0)
kpea1, desea1 = sift.detectAndCompute(imgea1,None)
imggiant = cv2.imread('giant.png',0)
kpgiant, desgiant = sift.detectAndCompute(imggiant,None)
imggoblin = cv2.imread('goblin.png',0)
kpgoblin, desgoblin = sift.detectAndCompute(imggoblin,None)
imgit1 = cv2.imread('it1.png',0)
kpit1, desit1 = sift.detectAndCompute(imgit1,None)
imgking = cv2.imread('king.png',0)
kpking, desking = sift.detectAndCompute(imgking,None)
imglava = cv2.imread('lava.png',0)
kplava, deslava = sift.detectAndCompute(imglava,None)
imgloon = cv2.imread('loon.png',0)
kploon, desloon = sift.detectAndCompute(imgloon,None)
imgminion = cv2.imread('minion.png',0)
kpminion, desminion = sift.detectAndCompute(imgminion,None)
imgqueen = cv2.imread('queen.png',0)
kpqueen, desqueen = sift.detectAndCompute(imgqueen,None)
imgrage = cv2.imread('rage.png',0)
kprage, desrage = sift.detectAndCompute(imgrage,None)
imgwallbreaker = cv2.imread('wallbreaker.png',0)
kpwallbreaker, deswallbreaker = sift.detectAndCompute(imgwallbreaker,None)
imgwarden = cv2.imread('warden.png',0)
kpwarden, deswarden = sift.detectAndCompute(imgwarden,None)
imgxb1 = cv2.imread('xb1.png',0)
kpxb1, desxb1 = sift.detectAndCompute(imgxb1,None)
imgit2 = cv2.imread('it2.png',0)
kpit2, desit2 = sift.detectAndCompute(imgit2,None)
imgcc = cv2.imread('cc.png',0)
kpcc, descc = sift.detectAndCompute(imgcc,None)
print('loaded all source images')

def click(request):
    x = request.matchdict.get('x', -1)
    print (x)
    y = request.matchdict.get('y', -1)
    print (y) 
    return Response('click!' % request.matchdict) 


def findObject(request):
    src = request.matchdict.get('src', -1)

    if src=='archer':
        des = desarcher
    elif src=='barb':
        des = desbarb
    elif src=='ea1':
        des = desea1
    elif src=='giant':
        des = desgiant
    elif src=='goblin':
        des = desgoblin
    elif src=='it1':
        des = desit1
    elif src=='king':
        des = desking
    elif src=='lava':
        des = deslava
    elif src=='loon':
        des = desloon
    elif src=='minion':
        des = desminion
    elif src=='queen':
        des = desqueen
    elif src=='rage':
        des = desrage
    elif src=='wallbreaker':
        des = deswallbreaker
    elif src=='warden':
        des = deswarden
    elif src=='xb1':
        des = desxb1
    elif src=='it2':
        des = desit2
    elif src=='th10':
        des = desth10
    elif src=='th11':
        des = desth11
    elif src=='th9':
        des = desth9
    elif src=='cc':
        des = descc

    print (src)
    target = request.matchdict.get('target', -1) 
    img2 = cv2.imread(target,0) # trainImage - target = box_in_scene.png
    kp2, des2 = sift.detectAndCompute(img2,None)
    
    FLANN_INDEX_KDTREE = 0
    index_params = dict(algorithm = FLANN_INDEX_KDTREE, trees = 5)
    search_params = dict(checks = 50)

    flann = cv2.FlannBasedMatcher(index_params, search_params)
    print('here')
    #matches = flann.knnMatch(dictSourcedes[src],des2,k=2)
    matches = flann.knnMatch(des,des2,k=2)
    # minMatchCount=len(dictSourcedes[src])/40
    minMatchCount=len(des)/40
    if src=='th10':
        minMatchCount=2
    print('min match count -  ' + repr(minMatchCount))
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
    server = make_server('0.0.0.0', 8952, app)
    server.serve_forever()
