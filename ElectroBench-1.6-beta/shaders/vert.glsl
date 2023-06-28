#version 120
varying vec3 vNormal;
varying vec3 vPosition;
varying vec3 vViewDir;

void main()
{
    vNormal = normalize(gl_NormalMatrix * gl_Normal);
    vPosition = vec3(gl_ModelViewMatrix * gl_Vertex);
    vViewDir = normalize(-vPosition);
    gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
}
