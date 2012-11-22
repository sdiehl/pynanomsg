from pynanomsg import *
from unittest import skip

def test_reqrep():
    dom = Domain(AF_SP)
    sock_a = dom.socket(REQ)
    sock_a.bind('inproc://a')

    sock_b = dom.socket(REP)
    sock_b.connect('inproc://a')

    msg = 'ABC'
    sock_a.send(msg)
    assert sock_b.recv(3) == msg

    sock_a.close()
    sock_b.close()

def test_pair():
    dom = Domain(AF_SP)
    sock_a = dom.socket(PAIR)
    sock_a.bind('inproc://a')

    sock_b = dom.socket(PAIR)
    sock_b.connect('inproc://a')

    msg = 'ABC'
    sock_a.send(msg)
    assert sock_b.recv(3) == msg

    sock_a.close()
    sock_b.close()

def test_pubsub():
    dom = Domain(AF_SP)
    sock_a = dom.socket(PUB)
    sock_a.bind('inproc://a')

    sock_b = dom.socket(SUB)
    sock_b.connect('inproc://a')
    sock_b.setsockopt(SUBSCRIBE, "");

    msg = 'ABC'
    sock_a.send(msg)
    assert sock_b.recv(3) == msg
