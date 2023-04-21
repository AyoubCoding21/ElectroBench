varying vec4 diffuse,ambient;
varying vec3 normal,halfVector;
 
void main()
{
    vec3 n,halfV,lightDir;
    float NdotL,NdotHV;
 
    lightDir = vec3(gl_LightSource[2].position);
 
    vec4 color = ambient;
    n = normalize(normal);
    NdotL = max(dot(n,lightDir),0.0);
    if (NdotL > 0.0) {
        color += diffuse * NdotL;
        halfV = normalize(halfVector);
        NdotHV = max(dot(n,halfV),0.0);
        color += gl_FrontMaterial.specular *
                 gl_BackMaterial.specular *
                 gl_FrontMaterial.ambient *
                 gl_BackMaterial.ambient *
                 gl_FrontMaterial.diffuse *
                 gl_BackMaterial.diffuse *
                 gl_FrontMaterial.shininess *
                 gl_BackMaterial.shininess *
                gl_LightSource[0].specular *
                gl_LightSource[1].specular *
                gl_LightSource[2].specular *
                gl_LightSource[0].ambient *
                gl_LightSource[1].ambient *
                gl_LightSource[2].ambient *
                gl_LightSource[0].diffuse *
                gl_LightSource[1].diffuse *
                gl_LightSource[2].diffuse *
                pow(NdotHV, gl_FrontMaterial.shininess);
    }
 
    gl_FragColor = color;
}
