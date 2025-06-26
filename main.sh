#!/bin/bash

set -e
root=$PWD
mkdir -p server && cd server

R="\033[0;31m" G="\033[0;32m" Y="\033[1;33m" B="\033[0;34m" C="\033[0;36m" NC="\033[0m"

show_title() {
    clear
    echo -e "${G}=====================================================================\n\n                        MCServerTemplate v0.3.0\n\n=====================================================================${NC}\n"
}

check_env() {
    for var in "$@"; do
        val=$(printenv "$var" 2>/dev/null || echo "")
        [ -z "$val" ] && {
            echo -e "${R}Environment variable $var not set.\nPlease read the README on setting environment variables.${NC}"
            exit 1
        }
        eval "$var='$val'"
    done
}

download_if_missing() {
    [ -f server.jar ] && [ -f ngrok ] && [ -f eula.txt ] && return

    show_title
    echo -e "By executing this script you agree to all licenses.\n${Y}Press Ctrl+C to disagree, Enter to continue.${NC}"
    read -s

    echo -e "\n${B}Downloading ${SERVER^}...${NC}"
    case "${SERVER,,}" in
    purpur) wget -qO server.jar "https://api.purpurmc.org/v2/purpur/$VERSION/latest/download" ;;
    paper) wget -qO server.jar "https://api.papermc.io/v2/projects/paper/versions/$VERSION/builds/$BUILD/downloads/paper-$VERSION-$BUILD.jar" ;;
    esac

    echo -e "${G}${SERVER^} downloaded.${NC}\n${B}Downloading ngrok...${NC}"
    wget -qO ngrok.zip "https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.zip"
    unzip -oq ngrok.zip && rm ngrok.zip
    chmod +x ngrok
    echo "eula=true" >eula.txt
    echo -e "${G}Downloads completed.${NC}\n"
}

while true; do
    show_title

    check_env SERVER VERSION ngrok_token
    [ "${SERVER,,}" == "paper" ] && check_env BUILD

    download_if_missing

    mkdir -p logs && rm -f logs/*
    if ! pgrep -x "ngrok" >/dev/null; then
        echo -e "${G}Starting ngrok tunnel...${NC}"
        ./ngrok authtoken "$ngrok_token" &>/dev/null
        ./ngrok tcp --log=stdout 25565 >"$root/status.log" &
        sleep 2

        tunnel_url=$(grep -o 'url=tcp://[^[:space:]]*' "$root/status.log" 2>/dev/null | cut -d'=' -f2 | sed 's/tcp:\/\///' | head -1)
        [ -n "$tunnel_url" ] && echo -e "${G}Tunnel established! Server IP: ${C}$tunnel_url${NC}" || echo -e "${Y}Check status.log for tunnel URL${NC}"
    fi

    echo -e "\n${C}Starting Minecraft server...${NC}\n${G}=====================================================================${NC}\n"

    base_flags="-Xms512M -Xmx2G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:InitiatingHeapOccupancyPercent=15 -XX:+UseStringDeduplication -XX:+UseCompressedOops -Dfile.encoding=UTF-8"

    if [[ "$VERSION" =~ ^1\.(17|18|19|20|21) ]]; then
        java $base_flags --add-modules jdk.incubator.vector -jar server.jar nogui
    elif [[ "$VERSION" =~ ^1\.(8|9|10|11|12|13|14|15|16) ]]; then
        java $base_flags -XX:-UseBiasedLocking -jar server.jar nogui
    else
        java $base_flags -jar server.jar nogui
    fi
done
