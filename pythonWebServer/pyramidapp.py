from wsgiref.simple_server import make_server
from pyramid.config import Configurator
from pyramid.response import Response


def hello_world(request):
    return Response('Hello %(name)s!' % request.matchdict)
	
def click(request):
    return Response('click on  %(x) and %(y)!' % request.matchdict)

if __name__ == '__main__':
    with Configurator() as config:
        config.add_route('hello', '/hello/{name}')
        config.add_view(hello_world, route_name='hello')
        config.add_route('click', '/xy/{x}/{y}')
        config.add_view(click, route_name='click')
        app = config.make_wsgi_app()
    server = make_server('0.0.0.0', 8080, app)
    server.serve_forever()