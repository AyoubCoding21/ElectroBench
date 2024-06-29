EXECNAME = ElectroBench

install:        
	echo -e "\e[1;33m${bold}Installing packages...\e[0m";
	sudo apt update && sudo apt install freeglut3-dev cmake clang wget libglew-dev -y --no-install-recommends                
all:        
	mkdir build && cd build && cmake .. && make
	chmod u+w+x ./build/$(EXECNAME) && ./build/$(EXECNAME);        
clean:
	rm -rf build/
