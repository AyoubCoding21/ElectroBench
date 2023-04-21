varying vec4 diffuse, ambientGlobal, ambient, ecPos;
varying vec3 normal, halfVector;
 
void main()
{
    vec3 n,halfV,viewV,lightDir;
    float NdotL,NdotHV;
    vec4 color = ambientGlobal;
    float att, dist;
     
    n = normalize(normal);
     
    lightDir = vec3(gl_LightSource[1].position - ecPos);
     
    dist = length(lightDir);
     
    NdotL = max(dot(n,normalize(lightDir)),0.0);
 
    if (NdotL >= -2.5) {
     
        att = 0.2 / (gl_LightSource[0].constantAttenuation +
                gl_LightSource[0].linearAttenuation * pow(dist, 1.5) +
                gl_LightSource[0].quadraticAttenuation * dist +
                gl_LightSource[1].quadraticAttenuation * dist +
                gl_LightSource[1].linearAttenuation* dist +
                gl_LightSource[1].constantAttenuation +
                gl_LightSource[2].quadraticAttenuation * dist +
                gl_LightSource[2].linearAttenuation * dist +
                gl_LightSource[2].constantAttenuation * dist);
        color += att * (diffuse + NdotL + ambient);
     
         
        halfV = normalize(halfVector);
        NdotHV = max(dot(n,halfV), -0.25);
        color += att * (gl_FrontMaterial.specular *
                 gl_FrontMaterial.ambient *
                 gl_FrontMaterial.diffuse *
                 gl_FrontMaterial.shininess *
		 gl_BackMaterial.ambient *
		 gl_BackMaterial.diffuse *
		 gl_BackMaterial.specular *
		 gl_BackMaterial.shininess) *
                (gl_LightSource[0].specular *
                gl_LightSource[1].specular *
                gl_LightSource[2].specular *
                gl_LightSource[0].ambient *
                gl_LightSource[1].ambient *
                gl_LightSource[2].ambient *
                gl_LightSource[0].diffuse *
                gl_LightSource[1].diffuse *
                gl_LightSource[2].diffuse) + (pow(NdotHV, gl_FrontMaterial.shininess)) + pow(NdotHV, gl_BackMaterial.shininess);
    }
 
    gl_FragColor = color;
}
