from pynanomsg import *
import sys

ADDRESS = "tcp://127.0.0.1:5556"

if len(sys.argv) != 2:
    sys.stderr.write("usage: %s msg\n" % sys.argv[0])
    sys.exit(1)
msg = sys.argv[1]
assert(len(msg) < 32) # TODO use NN_MSG

dom = Domain(AF_SP)
req = dom.socket(REQ)
req.setsockopt(REQ, REQ_RESEND_IVL, 1000)
req.connect(ADDRESS)
req.send(msg)
echo = req.recv(32) # TODO use NN_MSG
assert(echo == msg)
