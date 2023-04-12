#!/bin/bash

set -e
root=$PWD
mkdir -p server
cd server

download() {
    echo "By executing this script you agree to all the licenses of the packages used in this project."
    echo "Press Ctrl+C if you do not agree to any of these licenses."
    echo "Press Enter to agree."
    read -s agree_text
    echo "Thank you for agreeing, the download will now begin."
    case "$SERVER" in
    purpur)
        wget -O server.jar "https://api.purpurmc.org/v2/purpur/$VERSION/latest/download"
        echo "Purpur downloaded"
        ;;
    paper)
        wget -O server.jar "https://api.papermc.io/v2/projects/paper/versions/$VERSION/builds/$BUILD/downloads/paper-$VERSION-$BUILD.jar"
        echo "Paper downloaded"
        ;;
    magma)
        wget -O server.jar "https://api.magmafoundation.org/api/v2/$VERSION/latest/download"
        echo "Magma downloaded"
        ;;
    esac
    echo "eula=true" >eula.txt
    echo "Agreed to Mojang EULA"
    wget -O ngrok.zip "https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip"
    unzip -o ngrok.zip
    rm -f ngrok.zip
    echo "Download complete"
}

require() {
    if [ ! $1 $2 ]; then
        echo $3
        echo "Running download..."
        download
    fi
}

requireFile() {
    require -f $1 "File $1 required but not found"
}

requireEnv() {
    var=$(python3 -c "import os;print(os.getenv('$1',''))")
    if [ -z "${var}" ]; then
        echo "Environment variable $1 not set. "
        echo "In your .env file, add a line with:"
        echo "$1="
        echo "and then right after the = add $2"
        exit
    fi
    eval "$1=$var"
}

requireExec() {
    requireFile "$1"
    chmod +x "$1"
}

requireFile "eula.txt"
requireFile "server.jar"
requireExec "ngrok"
requireEnv "ngrok_token" "your ngrok authtoken from https://dashboard.ngrok.com"
requireEnv "ngrok_region" "your region, one of:
us - United States (Ohio)
eu - Europe (Frankfurt)
ap - Asia/Pacific (Singapore)
au - Australia (Sydney)
sa - South America (Sao Paulo)
jp - Japan (Tokyo)
in - India (Mumbai)"

echo "Minecraft server starting, please wait" >$root/status.log
mkdir -p ./logs
touch ./logs/temp
rm ./logs/*
echo "Starting ngrok tunnel in region $ngrok_region"
./ngrok authtoken $ngrok_token
./ngrok tcp -region $ngrok_region --log=stdout 25565 >$root/status.log &
echo "Server Up!"
echo "Server is now running!" >$root/status.log
echo "Running server..."
if [[ "$VERSION" =~ ^1\.(17|18|19)\. ]]; then
    java -Xms128M -Xmx512M -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+UnlockDiagnosticVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -XX:UseAVX=2 -XX:+UseStringDeduplication -XX:+UseAES -XX:+UseAESIntrinsics -XX:UseSSE=4 -XX:+UseFMA -XX:AllocatePrefetchStyle=1 -XX:+UseLoopPredicate -XX:+RangeCheckElimination -XX:+EliminateLocks -XX:+DoEscapeAnalysis -XX:+UseCodeCacheFlushing -XX:+SegmentedCodeCache -XX:+OptimizeStringConcat -XX:+UseCompressedOops -XX:+UseThreadPriorities -XX:+TrustFinalNonStaticFields -XX:+UseInlineCaches -XX:+RewriteBytecodes -XX:+RewriteFrequentPairs -XX:+UseNUMA -XX:-DontCompileHugeMethods -XX:+UseFPUForSpilling -XX:+UseNewLongLShift -XX:+UseVectorCmov -XX:+UseXMMForArrayCopy -XX:+UseXmmI2D -XX:+UseXmmI2F -XX:+UseXmmLoadAndClearUpper -XX:+UseXmmRegToRegMoveAll -Dfile.encoding=UTF-8 -Xlog:async -Djava.security.egd=file:/dev/urandom --add-modules jdk.incubator.vector -jar server.jar nogui
elif [[ "$VERSION" =~ ^1\.(8|9|10|11|12|13|14|15|16)\. ]]; then
    java -Xms128M -Xmx512M -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+UnlockDiagnosticVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -XX:-UseBiasedLocking -XX:UseAVX=3 -XX:+UseStringDeduplication -XX:+UseAES -XX:+UseAESIntrinsics -XX:UseSSE=4 -XX:AllocatePrefetchStyle=1 -XX:+UseLoopPredicate -XX:+RangeCheckElimination -XX:+EliminateLocks -XX:+DoEscapeAnalysis -XX:+UseCodeCacheFlushing -XX:+OptimizeStringConcat -XX:+UseCompressedOops -XX:+UseThreadPriorities -XX:+TrustFinalNonStaticFields -XX:+UseInlineCaches -XX:+RewriteBytecodes -XX:+RewriteFrequentPairs -XX:+UseNUMA -XX:-DontCompileHugeMethods -XX:+UseFPUForSpilling -XX:+UseNewLongLShift -XX:+UseXMMForArrayCopy -XX:+UseXmmI2D -XX:+UseXmmI2F -XX:+UseXmmLoadAndClearUpper -XX:+UseXmmRegToRegMoveAll -Dfile.encoding=UTF-8 -Djava.security.egd=file:/dev/urandom -jar server.jar nogui
else
    echo "Read the README.md file and set the version to a valid version"
fi
