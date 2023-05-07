#!/bin/bash

set -e
root=$PWD
mkdir -p server
cd server

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
CYAN="\033[0;36m"
NC="\033[0m"

display_title() {
    clear
    echo -e "${GREEN}====================================================================="
    echo ""
    echo -e "                        MCServerTemplate v0.1.0                     "
    echo ""
    echo -e "=====================================================================${NC}"
    echo ""
}

download() {
    display_title
    echo "By executing this script you agree to all the licenses of the packages"
    echo "used in this project."
    echo ""
    echo -e "${YELLOW}Press Ctrl+C if you do not agree to any of these licenses."
    echo -e "Press Enter to agree.${NC}"
    read -s agree_text
    echo ""
    echo "Thank you for agreeing, the download will now begin."
    echo ""

    case "${SERVER,,}" in
    purpur)
        echo -e "${BLUE}Downloading Purpur...${NC}"
        echo ""
        wget -O server.jar "https://api.purpurmc.org/v2/purpur/$VERSION/latest/download"
        ;;
    paper)
        echo -e "${BLUE}Downloading Paper...${NC}"
        echo ""
        wget -O server.jar "https://api.papermc.io/v2/projects/paper/versions/$VERSION/builds/$BUILD/downloads/paper-$VERSION-$BUILD.jar"
        ;;
    magma)
        echo -e "${BLUE}Downloading Magma...${NC}"
        echo ""
        wget -O server.jar "https://api.magmafoundation.org/api/v2/$VERSION/latest/download"
        ;;
    esac

    serverName="$(echo "$SERVER" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')"
    echo -e "${GREEN}${serverName} has been successfully downloaded.${NC}"
    echo "eula=true" >eula.txt
    echo ""
    echo -e "${BLUE}Downloading ngrok...${NC}"
    echo ""
    wget -O ngrok.zip "https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip"
    unzip -o ngrok.zip >/dev/null 2>&1
    rm -f ngrok.zip >/dev/null 2>&1
    echo -e "${GREEN}ngrok has been successfully downloaded."
    echo ""
    echo -e "Downloads completed.${NC}"
    echo ""
}

require() {
    if [ ! $1 $2 ]; then
        download
    fi
}

requireFile() {
    require -f $1 "File $1 required but not found"
}

requireEnv() {
    var=$(python3 -c "import os;print(os.getenv('$1',''))")
    if [ -z "${var}" ]; then
        echo -e "${RED}Environment variable $1 not set."
        echo "Please read the README on setting environment variables."
        exit
    fi
    eval "$1=$var"
}

requireExec() {
    requireFile "$1"
    chmod +x "$1"
}

while true; do
    display_title
    requireEnv "SERVER"
    requireEnv "VERSION"
    if [ "${SERVER,,}" == "paper" ]; then
        requireEnv "BUILD"
    fi
    requireFile "eula.txt"
    requireFile "server.jar"
    requireExec "ngrok"
    requireEnv "ngrok_token"
    requireEnv "ngrok_region"
    mkdir -p ./logs
    touch ./logs/temp
    rm ./logs/*
    echo -e "${GREEN}Starting ngrok tunnel in region: $ngrok_region"
    ./ngrok authtoken $ngrok_token >/dev/null 2>&1
    ./ngrok tcp -region $ngrok_region --log=stdout 25565 >$root/status.log &
    echo ""
    echo -e "${CYAN}Minecraft server starting, please wait...${NC}"
    echo ""
    echo -e "${GREEN}=====================================================================${NC}"
    echo ""
    COMMON_JVM_FLAGS="-Xms128M -Xmx512M -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+UnlockDiagnosticVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -XX:+UseStringDeduplication -XX:+UseAES -XX:+UseAESIntrinsics -XX:UseSSE=4 -XX:AllocatePrefetchStyle=1 -XX:+UseLoopPredicate -XX:+RangeCheckElimination -XX:+EliminateLocks -XX:+DoEscapeAnalysis -XX:+UseCodeCacheFlushing -XX:+OptimizeStringConcat -XX:+UseCompressedOops -XX:+UseThreadPriorities -XX:+TrustFinalNonStaticFields -XX:+UseInlineCaches -XX:+RewriteBytecodes -XX:+RewriteFrequentPairs -XX:+UseNUMA -XX:-DontCompileHugeMethods -XX:+UseFPUForSpilling -XX:+UseNewLongLShift -XX:+UseXMMForArrayCopy -XX:+UseXmmI2D -XX:+UseXmmI2F -XX:+UseXmmLoadAndClearUpper -XX:+UseXmmRegToRegMoveAll -Dfile.encoding=UTF-8 -Djava.security.egd=file:/dev/urandom"

    if [[ "$VERSION" =~ ^1\.(17|18|19)\. ]]; then
        java $COMMON_JVM_FLAGS --add-modules jdk.incubator.vector -XX:UseAVX=2 -Xlog:async -jar server.jar nogui
    elif [[ "$VERSION" =~ ^1\.(8|9|10|11|12|13|14|15|16)\. ]]; then
        java $COMMON_JVM_FLAGS -XX:-UseBiasedLocking -XX:UseAVX=3 -jar server.jar nogui
    fi
done
