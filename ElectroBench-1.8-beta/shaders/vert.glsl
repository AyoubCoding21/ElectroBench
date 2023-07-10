#version 120
varying vec3 vNormal;
varying vec3 vPosition;
varying vec3 vLightDir;

void main() {
    vPosition = vec3(gl_ModelViewMatrix * gl_Vertex);
    vNormal = normalize(gl_NormalMatrix * gl_Normal);
    vLightDir = normalize(vec3(gl_LightSource[0].position.xyz - vPosition));
    gl_Position = ftransform();
}

