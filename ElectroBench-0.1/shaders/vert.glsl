#version 120

// Varying to pass data to the fragment shader
varying vec3 vNormal;
varying vec3 vPosition;
varying vec2 vTexCoord;

void main() {
    // Compute normal and position in world space
    vNormal = normalize(gl_NormalMatrix * gl_Normal);
    vPosition = vec3(gl_ModelViewMatrix * gl_Vertex);

    gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;

    vTexCoord = gl_MultiTexCoord0.st;
}
