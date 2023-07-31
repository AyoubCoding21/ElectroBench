# ElectroBench
ElectroBench is a GLSL 1.2 + C++ based benchmark for Debian-based Linux PCs, It demonstrates medium->advanced lighting situations using GLSL 1.2 shaders, and has an integrated FPS counter.

# Technical informations about ElectroBench: 

ElectroBench has 10 versions, each of them use a *specific* lighting effect : v1.0 uses Toon, v1.1 uses Directional Light Per Pixel, v1.2 uses Point Light Per Pixel, v1.3 uses Point Light Per Pixel + Toon, v1.4 uses Phong + Rim lighting, v1.5 uses Phong + Rim + Toon lighting, v1.6 uses Blinn-Phong + Rim + Shadows, v1.7 uses Blinn-Phong + Toon + Shadows, v1.8 uses Blinn-Phong + Toon + Rim + Shadows, v1.9 uses Blinn-Phong + Rim + Toon + Fire effect and v2.0 uses Blinn-Phong + Shadows + Rim + Toon + Fire effect.

I'm gonna first explain some of the effects that are in this project : 

**Toon** : It gives the object a cartoon-like appearance.

**Point Light** : It's directional light focused in a single point of cordinnates x, y and *optionnaly* z. It's calculated using how far a fragment is from the light center.

**Phong** : It's like Point Light but it uses lighting components (diffuse, specular, ambient and shininess).

**Rim** : Rim is a lighting effect that gives glow to an object.

**Blinn-Phong**: Blinn-Phong is a *mathematically* optimised superset of Phong. It uses 2 lighting components (diffuse and specular).

**Shadows**: Shadows in this benchmark are used by calculating clamp to dot of the vPositon and vNormal of the light then multipling it by the color, It was used in v1.8-Beta, but in other versions it uses shadow-mapping. 

**Fire effect**: For this *virtual* fire effect we addded a lambert effect to the calculations. And we used a *degrade* color system for bottom to top (from yellow to red).

**Rendering:**

The project renders a teapot, then uses shaders to apply the effects on it, with the help of some attributes mentionned in the main.cxx file.

**Connection bettween shaders:**

The vertex and fragment shaders in ElectroBench (*v1.1+*) uses a bi-directionnal connection made possible by the use of varying variables.

**Programming languages used:**

The programming languages used are **C++** for the *main* code, **GLSL 1.2 (OpenGL 2.1)** for shaders and **Shell and CMake** for execution and building.

**Note**: CMake wasn't used from v1.6-Beta and higher.

**Compilation of this project:**
From v1.0 to v1.5, The project used CMake for building but from v1.6-beta+, we used a 2-step manual compilation, it generates LLVM IR to a file and then compiles and links that IR.

# Complexified breaking changes

In these updated commits (v1.7-Beta+) so many breaking changes were used to make the benchmark more complex, Here are some of these changes :

***Resolution :*** Resolution was changed from 1280x1024 to 2K (2560x1440) to maximize the rendered content.

***Effects :*** From v1.7 onwards, Multiple lighting sources were used, Furthermore, Lambertian effects were added to all the versions, and shadows were included to all lighting sources in addition to the lighting components and effects.

***Multiple ways to handle light sources :*** In v1.8-Beta we used in the vertex shader an varying vec3 array called ```varying vec3 vLightDir[20]```, and we looped over thaat variable 5 times with the index i moving up at each loop, until 20 was reached, i was the number that was putted in the ```gl_LightSource[i]``` structure and we add that structure in the array and pass it to the fragment shader. For other versions, The computation of light sources was using plain vectors that were assigned to variables (*and for 20 light sources, It was so much*).

***Mathematical complexity :*** In v2.0-Beta I used a noise4D generator to generate pseudo-random numbers directly on the GPU, based on the simplex noise and then passes those values to the positions of the lighting sources. That passes it also to the shadows, which their positions are the opposite of the lights.

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

*v1.8-Beta:*

```sh
sudo apt install git -y --no-install-recommends
git clone https://github.com/AyoubCoding21/ElectroBench/
cd ElectroBench/ElectroBench-1.8-beta/
chmod u+x ./exec.sh && bash ./exec.sh
```


*v1.9-Beta:*

```sh
sudo apt install git -y --no-install-recommends
git clone https://github.com/AyoubCoding21/ElectroBench/
cd ElectroBench/ElectroBench-1.9-beta/
chmod u+x ./exec.sh && bash ./exec.sh
```


*v2.0-Beta:*

```sh
sudo apt install git -y --no-install-recommends
git clone https://github.com/AyoubCoding21/ElectroBench/
cd ElectroBench/ElectroBench-2.0-beta/
chmod u+x ./exec.sh && bash ./exec.sh
```

**Note**: It's recommended using v1.7-Beta+

# Questions or misunderstanding or pull requests

Who has a question or didn't understand something or has an issue, he emails me on this e-mail : ayoubprogramming95@gmail.com, or does a pull request.

**Note**: For most of my projects I use a Galaxy A2-Core and for limited periods of time, and also I use a 2007 PC without GPU and with 2 GB of RAM to build these projects, so if you want to support my work, consider donating.

**Note**: For donation, message me at the same email.

Cya !!
