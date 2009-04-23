#!/bin/sh

# clj - Clojure launcher script


cljjar='lib/clojure.jar'
cljclass='clojure.lang.Repl'
cljscript='clojure.lang.Script'
jlineclass='jline.ConsoleRunner'

dir=$0
while [ -h "$dir" ]; do
    ls=`ls -ld "$dir"`
    link=`expr "$ls" : '.*-> \(.*\)$'`

    if expr "$link" : '/.*' > /dev/null; then
        dir="$link"
    else
        dir=`dirname "$dir"`"/$link"
    fi
done

dir=`dirname $dir`
dir=`cd "$dir" > /dev/null && pwd`
cljjar="$dir/../$cljjar"
jlinejar="$dir/../../jline.jar"


if [ -z "$1" ]; then
  exec java -classpath $jlinejar:$cljjar $jlineclass $cljclass
else
  scriptname=$1
  exec java -classpath $jlinejar:$cljjar $jlineclass $cljscript $scriptname --$*
fi

