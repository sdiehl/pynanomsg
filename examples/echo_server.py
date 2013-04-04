from pynanomsg import *

ADDRESS = "tcp://127.0.0.1:5556"

dom = Domain(AF_SP)
rep = dom.socket(REP)

echo = ""
while echo != "EXIT":
    cid = rep.bind(ADDRESS)
    echo = rep.recv(32) # TODO use NN_MSG
    print "GOT: %s" % echo
    rep.send(echo)
    rep.shutdown(cid)
