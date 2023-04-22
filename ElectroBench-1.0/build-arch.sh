echo -e "\e[1;33m${bold}Installing packages...\e[0m";
sudo pacman -Sy && sudo pacman -S freeglut glew cmake clang libglvnd
echo -e "\e[1;33m${bold}Setting up...\e[0m";
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
cd build
cmake ../
cmake --build .
make
cd ..
# Executing
if [ -f ./build/ElectroBench ]
then
        echo -e "\e[1;33m${bold}Executing...\e[0m";
        chmod u+w+x ./build/ElectroBench && ./build/ElectroBench;
else
        echo -e "\e[1;31m${bold}Errors occured ! See output above.\e[0m"
fi
