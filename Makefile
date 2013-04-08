_SRCS= constants.pyx nanomsg.pxd socket.pyx
SRCS=$(addprefix pynanomsg/,$(_SRCS))

PYTHON=python

build: $(SRCS)
	$(PYTHON) setup.py build_ext --inplace

test:
	$(PYTHON) -munittest discover -s pynanomsg/tests

install:
	$(PYTHON) setup.py install

clean:
	rm -f pynanomsg/*.pyc
	rm -f pynanomsg/tests/*.pyc
	rm -f pynanomsg/*.c
	rm -f pynanomsg/*.so
	rm -rf build
