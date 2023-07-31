#version 120
varying vec3 vNormal;
varying vec3 vPosition;
varying vec3 vLightDir[20];

void main() {
    vPosition = vec3(gl_ModelViewMatrix * gl_Vertex);
    vNormal = normalize(gl_NormalMatrix * gl_Normal);
    for (int i = 0; i < 20; i++) {
        vLightDir[i] = normalize(vec3(gl_LightSource[i].position.xyz - vPosition));
    }
    gl_Position = ftransform();
}
