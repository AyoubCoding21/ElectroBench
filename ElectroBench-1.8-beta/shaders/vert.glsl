#version 120
varying vec3 vNormal;
varying vec3 vPosition;
varying vec3 vLightDir[31];
varying vec2 vTextureCoord;

void main() {
    vPosition = vec3(gl_ModelViewMatrix * gl_Vertex);
    vNormal = normalize(gl_NormalMatrix * gl_Normal);
    vTextureCoord = vec2(gl_MultiTexCoord0);
    vTextureCoord *= vec2(10.0);
    vTextureCoord = fract(vTextureCoord);
    vTextureCoord = mix(vTextureCoord, 1.0 - vTextureCoord, step(0.5, vTextureCoord));

    for (int i = 0; i < 31; i++) {
        vLightDir[i] = normalize(vec3(gl_LightSource[i].position.xyz - vPosition));
    }
    gl_Position = ftransform();
}
