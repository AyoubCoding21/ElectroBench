#pragma once
#include <GL/glew.h>
#include <GL/freeglut.h>
#include <GL/glxew.h>
#include <stdio.h>
#include <stdlib.h>
#include <string>
#include <cstring>
#include <iostream>
#define HEIGHT 1440 
#define WIDTH 2560
#define NAME "ElectroBench"
using namespace std;
GLuint vert, frag, program;
float a = 0;
float b = 0;
double frame=0,timet=0,timebase=0,fps=0,ft=0;
float lpos[4] = {1.2540,0.5525420,1.023453,0.5};
inline char *textFileRead(char *filename)
{
    
	FILE *fp;
	char *content = NULL;

	int count=0;

	if (filename != NULL) {
		fp = fopen(filename,"rt");

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
inline void changeSize(int w, int h) {
	if(h == 0)
		h = 1;

	float ratio = 1.0* w / h;
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	
	glViewport(0, 0, w, h);
	gluPerspective(45,ratio,1,100);
	glMatrixMode(GL_MODELVIEW);
}
inline void renderScene(void)
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
		std::string title = "FPS : " + str_fps + " / Frametime : " + str_ft + "s";
		glutSetWindowTitle(title.c_str());
	}

	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
        glEnable(GL_MULTISAMPLE);
        glHint(GL_MULTISAMPLE_FILTER_HINT_NV, GL_NICEST);
        glEnable(GL_DEPTH_TEST);
        glEnable(GL_CULL_FACE);
        glCullFace(GL_FRONT);
	glLoadIdentity();
	gluLookAt(0.0,5.0,5.0, 
		      0.0,0.0,0.0,
			  0.0f,1.0f,0.0f);
	glRotatef(a,12,15,9);
	glRotatef(b,13,14,8);
	glutSolidTeapot(2.4);
	a+=1;
	b+=1.5;

	glutSwapBuffers();
}
inline void processKeys(unsigned char key, int x, int y) {
	if (key == 27) 
		std::exit(0);
}
#define printOpenGLError() printGLError(__FILE__, __LINE__)
inline int printGLError(char *file, int line)
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
inline void printShaderInfoLog(GLuint object)
{
    int infologLength = 0;
    int charsWritten  = 0;
    char *infoLog;

	glGetShaderiv(object, GL_INFO_LOG_LENGTH,&infologLength);

    if (infologLength > 0)
    {
        infoLog = (char *)malloc(infologLength);
        glGetShaderInfoLog(object, infologLength, &charsWritten, infoLog);
		printf("%s\n",infoLog);
        free(infoLog);
    }
}
inline void printProgramInfoLog(GLuint object)
{
    int infologLength = 0;
    int charsWritten  = 0;
    char *infoLog;

	glGetProgramiv(object, GL_INFO_LOG_LENGTH,&infologLength);

    if (infologLength > 0)
    {
        infoLog = (char *)malloc(infologLength);
        glGetProgramInfoLog(object, infologLength, &charsWritten, infoLog);
		printf("%s\n",infoLog);
        free(infoLog);
    }
}
inline void setShaders() 
{

	char *vs = NULL,*fs = NULL;

	vert = glCreateShader(GL_VERTEX_SHADER);
	frag = glCreateShader(GL_FRAGMENT_SHADER);

	vs = textFileRead("shaders/vert.glsl");
	fs = textFileRead("shaders/frag.glsl");

	const char *vv = vs;
	const char *ff = fs;

	glShaderSource(vert, 1, &vv,NULL);
	glShaderSource(frag, 1, &ff,NULL);

	free(vs);free(fs);

	glCompileShader(vert);
	glCompileShader(frag);

	printShaderInfoLog(vert);
	printShaderInfoLog(frag);

	program = glCreateProgram();
	glAttachShader(program, vert);
	glAttachShader(program ,frag);

	glLinkProgram(program);
	printProgramInfoLog(program);
	glUseProgram(program);

}
