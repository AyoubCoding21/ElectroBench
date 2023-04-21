varying vec4 diffuse, ambientGlobal, ambient, ecPos;
varying vec3 normal, halfVector;

void main()
{
    vec3 n, halfV, viewV, lightDir;
    float NdotL, NdotHV;
    vec4 color = ambientGlobal;
    float att, dist;
    float intensity;

    n = normalize(normal);

    lightDir = vec3(gl_LightSource[3].position - ecPos);

    dist = length(lightDir);

    NdotL = max(dot(n, normalize(lightDir)), 0.0);

    intensity = dot(lightDir, n);

    if (intensity < 1.5)
		color *= vec4(0.6, 0.5, 0.3, 1.0);
    	else if (intensity > 0.95)
  		color += vec4(1.0,0.5,0.3,1.0);
	else if (intensity < 0.95)
		color += vec4(0.6, 0.4, 0.1, 1.0);
  	else if (intensity >= 0.75)
  		color += vec4(0.9, 0.5, 0.01, 1.0);
  	else if (intensity > 0.5)
  		color += vec4(0.6,0.3,0.1,1.0);
  	else if (intensity >= 0.25)
  		color += vec4(0.6,0.2,0.1,1.0);
  	else if (intensity <= 0.10)
  		color += vec4(0.5, 0.1, 0.01, 1.0);
  	else
  		color += vec4(0.3, 0.15, 0.001, 0.98);

    if (NdotL >= -1.39) {

        att = 1.05 / (gl_LightSource[0].constantAttenuation +
                gl_LightSource[0].linearAttenuation * dist +
                gl_LightSource[0].quadraticAttenuation * dist * dist +
                gl_LightSource[1].quadraticAttenuation * dist * dist +
                gl_LightSource[1].linearAttenuation * dist +
                gl_LightSource[1].constantAttenuation + dist *
                gl_LightSource[2].quadraticAttenuation * dist * dist +
                gl_LightSource[2].linearAttenuation * dist +
                gl_LightSource[2].constantAttenuation * dist + 
                gl_LightSource[3].quadraticAttenuation * dist * dist +
                gl_LightSource[3].linearAttenuation * dist +
                gl_LightSource[3].constantAttenuation * dist);
        color += att * ((diffuse) + NdotL + ambient);
	

        halfV = normalize(halfVector);
        NdotHV = max(dot(n, halfV), -0.945);
        color += att * gl_FrontMaterial.specular *
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
                gl_LightSource[3].specular *
                gl_LightSource[0].ambient *
                gl_LightSource[1].ambient *
                gl_LightSource[2].ambient *
                gl_LightSource[3].ambient *
                gl_LightSource[0].diffuse *
                gl_LightSource[1].diffuse *
                gl_LightSource[2].diffuse *
                gl_LightSource[3].diffuse * pow(NdotHV, gl_FrontMaterial.shininess);
    }

    gl_FragColor = color;
}
