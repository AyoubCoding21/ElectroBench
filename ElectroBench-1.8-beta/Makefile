EXECNAME = ElectroBench

install:        
	echo -e "\e[1;33m${bold}Installing packages...\e[0m";
	sudo apt update && sudo apt install freeglut3-dev clang wget libglew-dev -y --no-install-recommends                
all:        
	clang++ ./src/main.cxx -L/usr/lib/ -I/usr/include/ -lGL -lGLU -lGLEW -lglut -lX11 -o build/$(EXECNAME) -v
	chmod u+w+x ./build/$(EXECNAME) && ./build/$(EXECNAME);        
clean:
	rm -rf build/$(EXECNAME)
