varying vec4 diffuse, ambientGlobal, ambient, ecPos;
varying vec3 normal, halfVector;

void main()
{
    vec3 aux;
    normal = normalize(gl_NormalMatrix * gl_Normal);

    ecPos = gl_ModelViewMatrix * gl_Vertex;

    halfVector = gl_LightSource[2].halfVector.xyz;

		diffuse = gl_FrontMaterial.diffuse * gl_LightSource[0].diffuse * gl_LightSource[2].diffuse * gl_LightSource[1].diffuse * gl_LightSource[3].diffuse * gl_BackMaterial.diffuse;
		ambient = gl_FrontMaterial.ambient * gl_LightSource[0].ambient * gl_LightSource[1].ambient * gl_LightSource[2].ambient * gl_LightSource[3].ambient * gl_BackMaterial.ambient;
		ambientGlobal = gl_LightModel.ambient * gl_FrontMaterial.ambient * gl_BackMaterial.ambient;


    gl_Position = ftransform();
}
