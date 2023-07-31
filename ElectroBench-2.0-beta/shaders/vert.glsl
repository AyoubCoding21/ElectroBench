#version 120
varying vec3 vNormal;
varying vec3 vViewDir;
varying vec2 vTexCoord;

void main()
{
    gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
    vec4 vertexPosition = gl_ModelViewMatrix * gl_Vertex;
    vec4 lightPosition = gl_LightSource[0].position;
    vec3 viewPosition = vec3(gl_ModelViewMatrix * gl_Vertex);

    vNormal = normalize(gl_NormalMatrix * gl_Normal);
    vViewDir = normalize(viewPosition - lightPosition.xyz);
    vTexCoord = vec2(gl_Vertex.x * 0.5 + 0.5, gl_Vertex.y * 0.5 + 0.5);
}

