cimport nanomsg

cdef int sym_val = 0
cdef char *c_sym_name
cdef bytes sym_name
vs = vars()
i = 0
while True:
    c_sym_name = <char *> nanomsg.nn_symbol(i,&sym_val)
    if not c_sym_name: break
    sym_name = <bytes> c_sym_name
    if sym_name[0:3] == "NN_": sym_name = sym_name[3:]
    vs[sym_name] = sym_val
    i = i+1
