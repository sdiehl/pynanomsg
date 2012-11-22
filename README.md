pynanomsg
=========

Nanomessaging is a project to help with building scalable and high performance
distributed applications.

pynanomsg is a the Python to nanomsg written in Cython.


```python
dom = Domain(AF_SP)
sock_a = dom.socket(REQ)
sock_a.bind('inproc://a')

sock_b = dom.socket(REP)
sock_b.connect('inproc://a')

msg = 'ABC'
sock_a.send(msg)
```
