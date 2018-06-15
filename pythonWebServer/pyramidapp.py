from wsgiref.simple_server import make_server
from pyramid.config import Configurator
from pyramid.response import Response
from uiautomator import device as d
import sys
import signal
import random

def click(request):
    x = request.matchdict.get('x', -1)
    print x
    y = request.matchdict.get('y', -1)
    print y
    d.click(int(float(x)),int(float(y)))	
    return Response('click %(x) %(y)!' % request.matchdict) 
	
def drag(request):
    x = request.matchdict.get('x', -1)
    print x
    y = request.matchdict.get('y', -1)
    print y
    dx = request.matchdict.get('dx', -1)
    print dx
    dy = request.matchdict.get('dy', -1)
    print dy
    n = request.matchdict.get('n', -1)
    print n
    d.drag(int(float(x)),int(float(y)),int(float(dx)),int(float(dy)),steps=int(float(n)))	
    return Response('drag %(x) %(y) %(dx) %(dy) %(n)!' % request.matchdict) 
	
def swipe(request):
    x = request.matchdict.get('x', -1)
    print x
    y = request.matchdict.get('y', -1)
    print y
    dx = request.matchdict.get('dx', -1)
    print dx
    dy = request.matchdict.get('dy', -1)
    print dy
    n = request.matchdict.get('n', -1)
    print n
    d.swipe(int(float(x)),int(float(y)),int(float(dx)),int(float(dy)),steps=int(float(n)))	
    return swipe('drag %(x) %(y) %(dx) %(dy) %(n)!' % request.matchdict) 

if __name__ == '__main__':
    with Configurator() as config:
        config.add_route('click', '/click/{x}/{y}')
        config.add_view(click, route_name='click')
        config.add_route('drag', '/drag/{x}/{y}/{dx}/{dy}/{n}')
        config.add_view(drag, route_name='drag')
        config.add_route('swipe', '/swipe/{x}/{y}/{dx}/{dy}/{n}')
        config.add_view(drag, route_name='swipe')
        app = config.make_wsgi_app()
    server = make_server('0.0.0.0', 8080, app)
    server.serve_forever()
