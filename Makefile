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

ifeq ($(strip ${DEBUG}),0)
	FLAGS_OPTIONS = -O4,p -ipa file -DNDEBUG
	LIBSUFFIX =
else
	FLAGS_OPTIONS = -opt off -inline off -gdwarf-${DEBUG}
	LIBSUFFIX = D
endif

WPAD_LIB = wpad${LIBSUFFIX}.a

.PHONY: wpad
.NOTPARALLEL: ${WPAD_LIB}

wpad: ${WPAD_LIB}
clean:; -@rm -r build/

${WPAD_LIB}: WPAD.o WPADHIDParser.o WPADMem.o WPADEncrypt.o lint.o WUD.o WUDHidHost.o
	${WINE} ${MWERKS} -library -o build/$@ $?

%.o: %.c
	@[ -d build ] || mkdir build
	${WINE} ${MWERKS} -proc gekko -fp hardware -lang c99 -enum int -cwd include -cpp_exceptions off ${FLAGS_OPTIONS} -o build/$@ -c $<

