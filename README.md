# ElectroBench
ElectroBench is a GLSL 1.2 + C++ based benchmark for Debian-based Linux PCs, It demonstrates medium->advanced lighting situations using GLSL 1.2 shaders, and has an integrated FPS counter.

# Technical informations about ElectroBench: 

ElectroBench has 8 versions, each of them use a *specific* lighting effect ; v1.0 uses Toon, v1.1 uses Directional Light Per Pixel, v1.2 uses Point Light Per Pixel, v1.3 uses Point Light Per Pixel + Toon, v1.4 uses Phong + Rim lighting, v1.5 uses Phong + Rim + Toon lighting, v1.6 uses Blinn-Phong + Rim + Shadows and v1.7 uses Blinn-Phong + Toon + Shadows.

I'm gonna first explain some of the effects that are in this project : 

**Toon** : It gives the object a cartoon-like appearance.

**Point Light** : It's light focused in a single point of cordinnates x, y and *optionnaly* z. It's calculated using how far a fragment is from the light center.

**Phong** : It's like Point Light.

**Rim** : Rim is a lighting effect that gives glow to an object.

**Blinn-Phong**: Blinn-Phong is a *mathematically* optimised superset of Phong. It uses 2 lighting components (diffuse and specular).

**Rendering:**

The project renders a teapot, then uses shaders to apply the effects on it, with the help of some attributes mentionned in the main.cxx file.

**Connection bettween shaders:**

The vertex and fragment shaders in ElectroBench (*v1.1+*) uses a bi-directionnal connection made possible by the use of varying variables.

**Programming languages used:**

The programming languages used are **C++** for the *main* code, **GLSL 1.2 (OpenGL 2.1)** for shaders and **Shell and CMake** for execution and building.

**Note**: CMake wasn't used from v1.6-Beta and higher.

# How to execute this project ?
It's so simple, just follow the instructions for the versions you want to execute :

**For Debian-based OSes:**

*v1.0:*

```sh
sudo apt install git -y --no-install-recommends
git clone https://github.com/AyoubCoding21/ElectroBench/
sleep 2s
cd ElectroBench/ElectroBench-1.0/
chmod u+x ./build.sh && bash ./build.sh
```

*v1.1:*

```sh
sudo apt install git -y --no-install-recommends
git clone https://github.com/AyoubCoding21/ElectroBench/
sleep 2s
cd ElectroBench/ElectroBench-1.1/
chmod u+x ./build.sh && bash ./build.sh
```

*v1.2:*

```sh
sudo apt install git -y --no-install-recommends
git clone https://github.com/AyoubCoding21/ElectroBench/
sleep 2s
cd ElectroBench/ElectroBench-1.2/
chmod u+x ./build.sh && bash ./build.sh
```

*v1.3:*

```sh
sudo apt install git -y --no-install-recommends
git clone https://github.com/AyoubCoding21/ElectroBench/;
sleep 2s
cd ElectroBench/ElectroBench-1.3/
chmod u+x ./build.sh && bash ./build.sh
```

*v1.4:*

```sh
sudo apt install git -y --no-install-recommends
git clone https://github.com/AyoubCoding21/ElectroBench/
sleep 2s
cd ElectroBench/ElectroBench-1.4/
chmod u+x ./build.sh && bash ./build.sh
```

*v1.5:*

```sh
sudo apt install git -y --no-install-recommends
git clone https://github.com/AyoubCoding21/ElectroBench/
cd ElectroBench/ElectroBench-1.5/
chmod u+x ./build.sh && bash ./build.sh
```
*v1.6-Beta:*

```sh
sudo apt install git -y --no-install-recommends
git clone https://github.com/AyoubCoding21/ElectroBench/
sleep 2s
cd ElectroBench/ElectroBench-1.6-beta/
chmod u+x ./exec.sh && bash ./exec.sh
```

*v1.7-Beta:*

```sh
sudo apt install git -y --no-install-recommends
git clone https://github.com/AyoubCoding21/ElectroBench/
sleep 2s
cd ElectroBench/ElectroBench-1.7-beta/
chmod u+x ./exec.sh && bash ./exec.sh
```

**Note**: It's recommended using v1.6-Beta+

# Questions or misunderstanding or pull requests

Who has a question or didn't understand something or has an issue, he emails me on this e-mail : ayoubprogramming95@gmail.com, or does a pull request.

**Note**: For donation, message me at the same email.

Cya !!
