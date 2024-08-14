# basic makefile

# paths (can also pass via command line)
WINE = # wine path here if not building on Windows natively
MWERKS = # mwcc path here (Wii 1.0; should also have mwld in the same directory)

# targets
.PHONY: help wpad wpadD clean

help:
	@echo 'options:'
	@echo '    wpad                   creates wpad.a (release)'
	@echo '    wpadD                  creates wpadD.a (debug)'
	@echo
	@echo '    build/release/<file>.o compiles <file>.o (release)'
	@echo '    build/debug/<file>.o   compiles <file>.o (debug)'
	@echo
	@echo '    clean                  cleans up build artifacts'

wpad: lib/wpad.a
wpadD: lib/wpadD.a
clean:; -@rm -rf build/ lib/

# system include search directories
export MWCIncludes = include:include/stdlib

# flags
flags_main = -proc gekko -fp hardware -lang c99 -enum int -cpp_exceptions off -cwd include

flags_opt_release = -O4,p -ipa file -DNDEBUG
flags_opt_debug = -opt off -inline off -g

# source files
wpad_src = WPAD.c WPADHIDParser.c WPADEncrypt.c WPADMem.c lint.c WUD.c WUDHidHost.c

# object files
build/release/%.o: source/%.c
ifeq ($(strip ${MWERKS}),)
	$(error MWERKS not set)
else
	@mkdir build/
	@mkdir build/release/
	${WINE} ${MWERKS} ${flags_main} ${flags_opt_release} -o $@ -c $<
endif

build/debug/%.o: source/%.c
ifeq ($(strip ${MWERKS}),)
	$(error MWERKS not set)
else
	@mkdir build/
	@mkdir build/debug/
	${WINE} ${MWERKS} ${flags_main} ${flags_opt_debug} -o $@ -c $<
endif

# library archives
.NOTPARALLEL: lib/wpad.a lib/wpadD.a

lib/wpad.a: $(foreach f,$(basename ${wpad_src}),build/release/$f.o)
ifeq ($(strip ${MWERKS}),)
	$(error MWERKS not set)
else
	@mkdir lib/
	${WINE} ${MWERKS} ${flags_main} ${flags_opt_release} -o $@ -library $^
endif

lib/wpadD.a: $(foreach f,$(basename ${wpad_src}),build/debug/$f.o)
ifeq ($(strip ${MWERKS}),)
	$(error MWERKS not set)
else
	@mkdir lib/
	${WINE} ${MWERKS} ${flags_main} ${flags_opt_debug} -o $@ -library $^
endif
