ACLOCAL_AMFLAGS=-I ac-macros

bin_PROGRAMS = ajhc
JHCPROG = ./$(bin_PROGRAMS)

ajhc_SOURCES = src/Main.hs $(HSFILES) $(BUILT_SOURCES) $(HSBOOT) $(DRIFTFILES)

BUILT_SOURCES= src/RawFiles.hs src/FrontEnd/HsParser.hs src/FlagDump.hs \
	       src/FlagOpts.hs src/Name/Prim.hs src/Info/Properties.hs $(DRIFTFILES)

MY_CINCLUDES= -I$(srcdir)/src/data -I$(srcdir)/src/StringTable -I$(srcdir)/src/cbits -I$(builddir)/src/cbits
MY_CFLAGS= $(MY_CINCLUDES) -optc-std=c99 -optc-O2 -optc-Wall
CC = "$(HC)"

HSFILES=src/C/Generate.hs src/Cmm/Number.hs src/Cmm/OpEval.hs src/DerivingDrift/DataP.hs \
	src/DerivingDrift/Drift.hs src/DerivingDrift/RuleUtils.hs src/Doc/Attr.hs src/Doc/Chars.hs src/Doc/DocLike.hs \
	src/Doc/PPrint.hs src/Doc/Pretty.hs src/E/Annotate.hs src/E/Binary.hs src/E/Diff.hs src/E/E.hs src/E/Eta.hs src/E/Eval.hs \
	src/E/FreeVars.hs src/E/FromHs.hs src/E/Inline.hs src/E/LetFloat.hs src/E/PrimOpt.hs src/E/Program.hs src/E/Rules.hs \
	src/E/Show.hs src/E/Subst.hs src/E/Traverse.hs src/E/TypeAnalysis.hs src/E/Values.hs src/E/WorkerWrapper.hs \
	src/FindFixpoint.hs src/Fixer/Fixer.hs src/Fixer/Supply.hs src/Fixer/VMap.hs src/FlagDump.hs src/FlagOpts.hs \
	src/FrontEnd/DataConsAssump.hs src/FrontEnd/DeclsDepends.hs src/FrontEnd/DependAnalysis.hs src/FrontEnd/Desugar.hs \
	src/FrontEnd/Diagnostic.hs src/FrontEnd/FrontEnd.hs src/FrontEnd/HsErrors.hs src/FrontEnd/HsParser.hs \
	src/FrontEnd/HsPretty.hs src/FrontEnd/Infix.hs src/FrontEnd/Lexer.hs src/FrontEnd/ParseMonad.hs src/FrontEnd/ParseUtils.hs \
	src/FrontEnd/Rename.hs src/FrontEnd/Syn/Options.hs src/FrontEnd/Syn/Traverse.hs src/FrontEnd/Tc/Class.hs src/FrontEnd/Tc/Main.hs \
	src/FrontEnd/Tc/Module.hs src/FrontEnd/Tc/Type.hs src/FrontEnd/Tc/Unify.hs src/FrontEnd/TypeSigs.hs src/FrontEnd/TypeSynonyms.hs\
	src/FrontEnd/TypeSyns.hs src/FrontEnd/Unlit.hs src/FrontEnd/Utils.hs src/FrontEnd/Warning.hs src/GenUtil.hs src/Grin/DeadCode.hs\
	src/Grin/Devolve.hs src/Grin/EvalInline.hs src/Grin/FromE.hs src/Grin/Grin.hs src/Grin/HashConst.hs src/Grin/Lint.hs\
	src/Grin/NodeAnalyze.hs src/Grin/Noodle.hs src/Grin/Optimize.hs src/Grin/Show.hs src/Grin/Val.hs \
	src/Grin/Whiz.hs src/Ho/Binary.hs src/Ho/Collected.hs src/Ho/Library.hs src/Info/Binary.hs src/Info/Info.hs src/Info/Properties.hs \
	src/Info/Types.hs src/Interactive.hs src/Main.hs src/Name/Binary.hs src/Name/Id.hs src/Name/Name.hs src/Name/Names.hs \
	src/Name/Prim.hs src/Options.hs src/PackedString.hs src/Ho/ReadSource.hs \
	src/RawFiles.hs src/Stats.hs src/Support/CanType.hs src/Support/CFF.hs src/Support/Compat.hs \
	src/Support/FreeVars.hs src/Support/MapBinaryInstance.hs src/Support/MD5.hs src/Support/Tickle.hs src/Support/Transform.hs \
	src/Support/Tuple.hs src/Support/Unparse.hs src/Util/BitSet.hs src/Util/ContextMonad.hs src/Util/FilterInput.hs \
	src/Util/Gen.hs src/Util/Graph.hs src/Util/Graphviz.hs src/Util/HasSize.hs src/Util/Histogram.hs src/Util/Inst.hs \
	src/Util/IntBag.hs src/Util/Interact.hs src/Util/NameMonad.hs src/Util/Once.hs src/Util/Perhaps.hs src/Util/ReaderWriter.hs \
	src/Util/Relation.hs src/Util/RWS.hs src/Util/SameShape.hs src/Util/Seq.hs src/Util/SetLike.hs src/Util/UnionFind.hs \
	src/Util/UnionSolve.hs src/Util/UniqueMonad.hs src/Util/Util.hs src/Util/VarName.hs src/Version/Config.hs src/Version/Version.hs \
	src/Support/IniParse.hs src/E/Lint.hs src/Util/Progress.hs src/Grin/StorageAnalysis.hs src/Util/YAML.hs src/Grin/Main.hs \
        src/E/Main.hs src/Util/GMap.hs src/Util/ExitCodes.hs src/Support/TempDir.hs src/E/PrimDecode.hs \
        src/DerivingDrift/StandardRules.hs src/FrontEnd/Exports.hs

GHCDEBUGOPTS= -W -fno-warn-unused-matches  -fwarn-type-defaults
GHCPROFOPTS= -prof -fprof-auto-top -auto-all -osuf prof.o -hisuf prof.hi
GHCSELFTESTOPTS= -osuf test.o -hisuf test.hi -DEXPORT_SELFTEST=,_selftest
GHCNONSELFTESTOPTS= -DEXPORT_SELFTEST=
GHCINC=  -i @GHCINC@ -i$(srcdir)/drift_processed \
	 -i$(srcdir)/src -i$(builddir)/src -odir $(builddir)/src -hidir $(builddir)/src \
	 -I$(srcdir)/src -I$(builddir)/src

PACKAGES= -hide-all-packages -package base -package fgl -package regex-compat -package random -package array -package directory \
          -package bytestring -package binary -package mtl -package containers \
	  -package utf8-string -package zlib -package HsSyck \
	  -package filepath -package process @GHC_UNIX_OR_WIN32@

GHCLANG= -XTypeFamilies -XViewPatterns -XUndecidableInstances -XOverlappingInstances \
	-XRecordWildCards -XRecursiveDo -XTupleSections -XParallelListComp \
	-XGeneralizedNewtypeDeriving -XScopedTypeVariables -XFlexibleInstances \
	-XTypeSynonymInstances -XMultiParamTypeClasses -XDeriveDataTypeable \
	-XNoMonoLocalBinds -XNamedFieldPuns \
	-XForeignFunctionInterface -XUnliftedFFITypes -XImplicitParams -XUnboxedTuples \
	-XStandaloneDeriving -XDeriveFunctor -XDeriveFoldable -XDeriveTraversable -XDeriveGeneric \
	-XFlexibleContexts -XConstrainedClassMethods -XFunctionalDependencies -XMagicHash \
	-XPolymorphicComponents -XExistentialQuantification -XUnicodeSyntax -XPostfixOperators \
	-XPatternGuards -XLiberalTypeSynonyms -XRankNTypes -XTypeOperators \
	-XEmptyDataDecls -XKindSignatures

GHCOPTS= $(HSOPTS) -XBangPatterns -O @GHCFLAGS@ $(GHCDEBUGOPTS) $(GHCINC) $(PACKAGES) $(GHCLANG)

LIB_OPTIONS=$(RTSOPTS) $(JHC_TEST)  -L- -L.
include library_deps.make

EXTRA_DIST = src/data rts utils docs src/FrontEnd/HsParser.y $(BUILT_SOURCES) \
             lib/jhc lib/jhc-prim lib/haskell-extras lib/haskell98 lib/haskell2010 lib/flat-foreign $(JHC_LIBS) $(JHC_EXT_LIBS) \
	     src/StringTable/StringTable_cbits.c src/StringTable/StringTable_cbits.h src/cbits/md5sum.c ajhc.1 \
	     src/StringTable/Atom.hsc ajhc.spec src/cbits/lookup3.c \
	     manual.html manual_ja.html lib/applicative examples/HelloWorld.hs examples/Calendar.hs \
	     examples/Primes.hs src/FlagOpts.flags src/FlagDump.flags lib/ext compat

dist-hook: $(BUILT_SOURCES)
	if test -f .git; then \
		rm -f $(srcdir)/ChangeLog $(srcdir)/src/data/shortchange.txt; \
		$(MAKE) ChangeLog src/data/shortchange.txt src/RawFiles.hs;   \
		cp -f $(srcdir)/ChangeLog $(destdir)/ChangeLog; \
		cp -f $(srcdir)/src/data/shortchange.txt $(destdir)/src/data/shortchange.txt; \
		cp -f $(srcdir)/src/RawFiles.hs $(destdir)/src/RawFiles.hs; \
	fi

all-local: $(JHC_LIBS)

install-data-hook: $(JHC_LIBS) $(JHC_EXT_LIBS)
	$(INSTALL) -d $(DESTDIR)$(datadir)/@PACKAGE@-@SHORTVERSION@
	$(INSTALL) -d $(DESTDIR)$(datadir)/@PACKAGE@-@SHORTVERSION@/include
	$(INSTALL) -d $(DESTDIR)$(sysconfdir)/@PACKAGE@-@SHORTVERSION@
	for lib in $(JHC_LIBS) $(JHC_EXT_LIBS); do \
		test -f "$$lib" && $(INSTALL_DATA) $$lib $(DESTDIR)$(datadir)/@PACKAGE@-@SHORTVERSION@ ; \
		test -f "$(srcdir)/$$lib" && $(INSTALL_DATA) "$(srcdir)/$$lib" $(DESTDIR)$(datadir)/@PACKAGE@-@SHORTVERSION@ ; \
	done
	$(INSTALL_DATA) "$(srcdir)/rts/HsFFI.h" $(DESTDIR)$(datadir)/@PACKAGE@-@SHORTVERSION@/include
	$(INSTALL_DATA) "$(srcdir)/src/data/targets.ini" $(DESTDIR)$(sysconfdir)/@PACKAGE@-@SHORTVERSION@

uninstall-hook:
	rm -f -- "$(DESTDIR)$(bindir)/$(bin_PROGRAMS)i$(EXTEXT)"
	for lib in $(JHC_LIBS) $(JHC_EXT_LIBS); do \
		rm -f -- "$(DESTDIR)$(datadir)/@PACKAGE@-@SHORTVERSION@/$$lib" ; \
	done
	rm -f -- "$(DESTDIR)$(datadir)/@PACKAGE@-@SHORTVERSION@/include/HsFFI.h"
	rm -f -- "$(DESTDIR)$(sysconfdir)/@PACKAGE@-@SHORTVERSION@/targets.ini"
	-rmdir $(DESTDIR)$(datadir)/@PACKAGE@-@SHORTVERSION@/include
	-rmdir $(DESTDIR)$(datadir)/@PACKAGE@-@SHORTVERSION@
	-rmdir $(DESTDIR)$(sysconfdir)/@PACKAGE@-@SHORTVERSION@

UTILS = utils/op_process.prl utils/opt_sets.prl utils/gen_props.prl utils/op_names.prl utils/op_raw.prl

RAWFILES = src/data/ViaGhc.hs src/data/prelude.m4 \
	   src/data/targets.ini rts/rts/constants.h rts/rts/stableptr.c rts/sys/queue.h rts/HsFFI.h \
           rts/sys/wsize.h rts/sys/bitarray.h ChangeLog src/data/shortchange.txt rts/rts/slub.c \
	   rts/rts/gc_jgc.c rts/rts/gc_jgc.h rts/rts/profile.c rts/rts/profile.h rts/rts/cdefs.h rts/rts/rts_support.c \
	   rts/rts/rts_support.h rts/rts/gc.h rts/rts/gc_none.c rts/rts/gc_none.h rts/rts/jhc_rts.c rts/rts/jhc_rts.h \
	   rts/lib/lib_cbits.c rts/jhc_rts_header.h rts/lib/lib_cbits.h rts/rts/gc_jgc_internal.h

DRIFTFILES = drift_processed/C/FFI.hs drift_processed/C/FromGrin2.hs drift_processed/Cmm/Op.hs drift_processed/C/Prims.hs drift_processed/DataConstructors.hs \
   drift_processed/E/CPR.hs drift_processed/E/Demand.hs drift_processed/E/LambdaLift.hs \
   drift_processed/E/SSimplify.hs drift_processed/E/ToHs.hs drift_processed/E/TypeCheck.hs drift_processed/E/Type.hs drift_processed/FrontEnd/Class.hs \
   drift_processed/FrontEnd/HsSyn.hs drift_processed/FrontEnd/KindInfer.hs \
   drift_processed/FrontEnd/Representation.hs drift_processed/FrontEnd/SrcLoc.hs drift_processed/FrontEnd/Tc/Kind.hs \
   drift_processed/FrontEnd/Tc/Monad.hs drift_processed/Grin/SSimplify.hs drift_processed/Name/VConsts.hs drift_processed/Options.hs \
   drift_processed/DataConstructors.hs-boot drift_processed/Ho/Type.hs  drift_processed/Ho/Build.hs

drift_processed/%: src/%
	mkdir -p `echo $@ | sed -e 's@/[^/]*$$@@'`
	$(DRIFTGHC) $< -o $@

CFILES = src/StringTable/StringTable_cbits.o src/cbits/md5sum.o src/cbits/lookup3.o

%.o : %.c
	mkdir -p `echo $@ | sed -e 's@/[^/]*$$@@'`
	"$(HC)" $(MY_CFLAGS) $< -c -o $@

$(bin_PROGRAMS)$(EXEEXT): src/Main.hs  $(HSFILES) $(BUILT_SOURCES) src/StringTable/Atom.hs $(CFILES)
	$(BUILD_STOW) "$(HC)" $(GHCOPTS) --make $< $(CFILES) -o $@

# You can see stacktrace with running "ajhcp Foo.hs +RTS -p -xc".
$(bin_PROGRAMS)p$(EXEEXT): src/Main.hs $(BUILT_SOURCES) $(HSFILES) src/StringTable/Atom.hs $(CFILES)
	"$(HC)" $(GHCOPTS) $(GHCPROFOPTS) --make $< $(CFILES) -o $@

dist_man_MANS = ajhc.1

install-exec-hook:
	cd $(DESTDIR)$(bindir) && $(LN_S) -f $(bin_PROGRAMS)$(EXEEXT) $(bin_PROGRAMS)i$(EXEEXT)

HSBOOT= src/DataConstructors.hs-boot src/FrontEnd/Tc/Class.hs-boot src/Grin/Grin.hs-boot src/Grin/Show.hs-boot src/Info/Binary.hs-boot src/E/Show.hs-boot

# Various rules for generated Haskell files

%.hs: %.hsc
	mkdir -p `echo $@ | sed -e 's@/[^/]*$$@@'`
	"$(HSC2HS)" $(MY_CINCLUDES) -o $@ $<

%.hs: %.flags utils/opt_sets.prl
	perl $(srcdir)/utils/opt_sets.prl -n $< $< > $@

%.mkd: %.flags utils/opt_sets.prl
	perl $(srcdir)/utils/opt_sets.prl -f f -m -n $< $< > $@

src/Info/Properties.hs: src/data/props.txt utils/gen_props.prl
	perl $(srcdir)/utils/gen_props.prl $< > $@ || rm -f $@

src/Name/Prim.hs: utils/op_names.prl src/data/names.txt
	perl $< > $@ || rm -f $@

src/RawFiles.hs: $(RAWFILES)
	perl $(srcdir)/utils/op_raw.prl $(basename $@) $^ > $@

src/FrontEnd/HsParser.hs: src/FrontEnd/HsParser.y
	happy -a -g -c $< -o $@

.SECONDARY: src/data/shortchange.txt

ChangeLog:
	git log fork-jhc-0.8.0-darcs20120314.. > $@

src/data/shortchange.txt: ChangeLog
	echo -n "`head -1 $< | sed -ne 's/^commit \(.*\)/\1/p'`"  > $@

BINDISTDIR=$(PACKAGE)-$(VERSION)-$(host)

bin-dist: $(bin_PROGRAMS)$(EXEEXT)
	rm -rf -- $(BINDISTDIR)
	mkdir $(BINDISTDIR)
	strip -- $(bin_PROGRAMS)$(EXEEXT) || true
	cp -- $(bin_PROGRAMS)$(EXEEXT) $(BINDISTDIR)
	tar cvf $(BINDISTDIR).tar $(BINDISTDIR)
	gzip -f -- $(BINDISTDIR).tar
	rm -rf -- $(BINDISTDIR)

cabal-dist: src/Main.hs  $(HSFILES) $(BUILT_SOURCES) src/StringTable/Atom.hs $(CFILES)
	runhaskell Setup.hs sdist

cabal-install: src/Main.hs  $(HSFILES) $(BUILT_SOURCES) src/StringTable/Atom.hs $(CFILES)
	cabal install

.INTERMEDIATE: deps.txt ajhc_man.mkd options.mkd
.DELETE_ON_ERROR: deps.txt depend.make ChangeLog data/shortchange.txt manual.mkd ajhc_man.mkd options.mkd

deps.txt:
	$(MAKE) $(AM_MAKEFLAGS) $(BUILT_SOURCES)
	"$(HC)" -M -optdep-f -optdep$@ $(GHCOPTS) src/Main.hs

depend.make: deps.txt
	echo HSFILES=`egrep -o '[A-Za-z0-9/._]+.hs' $< | sed -e 's/^\.\///' | sort | uniq` > depend.make

built-sources: $(BUILT_SOURCES)

i: $(BUILT_SOURCES)
	"$(HC)" --interactive $(GHCOPTS) src/Main.hs $(CFILES)

i2: $(BUILT_SOURCES)
	"$(HC)" --interactive $(GHCOPTS)  $(CFILES)

lint:
	perl utils/hslint.prl `darcs wh -s | sed -e 's/^..//' -e 's/ .*$$//' | grep '.hs$$'`
hlint:
	hlint `darcs wh -s | sed -e 's/^..//' -e 's/ .*$$//' | grep '.hs$$'`

.PHONY: ho-clean hl-clean built-sources i manual man manual_ja

ho-clean:
	rm -f -- `find -name \*.ho -print`
	rm -f -- `find ~/.ajhc/cache -name \*.ho -print`
hl-clean:
	rm -f -- `find -name \*.hl -print`

clean-local:
	find . \( \! -path \*/_\* \( -name \*.o-boot -o -name \*.hi -o -name \*.o -o -name \*.hi-boot \) \) -print | xargs rm -f --
	rm -rf dist drift_processed tmp autom4te.cache

MAINTAINERCLEANFILES= $(BUILT_SOURCES) $(DRIFTFILES)

CLEANFILES= $(JHC_LIBS) $(JHC_EXT_LIBS) HelloWorld Primes src/StringTable/Atom.hs src/RawFiles.hs
CLEANFILES+= ajhc.spec manual.html manual.mkd manual_ja.html manual_ja.mkd docs/building.mkd src/FlagDump.mkd src/FlagOpts.mkd
CLEANFILES+= ac-macros/install-sh ac-macros/missing src/data/shortchange.txt
CLEANFILES+= src/FlagDump.hs src/FlagOpts.hs src/FrontEnd/HsParser.hs src/Info/Properties.hs src/Name/Prim.hs

%.pdf: %.ps
	epstopdf $< --outfile $@

%.ps : %.dot
	dot $< -Tps -o$@

%.pdf : %.dot
	dot $< -Tpdf -o$@

#%.html: %.mkd
#	pandoc $< -s -f markdown -t html -o $@

%.shtml: %.mkd
	cat $(srcdir)/docs/template/my_header.shtml > $@
	pandoc $< -f markdown -t html >> $@
	cat $(srcdir)/docs/template/my_footer.shtml >> $@

publish: docs/building.shtml docs/big-picture.pdf docs/development.shtml docs/index.shtml docs/ajhc.shtml manual.html docs/manual.css
	cp -- $^ /home/john/public_html/computer/ajhc

publish_ajhc: manual.html manual_ja.html docs/manual.css
	cp -- $^ /home/kiwamu/doc/ajhc.github.com/

manual.mkd: $(JHC_MANUAL_FILES)
	perl $(srcdir)/utils/stitch.prl $^ > $@

manual: manual.mkd
	pandoc $< --toc -s -f markdown -t html -s -c manual.css -o $@.html

updatepo: manual.mkd
	po4a-updatepo -M utf8 -f text -m manual.mkd -p po/ja.po

manual_ja.mkd: manual.mkd po/ja.po
	po4a-translate -M utf8 -f text -m manual.mkd -p po/ja.po -l manual_ja.mkd

manual_ja: manual_ja.mkd
	pandoc $< --toc -s -f markdown -t html -s -c manual.css -o $@.html

$(firstword $(JHC_MANUAL_FILES)): utils/stitch.prl docs/man_header.mkd
	touch $@

ajhc_man.mkd: $(JHC_MANUAL_FILES)
	perl $(srcdir)/utils/stitch.prl -h $(srcdir)/docs/man_header.mkd -c Using,Options $^ > $@

man: ajhc_man.mkd
	pandoc $< -s -f markdown -t man -s  -o ajhc.1

options.mkd: drift_processed/Options.hs | $(bin_PROGRAMS)$(EXEEXT)
	echo "{-@Options 1" > $@
	./$(bin_PROGRAMS) --help | sed -e 's/^/    /'  >> $@

fix-whitespace:
	find src -not \( -name .svn -prune -o -name .git -prune \) -type f -name \*.hs -print0 | xargs -0 sed -i  -E 's/[ 	]*$$//'
	find lib -not \( -name .svn -prune -o -name .git -prune \) -type f -name \*.hs -print0 | xargs -0 sed -i  -E 's/[ 	]*$$//'

ajhc.1 :
	$(MAKE) man

manual.html :
	$(MAKE) manual

manual_ja.html :
	$(MAKE) manual_ja

.PHONY: libs regress
libs: $(JHC_LIBS) $(JHC_EXT_LIBS)

show_elibs: lib/ext/*.cabal  lib/ext/*.yaml
	-perl utils/build_extlibs.prl -l $^

%: examples/%.hs $(bin_PROGRAMS)$(EXEEXT) $(JHC_LIBS)
	./$(bin_PROGRAMS) -L- -L$(srcdir) -L. --no-cache $(JHC_TEST) $< -o $@ # 2>&1 | tee $@.log

TESTS=HelloWorld Primes

JHC_MANUAL_FILES = docs/make.mkd options.mkd docs/dependency_format.mkd docs/pragmas.mkd docs/differences.mkd \
	docs/unboxed.mkd rts/rts/jhc_rts.c src/FlagOpts.mkd src/FlagDump.mkd src/E/PrimOpt.hs \
	drift_processed/E/TypeCheck.hs drift_processed/Options.hs

regress: all
	mkdir -p regress/results
	./regress/regress.prl
