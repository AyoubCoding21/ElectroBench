#!/bin/bash
main() {
        local text="$1"
        local delay="$2"
        local colors=("31" "32" "33" "34" "35" "36")
        for color in "${colors[@]}"; do
                echo -e "\e[1;${color}m${bold}$text\e[0m"
                sleep "$delay"
                clear
        done

        echo -e "\e[1;32m${bold}Is it your first time that you run the script ?(y/n)\e[0m"; read choice
        if [ $choice == 'y' ] || [ $choice == "Y" ]; then
                echo -e "\e[1;33m${bold}Installing packages...\e[0m";
                sudo apt update && sudo apt install freeglut3-dev clang wget libglew-dev -y --no-install-recommends
                sudo wget http://ftp.bg.debian.org/debian/pool/main/f/freeglut/libglut-dev_3.4.0-1_amd64.deb
                sudo wget http://ftp.bg.debian.org/debian/pool/main/f/freeglut/libglut3.12_3.4.0-1_amd64.deb
                sudo dpkg -i ./libglut3.12_3.4.0-1_amd64.deb
                sudo dpkg -i ./libglut-dev_3.4.0-1_amd64.deb
                echo -e "\e[1;33m${bold}Setting up...\e[0m";
                sudo rm -f ./libglut-dev_3.4.0-1_amd64.deb
                sudo rm -f ./libglut3.12_3.4.0-1_amd64.deb
        fi
        if [ -d build/ ]
        then
                sleep 1s
        else
                mkdir build
        fi

        if [ -f ./build/ElectroBench ]
        then
                rm ./build/ElectroBench -f
        fi
        # Compiling
        echo -e "\e[1;33m${bold}Compiling the source code...\e[0m";
        clang++ ./src/main.cxx -o ./build/ElectroBench -I/usr/include/ -L/usr/lib/ -lglut -lGL -lGLU -lX11 -lGLEW -v
        # Executing
        if [ -f ./build/ElectroBench ]
        then
                echo -e "\e[1;33m${bold}Executing...\e[0m";
                chmod u+w+x ./build/ElectroBench && ./build/ElectroBench;
        else
                echo -e "\e[1;31m${bold}Errors occured ! See output above.\e[0m"
        fi
}
main "ElectroBench v1.6-beta" 0.58
