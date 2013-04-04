from pynanomsg import *
from time import sleep
import unittest

class TestReqRep(unittest.TestCase):

    def test_reqrep(self):
        dom = Domain(AF_SP)
        sock_a = dom.socket(REQ)
        sock_a.connect('inproc://a')

        sock_b = dom.socket(REP)
        sock_b.bind('inproc://a')

        msg = 'ABC'
        sock_a.send(msg)
        assert sock_b.recv(3) == msg

        sock_a.close()
        sock_b.close()

class TestPair(unittest.TestCase):

    def test_pair(self):
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

class TestPubSub(unittest.TestCase):

    def test_pubsub(self):
        dom = Domain(AF_SP)
        sock_a = dom.socket(PUB)
        sock_a.bind('inproc://a')

        sock_b = dom.socket(SUB)
        sock_b.connect('inproc://a')
        sock_b.setsockopt(SUB, SUB_SUBSCRIBE, "");

        msg = 'ABC'
        sock_a.send(msg)
        sleep(1)
        assert sock_b.recv(3) == msg

if __name__ == '__main__':
    unittest.main()
