#version 120
varying vec3 lightDir,normal;

void main()
{

	float intensity;
	vec4 color;

	vec3 n = normalize(normal);

	intensity = dot(lightDir,n);

	if (intensity > 0.95)
		color = vec4(1.0,0.5,0.3,1.0);
	else if (intensity >= 0.75)
		color = vec4(0.9, 0.5, 0.01, 1.0);
	else if (intensity > 0.5)
		color = vec4(0.6,0.3,0.1,1.0);
	else if (intensity >= 0.25)
		color = vec4(0.6,0.2,0.1,1.0);
	else if (intensity <= 0.10)
		color = vec4(0.5, 0.1, 0.01, 1.0);
	else
		color = vec4(0.2,0.1,0.1,1.0);

	gl_FragColor = color;
}

