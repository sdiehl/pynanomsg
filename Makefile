_SRCS= constants.pyx nanomsg.pxd socket.pyx
SRCS=$(addprefix pynanomsg/,$(_SRCS))

build: $(SRCS)
	python setup.py build_ext --inplace

test:
	python -munittest discover -s pynanomsg/tests

clean:
	rm -f pynanomsg/*.pyc
	rm -f pynanomsg/tests/*.pyc
	rm -f pynanomsg/*.c
	rm -f pynanomsg/*.so
	rm -rf build

