#!/bin/bash

#by @m4lal0

# Regular Colors
Black='\033[0;30m'      # Black
Red='\033[0;31m'        # Red
Green='\033[0;32m'      # Green
Yellow='\033[0;33m'     # Yellow
Blue='\033[0;34m'       # Blue
Purple='\033[0;35m'     # Purple
Cyan='\033[0;36m'       # Cyan
White='\033[0;97m'      # White
Blink='\033[5m'         # Blink
Color_Off='\033[0m'     # Text Reset

# Light
LRed='\033[0;91m'       # Ligth Red
LGreen='\033[0;92m'     # Ligth Green
LYellow='\033[0;93m'    # Ligth Yellow
LBlue='\033[0;94m'      # Ligth Blue
LPurple='\033[0;95m'    # Light Purple
LCyan='\033[0;96m'      # Ligth Cyan
LWhite='\033[0;90m'     # Ligth White

# Dark
DGray='\033[2;37m'      # Dark Gray
DRed='\033[2;91m'       # Dark Red
DGreen='\033[2;92m'     # Dark Green
DYellow='\033[2;93m'    # Dark Yellow
DBlue='\033[2;94m'      # Dark Blue
DPurple='\033[2;95m'    # Dark Purple
DCyan='\033[2;96m'      # Dark Cyan
DWhite='\033[2;90m'     # Dark White

# Bold
BBlack='\033[1;30m'     # Bold Black
BRed='\033[1;31m'       # Bold Red
BGreen='\033[1;32m'     # Bold Green
BYellow='\033[1;33m'    # Bold Yellow
BBlue='\033[1;34m'      # Bold Blue
BPurple='\033[1;35m'    # Bold Purple
BCyan='\033[1;36m'      # Bold Cyan
BWhite='\033[1;37m'     # Bold White

# Italics
IBlack='\033[3;30m'     # Italic Black
IGray='\033[3;90m'      # Italic Gray
IRed='\033[3;31m'       # Italic Red
IGreen='\033[3;32m'     # Italic Green
IYellow='\033[3;33m'    # Italic Yellow
IBlue='\033[3;34m'      # Italic Blue
IPurple='\033[3;35m'    # Italic Purple
ICyan='\033[3;36m'      # Italic Cyan
IWhite='\033[3;37m'     # Italic White

# Underline
UBlack='\033[4;30m'     # Underline Black
URed='\033[4;31m'       # Underline Red
UGreen='\033[4;32m'     # Underline Green
UYellow='\033[4;33m'    # Underline Yellow
UBlue='\033[4;34m'      # Underline Blue
UPurple='\033[4;35m'    # Underline Purple
UCyan='\033[4;36m'      # Underline Cyan
UWhite='\033[4;37m'     # Underline White

# Background
On_Black='\033[40m'     # Background Black
On_Red='\033[41m'       # Background Red
On_Green='\033[42m'     # Background Green
On_Yellow='\033[43m'    # Background Yellow
On_Blue='\033[44m'      # Background Blue
On_Purple='\033[45m'    # Background Purple
On_Cyan='\033[46m'      # Background Cyan
On_White='\033[47m'     # Background White

# Variables Globales
FILE_MD=$1
FILE_PDF=$2
VERSION=1.0.1

# Menejo del Ctrl + C
trap ctrl_c INT

function ctrl_c(){
    echo -e "\n\n${LBlue}[${BYellow}!${LBlue}] ${BRed}Saliendo de la aplicaci??n...${Color_Off}"
    tput cnorm
    exit 1
}

function checkUpdate(){
    GIT=$(curl --silent https://github.com/m4lal0/md2pdf/blob/main/md2pdf.sh | grep 'VERSION=' | cut -d">" -f2 | cut -d"<" -f1 | cut -d"=" -f 2)
    if [[ "$GIT" == "$VERSION" || -z $GIT ]]; then
        echo -e "${BGreen}[???]${Color_Off} ${BGreen}La versi??n actual es la m??s reciente.${Color_Off}\n"
        tput cnorm; exit 0
    else
        echo -e "${Yellow}[*]${Color_Off} ${IWhite}Actualizaci??n disponible${Color_Off}"
        echo -e "${Yellow}[*]${Color_Off} ${IWhite}Actualizaci??n de la versi??n${Color_Off} ${BWhite}$VERSION${Color_Off} ${IWhite}a la${Color_Off} ${BWhite}$GIT${Color_Off}"
        update="1"
    fi
}

function installUpdate(){
    echo -en "${Yellow}[*]${Color_Off} ${IWhite}Instalando actualizaci??n...${Color_Off}"
    wget https://raw.githubusercontent.com/m4lal0/md2pdf/main/md2pdf.sh &>/dev/null
    chmod +x md2pdf.sh &>/dev/null
    mv md2pdf.sh /usr/local/bin/md2pdf &>/dev/null
    if [ "$(echo $?)" == "0" ]; then
        echo -e "${BGreen}[ OK ]${Color_Off}"
    else
        echo -e "${BRed}[ FAIL ]${Color_Off}"
        tput cnorm && exit 1
    fi
    echo -e "\n${BGreen}[???]${Color_Off} ${IGreen}Versi??n actualizada a${Color_Off} ${BWhite}$GIT${Color_Off}\n"
    tput cnorm && exit 0
}

function banner(){
    clear && tput civis
    echo -e "\n\t${BBlue}????????????   ????????????????????????????????? ????????????????????? ????????????????????? ????????????????????? ????????????????????????${Color_Off}"
    echo -e "\t${BBlue}??????????????? ???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????${Color_Off}"
    echo -e "\t${BBlue}??????????????????????????????????????????  ????????? ??????????????????????????????????????????????????????  ???????????????????????????  ${Color_Off}"
    echo -e "\t${BBlue}??????????????????????????????????????????  ?????????????????????????????? ????????????????????? ?????????  ???????????????????????????  ${Color_Off}"
    echo -e "\t${BBlue}????????? ????????? ??????????????????????????????????????????????????????????????????     ?????????????????????????????????     ${Color_Off}"
    echo -e "\t${BBlue}?????????     ?????????????????????????????? ?????????????????????????????????     ????????????????????? ?????????     ${Color_Off}"
    echo -e "\t${On_Blue}${BWhite}   Create a professional report Markdown to PDF   ${Color_Off}\n\n"
}

function dependencies(){
    echo -e "\n${BBlue}[+]${Color_Off} ${BWhite}Comprobando herramientas necesarias${Color_Off}"
    # Verificar si esta instalado Pandoc
    echo -ne "${Yellow}[*]${Color_Off} ${IWhite}Herramienta Pandoc... ${Color_Off}"
    command -v pandoc > /dev/null 2>&1
    if [ "$(echo $?)" == "0" ]; then
        echo -e "${BGreen}[ OK ]${Color_Off}"
    else
        pandoc_url=$(curl --silent 'https://github.com/jgm/pandoc/releases/' | grep -E 'pandoc-?[1-9].*-amd64.deb' | head -n 1 | awk -F '\"' '{print $2}')
        pandoc_file=$(curl --silent 'https://github.com/jgm/pandoc/releases/' | grep -E 'pandoc-?[1-9].*-amd64.deb' | head -n 1 | awk -F '\"' '{print $2}' | tr '/' ' ' | awk 'NF{print $NF}')
        wget "https://github.com$pandoc_url" -O /tmp/$pandoc_file > /dev/null 2>&1
        dpkg -i /tmp/$pandoc_file > /dev/null 2>&1
        if [ $? -eq 0 ];then
            echo -e "${BGreen}[ OK ]${Color_Off}"
        else
            echo -e "${BRed}[ FAIL ]${Color_Off}"
            tput cnorm && exit 1
        fi
    fi
    # Verificar si esta instalado p7zip
    echo -en "${Yellow}[*]${Color_Off} ${IWhite}Herramienta p7zip... ${Color_Off}"
    command -v p7zip > /dev/null 2>&1
    if [ "$(echo $?)" == "0" ]; then
        echo -e "${BGreen}[ OK ]${Color_Off}"
    else
        apt install p7zip -y > /dev/null 2>&1
        if [ $? -eq 0 ];then
            echo -e "${BGreen}[ OK ]${Color_Off}"
        else
            echo -e "${BRed}[ FAIL ]${Color_Off}"
            tput cnorm && exit 1
        fi
    fi
    # Verificar si esta instalado la plantilla Eisvogel
    echo -en "${Yellow}[*]${Color_Off} ${IWhite}Plantilla Eisvogel... ${Color_Off}"
    if [ ! -e /root/.local/share/pandoc/templates/eisvogel.latex ];then
        eisvogel_url=$(curl --silent 'https://github.com/Wandmalfarbe/pandoc-latex-template/releases/' | grep -E 'Eisvogel-?[1-9]*.zip' | head -n 1 | awk -F '\"' '{print $2}')
        eisvogel_file=$(curl --silent 'https://github.com/Wandmalfarbe/pandoc-latex-template/releases/' | grep -E 'Eisvogel-?[1-9]*.zip' | head -n 1 | awk -F '\"' '{print $2}' | tr '/' ' ' | awk 'NF{print $NF}')
        wget "https://github.com$eisvogel_url" -O /tmp/$eisvogel_file > /dev/null 2>&1
        cd /tmp/ && unzip /tmp/$eisvogel_file > /dev/null 2>&1
        mkdir -p /root/.local/share/pandoc/templates > /dev/null 2>&1
        cp /tmp/eisvogel.latex /root/.local/share/pandoc/templates > /dev/null 2>&1
        if [ $? -eq 0 ];then
            echo -e "${BGreen}[ OK ]${Color_Off}"
        else
            echo -e "${BRed}[ FAIL ]${Color_Off}"
            tput cnorm && exit 1
        fi
    else
        echo -e "${BGreen}[ OK ]${Color_Off}"
    fi
}

function createZip(){
    echo -e "\n${BBlue}[+]${Color_Off} ${BWhite}Creando paquete 7z${Color_Off}"
    tput cnorm
    echo -en "${BPurple}[?]${Color_Off} ${BCyan}Password para el archivo:${Color_Off} " && read PASSWORD
    tput civis
    ZIP_NAME=$(echo $FILE_PDF | awk -F ".pdf" '{print $1}')
    echo -en "${Yellow}[*]${Color_Off} ${IWhite}Realizando paquete 7z (${Color_Off}${BWhite}$ZIP_NAME.7z${Color_Off}${IWhite})...${Color_Off} "
    7z a $ZIP_NAME.7z -p$PASSWORD $FILE_PDF > /dev/null 2>&1
    if [ $? -eq 0 ];then
        echo -e "${BGreen}[ OK ]${Color_Off}"
        echo -e "\n${BGreen}[???]${Color_Off} ${IGreen}Visualizaci??n preliminar del reporte (${Color_Off}${BWhite}$FILE_PDF${Color_Off}${IWhite})${Color_Off}\n"
        atril $FILE_PDF
    else
        echo -e "${BRed}[ FAIL ]${Color_Off}\n"
        tput cnorm && exit 1
    fi
}

function createReport(){
    echo -e "\n${BBlue}[+]${Color_Off} ${BWhite}Creando reporte${Color_Off}"
    echo -en "${Yellow}[*]${Color_Off} ${IWhite}Generando el reporte... ${Color_Off}"
    pandoc $FILE_MD -o $FILE_PDF --from markdown+yaml_metadata_block+raw_html --template eisvogel --table-of-contents --toc-depth 6 --number-sections --top-level-division=chapter --highlight-style zenburn
    if [ $? -eq 0 ];then
        echo -e "${BGreen}[ OK ]${Color_Off}"
        tput cnorm
        echo -en "\n${BPurple}[?]${Color_Off} ${BCyan}Desea guardar el reporte en un archivo ZIP? (${BYellow}Y${BCyan}/${BRed}n${BCyan}):${Color_Off} " && read input
        tput civis
        case "$input" in
            n|N) echo -e "\n${BGreen}[???]${Color_Off} ${IGreen}Visualizaci??n preliminar del reporte (${Color_Off}${BWhite}$FILE_PDF${Color_Off}${IGreen})${Color_Off}\n" && atril $FILE_PDF;;
            *) createZip;;
        esac
    else
        echo -e "${BRed}[ FAIL ]${Color_Off}\n"
        exit 1
    fi
    tput cnorm
}

if [ "$(echo $UID)" == "0" ]; then
    if [ "$(echo $1)" == "--update" ]; then
        banner
        echo -e "${BBlue}[+]${Color_Off} ${BWhite}md2pdf Versi??n $VERSION${Color_Off}"
        echo -e "${BBlue}[+]${Color_Off} ${BWhite}Verificando actualizaci??n de md2pdf${Color_Off}"
        checkUpdate
        echo -e "\t${BWhite}$VERSION ${IWhite}Versi??n Instalada${Color_Off}"
        echo -e "\t${BWhite}$GIT ${IWhite}Versi??n en Git${Color_Off}\n"
        if [ "$update" != "1" ]; then
            tput cnorm && exit 0;
        else
            echo -e "${BBlue}[+]${Color_Off} ${BWhite}Necesita actualizar!${Color_Off}"
            tput cnorm
            echo -en "${BPurple}[?]${Color_Off} ${BCyan}Quiere actualizar? (${BGreen}Y${BCyan}/${BRed}n${BCyan}):${Color_Off} " && read CONDITION
            tput civis
            case "$CONDITION" in
                n|N) echo -e "\n${LBlue}[${BYellow}!${LBlue}] ${BRed}No se actualizo, se queda en la versi??n ${BWhite}$VERSION${Color_Off}\n" && tput cnorm && exit 0;;
                *) installUpdate;;
            esac
        fi
    fi
    if [ "$#" -ne 2 ];then
        echo -e "\n\t${LBlue}[${BYellow}!${LBlue}] ${BWhite}Uso: ${BGreen}$0 ${IGreen}<input.md> <output.pdf>${Color_Off}\n"
        echo -e "\n\t${LBlue}[${BYellow}!${LBlue}] ${BWhite}Actualizar: ${BGreen}$0 ${IGreen}--update${Color_Off}\n"
        exit 1
    fi
    banner
    dependencies
    createReport
else
	echo -e "\n${LBlue}[${BYellow}!${LBlue}] ${BRed}Ejecutar la herramienta como root${Color_Off}\n"
	exit 1
fi