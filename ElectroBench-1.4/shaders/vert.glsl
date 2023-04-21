#version 120
varying vec3 vNormal;
varying vec3 vViewDir;

void main() {
	  gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
	  vNormal = normalize(gl_NormalMatrix * gl_Normal);
	  vViewDir = normalize(-gl_Position.xyz);
}
