from nanomsg cimport *

from libc.stdlib cimport malloc, free
from cpython cimport PyString_FromStringAndSize, PyString_Size, \
    PyString_AsString

class SPError(Exception):
    pass

cdef class Domain:
    cdef int handle
    cdef int max_sockets
    cdef int n
    cdef object _sockets

    def __cinit__(self, domain_type):
        self.handle = domain_type

        self.n = 0
        self._sockets = []
        self.max_sockets = 128

    def socket(self, protocol):
        return Socket(self, protocol)

    def _add_socket(self, handle):
        self._sockets.append(handle)

    def __dealloc__(self):
        for socket in self._sockets:
            nn_close(socket)

cdef class Socket:
    cdef int handle
    cdef Domain domain
    cdef int protocol
    cdef object closed

    def __cinit__(self, Domain domain, int protocol):
        self.domain = domain
        self.protocol = protocol
        self.closed = False

        with nogil:
            self.handle = nn_socket(domain.handle, protocol)
        assert self.handle > -1
        domain._add_socket(self.handle)

    def close(self):
        with nogil:
            rc = nn_close(self.handle)
        self.closed = True

    def bind(self, char* addr):
        with nogil:
            rc = nn_bind(self.handle, addr)
        assert rc > 0
        return rc

    def connect(self, char* addr):
        with nogil:
            rc = nn_connect(self.handle, addr)
        assert rc > -1

    def shutdown(self, int cid):
        with nogil:
            rc = nn_shutdown(self.handle, cid)
        assert rc == 0

    cpdef setsockopt(self, int level, int option, int optval):
        # all current options are of type int, so only support that
        cdef size_t optlen = sizeof(optval)
        with nogil:
            rc = nn_setsockopt(self.handle, level, option, &optval, optlen)

    cpdef getsockopt(self, int option, int flags):
        raise NotImplementedError

    cpdef send(self, str msg, int flags=0):
        cdef char *buf = PyString_AsString(msg)
        cdef size_t length = PyString_Size(msg)
        with nogil:
            rc = nn_send(self.handle, <void*>buf, length, flags)
        assert rc == length

    cpdef recv(self, size_t length, int flags=0):
        cdef char* buf = <char*>malloc(sizeof(char) * length)
        try:
            with nogil:
                rc = nn_recv(self.handle, buf, length, flags);
            assert rc > -1
            msg = PyString_FromStringAndSize(buf, rc)
            return msg
        finally:
            free(buf)

    def __dealloc__(self):
        if not self.closed:
            rc = nn_close(self.handle)
        #assert rc == 0

__all__ = [ 'Domain', 'Socket' ]
