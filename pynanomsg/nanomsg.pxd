cdef extern from "sp/sp.h" nogil:
    enum: AF_SP # 1
    enum: AF_SP_RAW # 2

    #  Socket protocols.
    enum: SP_PAIR # 1
    enum: SP_PUB  # 2
    enum: SP_SUB  # 3
    enum: SP_REP  # 4
    enum: SP_REQ  # 5

    #  Socket option levels.
    enum: SP_SOL_SOCKET # 1

    # Send/recv options.
    enum: SP_DONTWAIT # 1

    # Socket options
    enum: SP_SUBSCRIBE   # 1
    enum: SP_UNSUBSCRIBE # 2
    enum: SP_RESEND_IVL  # 3


    int sp_init()
    int sp_term()

    int sp_socket (int domain, int protocol)
    int sp_bind (int s, char *addr)
    int sp_close (int s)

    int sp_connect (int s, char *addr)
    int sp_shutdown (int s, int how)
    int sp_send (int s, void *buf, size_t len, int flags)
    int sp_recv (int s, void *buf, size_t len, int flags)

    int sp_setsockopt (int s, int level, int option, void *optval,
            size_t optvallen)
    int sp_getsockopt (int s, int level, int option, void *optval,
        size_t *optvallen)
