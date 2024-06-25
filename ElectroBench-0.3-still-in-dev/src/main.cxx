// Libraries to include

#include <GL/glew.h>
#include <GL/gl.h>
#include <GL/freeglut.h>
#include <GL/freeglut_std.h>
#include "obj.hxx"
#include <GL/glxew.h> // This only really works on windows

#include <array>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <ctime>
#include <fstream>
#include <iostream>
#include <iterator>
#include <string>

#define NAME "ElectroBench" // The window name.


// Anonymous namespace
namespace
{
  void initialiseWindow(int argc, char** argv)
  {
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DEPTH | GLUT_DOUBLE | GLUT_RGBA | GLUT_MULTISAMPLE);
    glutInitWindowSize(WIDTH, HEIGHT);
    glutCreateWindow(NAME);
    glEnable(GL_MULTISAMPLE);
    glHint(GL_MULTISAMPLE_FILTER_HINT_NV, GL_NICEST);
    glutSetOption(GLUT_MULTISAMPLE, 8);
  }
} // namespace

// Global variables
GLuint vert, frag, program;
float a = 0.0f, b = 0.0f;
float pos_x, pos_y, pos_z;
float angle_x = 30.0f, angle_y = 0.0f;
int init_time = time(NULL), final_time, frame;
int fps;
int x_old = 0, y_old = 0;
int current_scroll = 5;
float zoom_per_scroll;
std::string model_name = "src/Teapot.obj";

bool is_holding_mouse = false;
bool is_updated = false;

Model model;

// Reads the contents of a text file.
std::string textFileRead(std::string const& filename) {
  if (!filename.empty())
  {
    std::fstream file{filename};
    return {(std::istreambuf_iterator<char>(file)), std::istreambuf_iterator<char>()};
  }

  return {};
}

// Changes the size of the window.
void changeSize(int w, int h) {
  if (h == 0)
    h = 1;

  float ratio = 1.0 * w / h;
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();

  glViewport(0, 0, w, h);
  gluPerspective(45, ratio, 1, 100);
  glMatrixMode(GL_MODELVIEW);
}

// Renders the teapot, measures FPS / FrameTime and rotates the teapot.
void renderScene(void) {
  int timet = glutGet(GLUT_ELAPSED_TIME);

  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
  glLoadIdentity();
  glTranslatef(pos_x, pos_y, pos_z);

  glRotatef(angle_x, 1.0f, 0.0f, 0.0f);
  glRotatef(angle_y, 0.0f, 1.0f, 0.0f);
  glRotatef(a, 3.0f, 2.0f, 5.0f);
  glRotatef(b, 2.0f, 4.0f, 3.0f);
  model.draw();
  glutSwapBuffers();
  frame++;
  a++;
  b++;
  final_time = time(NULL);
  if(final_time - init_time > 0)
  {
    char title[256];
    fps = frame / (final_time - init_time);
    snprintf(title, 256, "ElectroBench - FPS : %d\n", fps);
    glutSetWindowTitle(title);
    frame = 0;
    init_time = final_time;
  }
  if (timet >= 45000) {
    printf("Benchmark Results - Score : %f\n", (fps * 5) / (1.01/fps));
    exit(0);
  }
}

// Processes keyboard input.
void processKeys(unsigned char key, int x, int y) {
  if (key == 27)
    exit(0);
}

// Prints any OpenGL errors.
#define printOpenGLError() printGLError(__FILE__, __LINE__)
int printGLError(const char *file, int line) {
  GLenum glErr;
  int retCode = 0;

  glErr = glGetError();
  while (glErr != GL_NO_ERROR) {
    printf("glError in file %s @ line %d: %s\n", file, line,
           gluErrorString(glErr));
    retCode = 1;
    glErr = glGetError();
  }
  return retCode;
}

// Prints the compile info log for a shader.
void printShaderInfoLog(GLuint object) {
  constexpr std::size_t MAX_LOG_LENGTH = 100;
  std::array<char, MAX_LOG_LENGTH> log_buffer{};

  int infologLength = 0;
  glGetShaderiv(object, GL_INFO_LOG_LENGTH, &infologLength);

  if (infologLength > 0) {
    int charsWritten = 0;
    glGetShaderInfoLog(object, MAX_LOG_LENGTH, &charsWritten, log_buffer.data());
    printf("%s\n", log_buffer.data());
  }
}

// Prints the attaching info log for a shader program.
void printProgramInfoLog(GLuint object) {
  int infologLength = 0;
  int charsWritten = 0;
  char *infoLog;

  glGetProgramiv(object, GL_INFO_LOG_LENGTH, &infologLength);

  if (infologLength > 0) {
    infoLog = (char *)malloc(infologLength);
    glGetProgramInfoLog(object, infologLength, &charsWritten, infoLog);
    printf("%s\n", infoLog);
    free(infoLog);
  }
}

void timer(int value) {
    if (is_updated) {
        is_updated = false;
        glutPostRedisplay();
    }
    glutTimerFunc(INTERVAL, timer, 0);
}

void mouse(int button, int state, int x, int y) {
    is_updated = true;

    if (button == GLUT_LEFT_BUTTON) {
        if (state == GLUT_DOWN) {
            x_old = x;
            y_old = y;
            is_holding_mouse = true;
        } else
            is_holding_mouse = false;
    } else if (state == GLUT_UP) {
        switch (button) {
        case 3:
            if (current_scroll > 0) {
                current_scroll--;
                pos_z += zoom_per_scroll;
            }
            break;
        case 4:
            if (current_scroll < 18) {
                current_scroll++;
                pos_z -= zoom_per_scroll;
            }
            break;
        }
    }
}

void motion(int x, int y) {
    if (is_holding_mouse) {
        is_updated = true;

        angle_y += (x - x_old);
        x_old = x;
        if (angle_y > 360.0f)
            angle_y -= 360.0f;
        else if (angle_y < 0.0f)
            angle_y += 360.0f;

        angle_x += (y - y_old);
        y_old = y;
        if (angle_x > 90.0f)
            angle_x = 90.0f;
        else if (angle_x < -90.0f)
            angle_x = -90.0f;
    }
}

/*
 * Initialises the application.
 * Compiles shaders and sets up attributes and loads the obj file.
*/
void init() {

  // Do check if you don't have a 0-id
  GLuint vert = glCreateShader(GL_VERTEX_SHADER);
  if (vert == 0)
  {
    // Log something and then exit
    std::terminate();
  }
  GLuint frag = glCreateShader(GL_FRAGMENT_SHADER);
  if (frag == 0)
  {
    // Log something and the exit
    std::terminate();
  }

  std::string const vs = textFileRead("shaders/vert.glsl");
  std::string const fs = textFileRead("shaders/frag.glsl");

  const char* vs_ptr = vs.data();
  const char* fs_ptr = fs.data();
  glShaderSource(vert, 1, &vs_ptr, NULL);
  glShaderSource(frag, 1, &fs_ptr, NULL);

  glCompileShader(vert);
  glCompileShader(frag);

  printShaderInfoLog(vert);
  printShaderInfoLog(frag);

  GLuint program = glCreateProgram();
  glAttachShader(program, vert);
  glAttachShader(program, frag);

  glLinkProgram(program);
  printProgramInfoLog(program);

  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();
  gluPerspective(20.0, 1.0, 1.0, 2000.0);
  glMatrixMode(GL_MODELVIEW);
  glEnable(GL_BLEND);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  glEnable(GL_LINE_SMOOTH);
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
  glEnable(GL_TEXTURE_2D);
  glEnable(GL_DEPTH_TEST);
  model.load(model_name.c_str());
  pos_x = model.pos_x;
  pos_y = model.pos_y;
  pos_z = model.pos_z - 1.0f;
  zoom_per_scroll = -model.pos_z / 8.0f;

  GLint textureLocation = glGetUniformLocation(program, "uTexture");
  glUniform1i(textureLocation, 0);
  glUseProgram(program);
  glActiveTexture(GL_TEXTURE0);
  glBindTexture(GL_TEXTURE_2D, model.m->texture);
}


int main(int argc, char **argv) {
  // Initialising GLUT
  
  // Create a separate function and name it something like
  initialiseWindow(argc, argv);

  glClearColor(0.2, 0.1, 0.01, 1.0);

  glewInit();
  glxewInit();
  glXSwapIntervalMESA(0); // Disable V-Sync.
  if (glewIsSupported("GL_VERSION_2_0"))
    printf("Ready for OpenGL 2.0\n");
  else {
    printf("OpenGL 2.0 not supported\n");
    exit(1);
  }

  init();

  glutDisplayFunc(renderScene);
  glutIdleFunc(renderScene);
  glutReshapeFunc(changeSize);
  glutKeyboardFunc(processKeys);

  glutMouseFunc(mouse);
  glutMotionFunc(motion);
  glutTimerFunc(0, timer, 0);
  // Main loop
  glutMainLoop();

  return 0;
}
