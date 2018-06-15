from wsgiref.simple_server import make_server
from pyramid.config import Configurator
from pyramid.response import Response
from uiautomator import device as d
import sys
import signal
import random

def click_world(request):
    x = request.matchdict.get('x', -1)
    print x
    y = request.matchdict.get('y', -1)
    print y
    d.click(x,y)	
    return Response('click %(x)s!' % request.matchdict) 

if __name__ == '__main__':
    with Configurator() as config:
        config.add_route('click', '/click/{x}/{y}')
        config.add_view(click_world, route_name='click')
        app = config.make_wsgi_app()
    server = make_server('0.0.0.0', 8080, app)
    server.serve_forever()
