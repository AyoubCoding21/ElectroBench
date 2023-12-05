EXECNAME = ElectroBench

install:        
	echo -e "\e[1;33m${bold}Installing packages...\e[0m";
	sudo apt update && sudo apt install freeglut3-dev clang wget libglew-dev -y --no-install-recommends                
all:        
	if [-d build/]
	then
		sleep 1s
	else
		mkdir build
	clang ./src/main.c -L/usr/lib/ -I/usr/include/ -lGL -lGLU -lGLEW -lglut -lX11 -o build/$(EXECNAME) -v
	chmod u+w+x ./build/$(EXECNAME) && ./build/$(EXECNAME);        
clean:
	rm -rf build/$(EXECNAME)
