import socket
import ssl
from urllib.request import Request, urlopen

hostname = 'www.python.org'
context = ssl.create_default_context()

with socket.create_connection((hostname, 443)) as sock:
    with context.wrap_socket(sock, server_hostname=hostname) as ssock:
        print(ssock.version())

with urlopen(Request("https://www.kernel.org/pub/")) as res:
    print(res.status)