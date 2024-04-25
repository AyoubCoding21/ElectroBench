/**
 * @file
 * @brief Header file used in all ElectroBench projects, Licensed under the GNU GPL-3 License.
 */

#pragma once

// Libraries to include
#include <GL/glew.h>
#include <GL/freeglut.h>
#include <GL/glxew.h>
#include <stdio.h>
#include <stdlib.h>
#include <string>
#include <cstring>
#include <iostream>

#define HEIGHT 1440 // The window height.
#define WIDTH 2560  // The window width. 
#define NAME "ElectroBench" // The window name.

using namespace std;

GLuint vert, frag, program; // Vertex and Fragment shader IDs and Program ID.
float a = 0; // Rotation angle a. 
float b = 0; // Rotation angle b. 
double frame = 0, timet = 0, timebase = 0, fps = 0, ft = 0; // Frame and time-related variables. 
float lpos[4] = {1.2540, 0.5525420, 1.023453, 0.5}; // Light position. 

/**
 * Reads the contents of a text file.
 * @param filename The name of the file to read.
 * @return The content of the file.
 */
inline char* textFileRead(char* filename) {
    FILE* fp;
    char* content = NULL;
    int count = 0;

    if (filename != NULL) {
        fp = fopen(filename, "rt");

        if (fp != NULL) {
            fseek(fp, 0, SEEK_END);
            count = ftell(fp);
            rewind(fp);

            if (count > 0) {
                content = (char*)malloc(sizeof(char) * (count + 1));
                count = fread(content, sizeof(char), count, fp);
                content[count] = '\0';
            }
            fclose(fp);
        }
    }
    return content;
}

/**
 * Changes the size of the window.
 * @param w The new width.
 * @param h The new height.
 */
inline void changeSize(int w, int h) {
    if (h == 0)
        h = 1;

    float ratio = 1.0 * w / h;
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();

    glViewport(0, 0, w, h);
    gluPerspective(45, ratio, 1, 100);
    glMatrixMode(GL_MODELVIEW);
}

/**
 * Renders the teapot, measures FPS / FrameTime and rotates the teapot.
 */
inline void renderScene(void) {
    static int frame = 0;
    static int timebase = 0;
    static double fps = 0.0;
    static double ft = 0.0;

    frame++;
    int timet = glutGet(GLUT_ELAPSED_TIME);

    if (timet - timebase > 1000) {
        fps = frame * 1000.0 / (timet - timebase);
        timebase = timet;
        frame = 0;
        ft = 1 / fps;
        std::string str_fps = std::to_string(fps);
        std::string str_ft = std::to_string(ft);
        std::string title = "FPS : " + str_fps + " / Frame time : " + str_ft + " seconds";
        glutSetWindowTitle(title.c_str());
    }
    if (timet >= 20000) {
        printf("Benchmark Results - Score : %f\n", (fps*9)/ft);
        exit(0); 
    }
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnable(GL_MULTISAMPLE);
    glHint(GL_MULTISAMPLE_FILTER_HINT_NV, GL_NICEST);
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_CULL_FACE);
    glCullFace(GL_FRONT);
    glLoadIdentity();
    gluLookAt(0.0, 5.0, 5.0,
              0.0, 0.0, 0.0,
              0.0f, 1.0f, 0.0f);
    glRotatef(a, 12, 15, 9);
    glRotatef(b, 13, 14, 8);
    glutSolidTeapot(2.4);
    a += 1;
    b += 1.5;
    glutSwapBuffers();
}
/**
 * Processes keyboard input.
 * @param key The pressed key.
 * @param x The x-coordinate of the mouse.
 * @param y The y-coordinate of the mouse.
 */
inline void processKeys(unsigned char key, int x, int y) {
    if (key == 27)
        std::exit(0);
}

/**
 * Prints any OpenGL errors.
 * @return 1 if there are errors, 0 if there are none.
 */
#define printOpenGLError() printGLError(__FILE__, __LINE__)
inline int printGLError(char* file, int line) {
    GLenum glErr;
    int retCode = 0;

    glErr = glGetError();
    while (glErr != GL_NO_ERROR) {
        printf("glError in file %s @ line %d: %s\n", file, line, gluErrorString(glErr));
        retCode = 1;
        glErr = glGetError();
    }
    return retCode;
}

/**
 * Prints the compile info log for a shader.
 * @param object The shader object.
 */
inline void printShaderInfoLog(GLuint object) {
    int infologLength = 0;
    int charsWritten = 0;
    char* infoLog;

    glGetShaderiv(object, GL_INFO_LOG_LENGTH, &infologLength);

    if (infologLength > 0) {
        infoLog = (char*)malloc(infologLength);
        glGetShaderInfoLog(object, infologLength, &charsWritten, infoLog);
        printf("%s\n", infoLog);
        free(infoLog);
    }
}

/**
 * Prints the attaching info log for a shader program.
 * @param object The program object.
 */
inline void printProgramInfoLog(GLuint object) {
    int infologLength = 0;
    int charsWritten = 0;
    char* infoLog;

    glGetProgramiv(object, GL_INFO_LOG_LENGTH, &infologLength);

    if (infologLength > 0) {
        infoLog = (char*)malloc(infologLength);
        glGetProgramInfoLog(object, infologLength, &charsWritten, infoLog);
        printf("%s\n", infoLog);
        free(infoLog);
    }
}

/**
 * Sets up the shaders.
 */
inline void setShaders() {
    char* vs = NULL, *fs = NULL;

    vert = glCreateShader(GL_VERTEX_SHADER);
    frag = glCreateShader(GL_FRAGMENT_SHADER);

    vs = textFileRead("shaders/vert.glsl");
    fs = textFileRead("shaders/frag.glsl");

    const char* vv = vs;
    const char* ff = fs;

    glShaderSource(vert, 1, &vv, NULL);
    glShaderSource(frag, 1, &ff, NULL);

    free(vs);
    free(fs);

    glCompileShader(vert);
    glCompileShader(frag);

    printShaderInfoLog(vert);
    printShaderInfoLog(frag);

    program = glCreateProgram();
    glAttachShader(program, vert);
    glAttachShader(program, frag);

    glLinkProgram(program);
    printProgramInfoLog(program);
    glUseProgram(program);
}
