cdef extern from "nanomsg/nn.h" nogil:

    enum: AF_SP

    int nn_errno ()
    const char *nn_strerror (int errnum)
    const char* nn_symbol (int i, int *value)
    void nn_term ()

    void *nn_allocmsg (size_t size, int type)
    int nn_freemsg (void *msg)

    int nn_socket (int domain, int protocol)
    int nn_close (int s)
    int nn_setsockopt (int s, int level, int option, const void *optval, size_t optvallen)
    int nn_getsockopt (int s, int level, int option, void *optval, size_t *optvallen)
    int nn_bind (int s, const char *addr)
    int nn_connect (int s, const char *addr)
    int nn_shutdown (int s, int how)
    int nn_send (int s, const void *buf, size_t len, int flags)
    int nn_recv (int s, void *buf, size_t len, int flags)

    int nn_device (int s1, int s2)
