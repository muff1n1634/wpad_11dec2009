# basic makefile: creates wpad[D].a

# can also pass via command line
WINE = # wine path here if not building on Windows natively
MWERKS = # mwcc path here (Wii 1.0; should also have mwld in the same directory)

DEBUG ?= 0

ifeq ($(strip ${MWERKS}),)
$(error MWERKS not set)
endif

vpath %.c source
vpath %.o build

export MWCIncludes := include:include/stdlib

ifneq ($(strip ${DEBUG}),0)
	FLAGS = -O4,p -ipa file -DNDEBUG
	LIBSUFFIX =
else
	FLAGS = -opt off -inline off -g
	LIBSUFFIX = D
endif

WPAD_LIB = wpad${LIBSUFFIX}.a

.PHONY: wpad
.NOTPARALLEL: ${WPAD_LIB}

wpad: ${WPAD_LIB}

${WPAD_LIB}: WPAD.o WPADHIDParser.o WPADMem.o WPADEncrypt.o lint.o WUD.o WUDHidHost.o
	${WINE} ${MWERKS} -library -o build/$@ $?

%.o: %.c
	@[ -d build ] || mkdir build
	${WINE} ${MWERKS} -proc gekko -fp hardware -lang c99 -cwd include ${FLAGS} -o build/$@ -c $<

