from wsgiref.simple_server import make_server
from pyramid.config import Configurator
from pyramid.response import Response
from uiautomator import device as d
import sys
import signal
import random

def click_world(request):
    #d.click(250,250)
    this_id = request.matchdict.get('name', -1)
    print this_id
    this_id1 = request.matchdict.get('name1', -1)
    print this_id1
    return Response('click %(name)s!' % request.matchdict) 

if __name__ == '__main__':
    with Configurator() as config:
        config.add_route('click', '/click/{name}/{name1}')
        config.add_view(click_world, route_name='click')
        app = config.make_wsgi_app()
    server = make_server('0.0.0.0', 8080, app)
    server.serve_forever()
