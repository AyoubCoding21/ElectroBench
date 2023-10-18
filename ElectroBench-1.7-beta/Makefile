EXECNAME = ElectroBench

install:        
	echo -e "\e[1;33m${bold}Installing packages...\e[0m";
	sudo apt update && sudo apt install freeglut3-dev clang wget libglew-dev -y --no-install-recommends
	sudo wget http://ftp.bg.debian.org/debian/pool/main/f/freeglut/libglut-dev_3.4.0-1_amd64.deb
	sudo wget http://ftp.bg.debian.org/debian/pool/main/f/freeglut/libglut3.12_3.4.0-1_amd64.deb
	sudo dpkg -i ./libglut3.12_3.4.0-1_amd64.deb
	sudo dpkg -i ./libglut-dev_3.4.0-1_amd64.deb
	echo -e "\e[1;33m${bold}Setting up...\e[0m";
	sudo rm -f ./libglut-dev_3.4.0-1_amd64.deb
	sudo rm -f ./libglut3.12_3.4.0-1_amd64.deb
                
all:        
	clang++ ./src/main.cxx -L/usr/lib/ -I/usr/include/ -lGL -lGLU -lGLEW -lglut -lX11 -o build/$(EXECNAME) -v
	chmod u+w+x ./build/$(EXECNAME) && ./build/$(EXECNAME);
        
        
clean:
	rm -rf build/$(EXECNAME)
