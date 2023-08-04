# ElectroBench
ElectroBench is a GLSL 1.2 + C++ based benchmark for Debian-based Linux PCs, It demonstrates medium->advanced lighting situations using GLSL 1.2 shaders, and has an integrated FPS counter.

# Technical informations about ElectroBench: 

ElectroBench has 4 versions, each of them use a *specific* lighting effect : v1.6 uses Blinn-Phong + Rim + Shadows, v1.7 uses Blinn-Phong + Toon + Shadows, v1.8 uses Blinn-Phong + Toon + Rim + Shadows, and v2.0 uses Blinn-Phong + Shadows + Rim + Toon + Shadows Upgraded.

**Note : v1.0, v1.1, v1.2, v1.3, v1.4, v1.5 and v1.9 are deprecated for non-complexity.**

I'm gonna first explain some of the effects that are in this project : 

**Toon** : It gives the object a cartoon-like appearance.

**Phong** : The Phong reflection model (Created *mathematically* in 1975 by Bui Tuong Phong) is widely used in computer graphics, The Phong reflection model combines three components (ambient, diffuse and specular) to calculate the color and intensity of light reflected from a surface to the viewer's eye or the camera.  

**Rim** : Rim is a lighting effect that gives glow to an object.

**Blinn-Phong**: Blinn-Phong is a *mathematically* optimised superset of Phong. Instead of calculating the specular reflection using a reflection vector (sometimes called R), The Blinn-Phong model uses a halfway vector between the viewer's direction and the light direction instead of the reflection vector. The halfway vector is computed as the normalized sum of the light vector and the view vector (the vector pointing from the surface point to the viewer's eye).

**Shadows**: Shadows in this benchmark are used by calculating clamp to dot of the vPositon and vNormal of the light then multipling it by the color, It was used in v1.8-Beta, but in other versions it uses shadow-mapping. 

**Procedural texture :** In all of these versions, we used a different type of texture called procedural texture we don't use ```sampler3D``` types, but instead, we used different kinds of noises (like noise4D, perlin noise, FBM...) + effects that are written procedurally (we don't use sth like ```texture2D()``` functions).

**Blending texture :** In our ElectroBench versions, We use texture-blending, Which is combining textures to produce an effect that combines all of these textures, in v2.0 it was used, but not as intensive as we thought. It blended 3 different textures. A wooden-like texture + brick-wall-like texture + fire texture.

**Rendering:**

The project renders a teapot, then uses shaders to apply the effects on it, with the help of some attributes mentionned in the main.cxx file.

**Connection bettween shaders:**

The vertex and fragment shaders in ElectroBench uses a bi-directionnal connection made possible by the use of varying variables.

**Programming languages used:**

The programming languages used are **C++** for the *main* code, **GLSL 1.2 (OpenGL 2.1)** for shaders and **Shell** for execution and building.

**Compilation of this project:**

We used a 2-step manual compilation, it generates LLVM IR to a file and then compiles and links that IR.

# Complexified breaking changes

In these updated commits (v1.7-Beta+) so many breaking changes were used to make the benchmark more complex, Here are some of these changes :

***Resolution :*** Resolution was changed from 1280x1024 to 2K (2560x1440) to maximize the rendered content.

***Effects :*** From v1.7 onwards, Multiple lighting sources were used, Furthermore, Lambertian effects were added to all the versions, and shadows were included to all lighting sources in addition to the lighting components and effects.

***Multiple ways to handle light sources :*** In v1.8-Beta we used in the vertex shader an varying vec3 array called ```varying vec3 vLightDir[20]```, and we looped over thaat variable 5 times with the index i moving up at each loop, until 20 was reached, i was the number that was putted in the ```gl_LightSource[i]``` structure and we add that structure in the array and pass it to the fragment shader. For other versions, The computation of light sources was using plain vectors that were assigned to variables (*and for 20 light sources, It was so much*). But in v1.6, We used Simplex Noise to create a procedural texture and then we used an array to store 10 lights and 10 color lights and modified the snoise function to support vec3 instead of vec4 in the original. The structure of the lightsources should look like this:

```glsl
  
vec3 lightPositions[10] = vec3[10](
        vec3(1.0, 2.0, 3.0),
        vec3(-2.0, 1.0, 4.0),
        vec3(3.0, 1.0, -2.0),
        vec3(-4.0, 1.0, -3.0),
        vec3(2.0, 3.0, 1.0),
	vec3(snoise(vec3(.0548587)), 3.5878, 3.558),
	vec3(2.265565, 6.5558, 1.55885),
	vec3(2.5878, 5.89, 6.8),
	vec3(3.688, 2.414, 9.55),
	vec3(2.645788, snoise(vec3(2.414)), snoise(vec3(pow(9.556895, dot(.98845, .6898)))))
);

vec3 lightColors[10] = vec3[10](
        vec3(1.0, 0.2, 0.0),
        vec3(0.4, 1.0, 0.0),
        vec3(0.9, 0.6, 0.0),
        vec3(0.23, 0.5, 1.0),
        vec3(1.0, 0.0, 1.0),
    	vec3(snoise(vec3(.0548587)), 3.5878, 3.558),
	vec3(2.265565, 6.5558, 1.55885),
	vec3(2.985, 8.89, 1.8),
	vec3(3.688, 2.414, 9.55),
	vec3(9.645788, snoise(vec3(2.414)), snoise(vec3(pow(1.556895, dot(.98845, .6898)))))
);
```

***Mathematical complexity :*** In v2.0-Beta I used a noise4D generator to generate pseudo-random numbers directly on the GPU, based on the simplex noise and then passes those values to the positions of the lighting sources. That passes it also to the shadows, which their positions are the opposite of the lights.

# How to execute this project ?
It's so simple, just follow the instructions for the versions you want to execute :

**For Debian-based OSes:**

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


*v2.0-Beta:*

```sh
sudo apt install git -y --no-install-recommends
git clone https://github.com/AyoubCoding21/ElectroBench/
cd ElectroBench/ElectroBench-2.0-beta/
chmod u+x ./exec.sh && bash ./exec.sh
```

**Note**: It's recommended using v1.6-Beta+

# Questions or misunderstanding or pull requests

Who has a question or didn't understand something or has an issue, he emails me on this e-mail : ayoubprogramming95@gmail.com, or does a pull request.

**Note**: For most of my projects I use a Galaxy A2-Core and for limited periods of time, and also I use a 2007 PC without GPU and with 2 GB of RAM to build these projects, so if you want to support my work, consider donating.

**Donation (Payeer) :** ```P1098557175```

Cya !!
