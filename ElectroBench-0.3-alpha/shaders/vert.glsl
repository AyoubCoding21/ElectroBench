#version 130

precision highp float;

// Varying to pass texture coordinates to the fragment shader
out vec3 vNormal;
out vec3 vPosition;
out vec2 vTexCoord;

void main() {
    // Compute normal and position in world space
    vNormal = normalize(gl_NormalMatrix * gl_Normal);
    vPosition = vec3(gl_ModelViewMatrix * gl_Vertex);

    // Compute the vertex position in clip space
    gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;

    // Pass the texture coordinates to the fragment shader
    vTexCoord = gl_MultiTexCoord0.st;
}
