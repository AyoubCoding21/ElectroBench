#version 120
varying vec3 vNormal;
varying vec3 vViewDir;

void main() {
	  vec4 ambientColor = gl_FrontMaterial.ambient *  gl_LightSource[0].ambient * gl_LightSource[1].ambient * gl_BackMaterial.ambient;
	  vec4 diffuseColor = gl_FrontMaterial.diffuse * gl_LightSource[0].diffuse * gl_LightSource[1].diffuse * gl_BackMaterial.diffuse * max(0.0, dot(vNormal, normalize(gl_LightSource[0].position.xyz)));
	  vec3 reflectDir = reflect(-normalize(gl_LightSource[0].position.xyz), vNormal);
	  vec4 specularColor = gl_FrontMaterial.specular * gl_LightSource[0].specular * gl_LightSource[1].specular * gl_BackMaterial.specular * pow(max(0.0, dot(reflectDir, vViewDir)), gl_FrontMaterial.shininess);
	  vec4 finalColor = ambientColor + diffuseColor + specularColor;
	  float rim = 1.0 - dot(normalize(vNormal), normalize(vViewDir));
	  rim = smoothstep(0.0, 0.5, rim);
	  vec4 rimColor = vec4(0.7, 0.4, 0.1, 1.0);
	  finalColor.rgb = mix(finalColor.rgb, rimColor.rgb, rim);
	  gl_FragColor = finalColor;
}
