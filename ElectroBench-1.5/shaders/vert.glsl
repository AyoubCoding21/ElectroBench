#version 120
varying vec3 normal;
varying vec3 lightDir;
varying vec3 viewDir;

void main()
{
    normal = normalize(gl_NormalMatrix * gl_Normal);
    vec4 vertex = gl_ModelViewMatrix * gl_Vertex;
    vec4 light = gl_LightSource[0].position;
    lightDir = normalize(vec3(light - vertex));
    viewDir = normalize(-vec3(vertex));
    gl_Position = ftransform();
}

