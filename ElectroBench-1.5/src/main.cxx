#include <GL/glew.h>
#include <GL/freeglut.h>
#include <GL/glxew.h>
#include <stdio.h>
#include <stdlib.h>
#include <string>
#include <cstring>
#include <iostream>
char *textFileRead(char *fn) {


	FILE *fp;
	char *content = NULL;

	int count=0;

	if (fn != NULL) {
		fp = fopen(fn,"rt");

		if (fp != NULL) {

      fseek(fp, 0, SEEK_END);
      count = ftell(fp);
      rewind(fp);

			if (count > 0) {
				content = (char *)malloc(sizeof(char) * (count+1));
				count = fread(content,sizeof(char),count,fp);
				content[count] = '\0';
			}
			fclose(fp);
		}
	}
	return content;
}

GLuint v,f,f2,p;

float lpos[4] = {5.2540, 1.95, 6.55, 2.0};
float lpos2[4] = {2.5, 3.5525420, 1.453, 6.0};
float shininess[1] = {128.0f};
float specular[4] = {0.82546286, 0.1245, 0.5225, 1.0};
float ambient[4] = {0.555242247, 0.36521545, 0.212548, 1.0};
float diffuse[4] = {0.7245275842, 0.225, 0.5548, 1.0};
float diffuse2[4] = {0.452452, 0.31245, 0.311, 1.0};
float ambient2[4] = {0.898985, 0.545848, 0.288, 2.2};
float specular2[4] = {0.558458, 0.25589, 0.02585, 4.0};
float shininess2[1] = {128.0f};
void changeSize(int w, int h) {
	if(h == 0)
		h = 1;

	float ratio = 1.0* w / h;
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	
	glViewport(0, 0, w, h);
	gluPerspective(45,ratio,1,100);
	glMatrixMode(GL_MODELVIEW);
}

float a = 0;
float b = 0;
double frame=0,timet=0,timebase=0,fps=0,ft=0;

void renderScene(void)
{
	frame++;
	timet = glutGet(GLUT_ELAPSED_TIME);

	if (timet - timebase > 1000) {
		fps = frame*1000.0/(timet-timebase);
	 	timebase = timet;
		frame = 0;
		ft = 1/fps;
		std::string str_fps = std::to_string(fps);
		std::string str_ft = std::to_string(ft);
		std::string title = "FPS : " + str_fps + " / Frametime : " + str_ft;
		glutSetWindowTitle(title.c_str());
	}

	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

	glLoadIdentity();
	gluLookAt(0.0,5.0,5.0, 
		      0.0,0.0,0.0,
			  0.0f,1.0f,0.0f);
	glEnable(GL_LIGHTING_BIT);
	glEnable(GL_LIGHTING);
	glEnable(GL_LIGHT0);
	glEnable(GL_LIGHT1);
	glEnable(GL_MULTISAMPLE);

	glLightfv(GL_LIGHT0, GL_POSITION, lpos);
	glLightfv(GL_LIGHT0, GL_SHININESS, shininess);
	glLightfv(GL_LIGHT0, GL_SPECULAR, specular);
	glLightfv(GL_LIGHT0, GL_AMBIENT, ambient);
	glLightfv(GL_LIGHT0, GL_DIFFUSE, diffuse);
	glLightfv(GL_LIGHT1, GL_DIFFUSE, diffuse2);
	glLightfv(GL_LIGHT1, GL_AMBIENT, ambient2);
	glLightfv(GL_LIGHT1, GL_SPECULAR, specular2);
	glLightfv(GL_LIGHT1, GL_SHININESS, shininess2);

	glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT, ambient2);
	glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, specular2);
	glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE, diffuse);
	glMaterialfv(GL_FRONT_AND_BACK, GL_SHININESS, shininess2);
	
	glRotatef(a,6,5,9);
	glRotatef(b,6,10,8);
	glutSolidTeapot(2.4);
	a+=1;
	b+=0.5;

	glutSwapBuffers();
}

void processNormalKeys(unsigned char key, int x, int y) {

	if (key == 27) 
		exit(0);
}

#define printOpenGLError() printOglError(__FILE__, __LINE__)

int printOglError(char *file, int line)
{
    GLenum glErr;
    int    retCode = 0;

    glErr = glGetError();
    while (glErr != GL_NO_ERROR)
    {
        printf("glError in file %s @ line %d: %s\n", file, line, gluErrorString(glErr));
        retCode = 1;
        glErr = glGetError();
    }
    return retCode;
}


void printShaderInfoLog(GLuint obj)
{
    int infologLength = 0;
    int charsWritten  = 0;
    char *infoLog;

	glGetShaderiv(obj, GL_INFO_LOG_LENGTH,&infologLength);

    if (infologLength > 0)
    {
        infoLog = (char *)malloc(infologLength);
        glGetShaderInfoLog(obj, infologLength, &charsWritten, infoLog);
		printf("%s\n",infoLog);
        free(infoLog);
    }
}

void printProgramInfoLog(GLuint obj)
{
    int infologLength = 0;
    int charsWritten  = 0;
    char *infoLog;

	glGetProgramiv(obj, GL_INFO_LOG_LENGTH,&infologLength);

    if (infologLength > 0)
    {
        infoLog = (char *)malloc(infologLength);
        glGetProgramInfoLog(obj, infologLength, &charsWritten, infoLog);
		printf("%s\n",infoLog);
        free(infoLog);
    }
}



void setShaders() 
{

	char *vs = NULL,*fs = NULL;

	v = glCreateShader(GL_VERTEX_SHADER);
	f = glCreateShader(GL_FRAGMENT_SHADER);

	vs = textFileRead("shaders/vert.glsl");
	fs = textFileRead("shaders/frag.glsl");

	const char * vv = vs;
	const char * ff = fs;

	glShaderSource(v, 1, &vv,NULL);
	glShaderSource(f, 1, &ff,NULL);

	free(vs);free(fs);

	glCompileShader(v);
	glCompileShader(f);

	printShaderInfoLog(v);
	printShaderInfoLog(f);
	printShaderInfoLog(f2);

	p = glCreateProgram();
	glAttachShader(p,v);
	glAttachShader(p,f);

	glLinkProgram(p);
	printProgramInfoLog(p);

	glUseProgram(p);
}

int main(int argc, char **argv) {
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_DEPTH | GLUT_DOUBLE | GLUT_RGBA | GLUT_MULTISAMPLE);
	glutInitWindowSize(1280, 1024);
	glutCreateWindow("ElectroBench");

	glutDisplayFunc(renderScene);
	glutIdleFunc(renderScene);
	glutReshapeFunc(changeSize);
	glutKeyboardFunc(processNormalKeys);

	glClearColor(0.0,0.0,0.0,1.0);

	glewInit();
	glxewInit();
	glXSwapIntervalMESA(0);
	if (glewIsSupported("GL_VERSION_2_0"))
		printf("Ready for OpenGL 2.0\n");
	else {
		printf("OpenGL 2.0 not supported\n");
		exit(1);
	}

	setShaders();
	glutSetOption(GLUT_MULTISAMPLE, 8);
	glutMainLoop();

	return 0;
}
