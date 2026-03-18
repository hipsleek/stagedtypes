#/bin/bash

set -x
PREBUILD=$(mktemp -d)
mkdir $PREBUILD/rocq
BUILD=$PREBUILD/rocq

make clean
cp -r slf staged types $BUILD

# edit files
cat _CoqProject > $BUILD/_CoqProject
printf 'Makefile.coq:\n\trocq makefile -f _CoqProject -o Makefile.coq\n-include Makefile.coq' > $BUILD/Makefile
echo 'The development compiles with Rocq 9.1.1 (tested on OCaml 5.4.1).

To compile the development and its dependencies,

```sh
make
```

This should complete without errors in less than a minute.

The formalisation is in the types directory.' > $BUILD/readme.md

cd $PREBUILD
zip -r rocq.zip rocq

cd -
cp $PREBUILD/rocq.zip .
