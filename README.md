pynanomsg
=========

Nanomessaging is a project to help with building scalable and high performance
distributed applications.

pynanomsg is the Python binding to nanomsg written in Cython.

Requirements
------------

Build and install nanomsg from source: https://github.com/250bpm/nanomsg

Then install the Cython dependencies if not already installed:

```bash
$ pip install -r requirements.txt
```

Example
-------

```python
from pynanomsg import *

dom = Domain(AF_SP)

sock_b = dom.socket(REP)
sock_b.bind('inproc://a')

sock_a = dom.socket(REQ)
sock_a.connect('inproc://a')

msg = 'ABC'
sock_a.send(msg)
sock_b.recv(3)
```

License
-------

Released under the MIT license.

This library and nanomsg are very early projects. They may cause bad
things to happen ( segfaults, rising of the undead, etc ) for which I am
not responsible.
