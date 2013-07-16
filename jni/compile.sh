if [ -z "$JAVA_HOME" ]; then
    echo "ERROR You should set JAVA_HOME"
    echo "Exiting!"
    exit 1
fi


C_INCLUDE_PATH="${JAVA_HOME}/include:${JAVA_HOME}/include/linux:/System/Library/Frameworks/JavaVM.framework/Headers"
export C_INCLUDE_PATH

rm *.java
rm *.c
rm *.so

swig -java sodium.i
swig -java -package org.abstractj.kalium -outdir ../src/main/java/org/abstractj/kalium sodium.i

gcc sodium_wrap.c -shared -fPIC -L/usr/lib -lsodium -o libtestjni.so
sudo rm /usr/lib/libtestjni.so 
sudo cp libtestjni.so /usr/lib

