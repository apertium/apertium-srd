###############################################################################
## Makefile for apertium-srd
###############################################################################

LANG1=srd
BASENAME=apertium-$(LANG1)

VAR1=#deixar en blanc
VAR2=_meridional


TARGETS_COMMON =			\
	$(LANG1).automorf.bin		\
	$(LANG1).automorf.att.gz	\
	$(LANG1)$(VAR1).autogen.bin		\
	$(LANG1)$(VAR2).autogen.bin		\
	$(LANG1).autogen.att.gz		\
	$(LANG1).autopgen.bin		\
	$(LANG1).rlx.bin

# Use this goal for creating .deps, otherwise make -j2 will give problems:
@ap_include@

###############################################################################
## Sardinian transducer
###############################################################################

.deps/$(BASENAME).$(LANG1).srd.dix: $(BASENAME).$(LANG1).dix .deps/.d
	apertium-validate-dictionary $<
	apertium-genvdix sep $< >$@

.deps/$(BASENAME).$(LANG1).srd_meridional.dix: $(BASENAME).$(LANG1).dix .deps/.d
	apertium-validate-dictionary $<
	apertium-genvdix mer $< >$@

$(LANG1)$(VAR1).autogen.bin: .deps/$(BASENAME).$(LANG1).srd.dix
	apertium-validate-dictionary $<
	lt-comp -v sep rl $< $@ $(BASENAME).$(LANG1).acx

$(LANG1)$(VAR2).autogen.bin: .deps/$(BASENAME).$(LANG1).srd_meridional.dix 
	apertium-validate-dictionary $<
	lt-comp -v mer rl $< $@ $(BASENAME).$(LANG1).acx

$(LANG1).automorf.bin: $(BASENAME).$(LANG1).dix
	apertium-validate-dictionary $<
	lt-comp lr $< $@ $(BASENAME).$(LANG1).acx

$(LANG1).autogen.att.gz: $(LANG1).autogen.bin
	lt-print $< | gzip -n -9 -c > $@

$(LANG1).automorf.att.gz: $(LANG1).automorf.bin
	lt-print $< | gzip -n -9 -c > $@

$(LANG1).autopgen.bin: $(BASENAME).post-$(LANG1).dix
	lt-comp lr $< $@

###############################################################################
## Disambiguation rules
###############################################################################

$(LANG1).rlx.bin: $(BASENAME).$(LANG1).rlx
	cg-comp $< $@

###############################################################################
## Distribution
###############################################################################
EXTRA_DIST=$(BASENAME).$(LANG1).dix		\
		$(BASENAME).$(LANG1).acx	\
		$(BASENAME).$(LANG1).rlx	\
		$(BASENAME).post-$(LANG1).dix	\
		$(LANG1).prob			\
		modes.xml

###############################################################################
## Installation stuff
###############################################################################
#
#   apertium_srd_dir: This is where the compiled binaries go
#   apertium_srd_srcdir: This is where the source files go

apertium_srddir=$(prefix)/share/apertium/$(BASENAME)/

apertium_srd_DATA=$(TARGETS_COMMON) $(LANG1).prob \
	$(BASENAME).$(LANG1).dix \
	$(BASENAME).$(LANG1).rlx \
	$(BASENAME).post-$(LANG1).dix

pkgconfigdir = $(prefix)/share/pkgconfig
pkgconfig_DATA = $(BASENAME).pc

noinst_DATA=modes/$(LANG1)-morph.mode

install-data-local: install-modes

CLEANFILES = $(TARGETS_COMMON)
clean-local:
	-rm -rf .deps modes

###############################################################################
## Test
###############################################################################

test: all
	apertium-regtest test
