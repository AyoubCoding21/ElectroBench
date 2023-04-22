#version 120
varying vec3 normal;
varying vec3 lightDir;
varying vec3 viewDir;

void main()
{
	    vec4 ambient = gl_FrontMaterial.ambient *  gl_LightSource[0].ambient *  gl_LightSource[1].ambient * gl_LightSource[2].ambient * gl_LightSource[3].ambient * gl_BackMaterial.ambient;
	    vec4 diffuse = gl_FrontMaterial.diffuse * gl_LightSource[0].diffuse * gl_LightSource[1].diffuse * gl_LightSource[2].diffuse * gl_LightSource[3].diffuse * gl_BackMaterial.diffuse * max(dot(normal, lightDir), 0.0);
	    vec4 specular = gl_FrontMaterial.specular * gl_LightSource[0].specular * gl_LightSource[1].specular * gl_LightSource[2].specular * gl_LightSource[3].specular * gl_BackMaterial.specular * pow(max(dot(reflect(-lightDir, normal), viewDir), 0.0), gl_BackMaterial.shininess);
	    vec4 color = ambient + diffuse + specular;
	    float rim = 1.0 - dot(normalize(normal), normalize(viewDir));
	    rim = smoothstep(0.0, 0.5, rim);
	    vec4 rimColor = vec4(0.8, 0.3, 0.001, 1.0);
	    color.rgb = mix(color.rgb, rimColor.rgb, rim);
	    if (color.r <= 0.5) {
		color.r *= 1.0;
	    } 
	    else if (color.r >= 0.2)
	    {
		color.r += 0.9;
	    }
	    else if (color.g == 0.1)
	    {
		color.r *= 1.2;
	    }
	    else
	    {
		color.r += 0.6;
	    }
	    if (color.g <= 0.4) {
		color.g += 0.1;
	    } 
	    else if (color.g > 0.6)
	    {
		color.g *= 0.02;
	    }
	    else if (color.g == 0.1)
	    {
		color.g += 0.01;
	    }
	    else
	    {
		color.g += 0.3;
	    }
	    if (color.b < 0.1) {
		color.b += 0.1;
	    } 
	    else if (color.b > 0.2)
	    {
		color.b *= 0.3;
	    }
	    else
	    {
		color.b += 0.5;
	    }
	    gl_FragColor = color;
}
