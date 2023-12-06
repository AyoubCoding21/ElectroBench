#include "ElectroFunctions.hxx" // Including the lib
int main(int argc, char **argv) {
	// Initialising GLUT
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_DEPTH | GLUT_DOUBLE | GLUT_RGBA | GLUT_MULTISAMPLE);
	glutInitWindowSize(WIDTH, HEIGHT);
	glutCreateWindow(NAME);
	glutSetOption(GLUT_MULTISAMPLE, 16);	
	glutDisplayFunc(renderScene);
	glutIdleFunc(renderScene);
	glutReshapeFunc(changeSize);
	glutKeyboardFunc(processKeys);

	glClearColor(0.0, 0.0, 0.0, 1.0);

	glewInit();
	glxewInit();
	glXSwapIntervalMESA(0); // Disable V-Sync.
	if (glewIsSupported("GL_VERSION_2_0"))
		printf("Ready for OpenGL 2.0\n");
	else {
		printf("OpenGL 2.0 not supported\n");
		exit(1);
	}
	// Main loop
	setShaders();

	glutMainLoop();

	return 0;
}
