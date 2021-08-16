/*! \file    shapes.c
    \ingroup demos

    This program is a test harness for the various shapes
    in OpenGLUT.  It may also be useful for understanding how
    parameters control behavior in the OpenGLUT objects.

    Spinning wireframe and solid-shaded shapes are
    displayed.

    Keys:
      -    <tt>Esc &nbsp;</tt> Quit
      -    <tt>q Q &nbsp;</tt> Quit
      -    <tt>= + &nbsp;</tt> Increase \a slices
      -    <tt>- _ &nbsp;</tt> Decreate \a slices
      -    <tt>, < &nbsp;</tt> Decreate \a stacks
      -    <tt>. > &nbsp;</tt> Increase \a stacks
      -    <tt>9 ( &nbsp;</tt> Decreate \a depth  (Sierpinski Sponge)
      -    <tt>0 ) &nbsp;</tt> Increase \a depth  (Sierpinski Sponge)
      -    <tt>up&nbsp; &nbsp;</tt> Increase "outer radius"
      -    <tt>down&nbsp;</tt> Decrease "outer radius"
      -    <tt>left&nbsp;</tt> Decrease "inner radius"
      -    <tt>right</tt> Increase "inner radius"
      -    <tt>PgUp&nbsp;</tt> Next shape-drawing function
      -    <tt>PgDn&nbsp;</tt> Prev shape-drawing function

    \author  Written by Nigel Stewart November 2003

    \author  Portions Copyright (C) 2004, the OpenGLUT project contributors. \n
             OpenGLUT branched from freeglut in February, 2004.

    \image   html openglut_shapes.png OpenGLUT Geometric Shapes Demonstration
    \include demos/shapes/shapes.c
*/
#ifdef _MSC_VER
#include <openglut.h>
#else
#include <GL/openglut.h>
#endif

#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>

#ifdef  _MSC_VER
#include "resource.h"
#endif

/*
 * This macro is only intended to be used on arrays, of course.
 */
#define NUMBEROF(x) ((sizeof(x))/(sizeof(x[0])))

/*
 * These global variables control which object is drawn,
 * and how it is drawn.  No object uses all of these
 * variables.
 */
static int function_index;
static int slices = 16;
static int stacks = 16;
static double irad = .25;
static double orad = 1.0;
static int depth = 4;
static const double offset[ 3 ] = { 0, 0, 0 };

/*
 * These one-liners draw particular objects, fetching appropriate
 * information from the above globals.  They are just thin wrappers
 * for the OpenGLUT objects.
 */

static void drawSolidTetrahedron(void) {
  glutSolidTetrahedron();
}
static void drawWireTetrahedron(void) {
  glutWireTetrahedron();
}
static void drawSolidCube(void) {
  glutSolidCube(1);
}
static void drawWireCube(void) {
  glutWireCube(1);
}
static void drawSolidOctahedron(void) {
  glutSolidOctahedron();
}
static void drawWireOctahedron(void) {
  glutWireOctahedron();
}
static void drawSolidDodecahedron(void) {
  glutSolidDodecahedron();
}
static void drawWireDodecahedron(void) {
  glutWireDodecahedron();
}
static void drawSolidRhombicDodecahedron(void) {
  glutSolidRhombicDodecahedron();
}
static void drawWireRhombicDodecahedron(void) {
  glutWireRhombicDodecahedron();
}
static void drawSolidIcosahedron(void) {
  glutSolidIcosahedron();
}
static void drawWireIcosahedron(void) {
  glutWireIcosahedron();
}
static void drawSolidSierpinskiSponge(void) {
  glutSolidSierpinskiSponge(depth, offset, 1);
}
static void drawWireSierpinskiSponge(void) {
  glutWireSierpinskiSponge(depth, offset, 1);
}
static void drawSolidTeapot(void) {
  glutSolidTeapot(1);
}
static void drawWireTeapot(void) {
  glutWireTeapot(1);
}
static void drawSolidTorus(void) {
  glutSolidTorus(irad,orad,slices,stacks);
}
static void drawWireTorus(void) {
  glutWireTorus(irad,orad,slices,stacks);
}
static void drawSolidSphere(void) {
  glutSolidSphere(1,slices,stacks);
}
static void drawWireSphere(void) {
  glutWireSphere(1,slices,stacks);
}
static void drawSolidCone(void) {
  glutSolidCone(1,1,slices,stacks);
}
static void drawWireCone(void) {
  glutWireCone(1,1,slices,stacks);
}
static void drawSolidCylinder(void) {
  glutSolidCylinder(1,1,slices,stacks);
}
static void drawWireCylinder(void) {
  glutWireCylinder(1,1,slices,stacks);
}

/*
 * This structure defines an entry in our function-table.
 */
typedef struct {
  const char *const name;
  void (*solid)(void);
  void (*wire)(void);
} entry;

#define ENTRY(e) {#e, drawSolid##e, drawWire##e}
static const entry table [] = {
  ENTRY(Tetrahedron),
  ENTRY(Cube),
  ENTRY(Octahedron),
  ENTRY(Dodecahedron),
  ENTRY(RhombicDodecahedron),
  ENTRY(Icosahedron),
  ENTRY(SierpinskiSponge),
  ENTRY(Teapot),
  ENTRY(Torus),
  ENTRY(Sphere),
  ENTRY(Cone),
  ENTRY(Cylinder)
};
#undef ENTRY

/*!
    Does printf()-like work using freeglut/OpenGLUT
    glutBitmapString().  Uses a fixed font.  Prints
    at the indicated row/column position.

    Limitation: Cannot address pixels.
    Limitation: Renders in screen coords, not model coords.

    \note Uses a fixed, 256-byte array for holding strings.
          The best way around this would be to use vasprintf(),
          but that is not available on WIN32, I believe.
          Another alternative would be to write our own formatter
          from scratch and emit the characters one at a time to
          the GLUT bitmap single-character drawing routine.
          We could also use vsnprintf(), but I'm not sure if
          that is standard...
*/
static void shapesPrintf(int row, int col, const char *fmt, ...) {
  static char buf[256];
  int viewport[4];
  void *font = GLUT_BITMAP_9_BY_15;
  va_list args;

  va_start(args, fmt);
  (void) vsprintf(buf, fmt, args);
  va_end(args);

  glGetIntegerv(GL_VIEWPORT,viewport);

  glPushMatrix();
  glLoadIdentity();

  glMatrixMode(GL_PROJECTION);
  glPushMatrix();
  glLoadIdentity();

  glOrtho(0,viewport[2],0,viewport[3],-1,1);

  glRasterPos2i(
    glutBitmapWidth(font, ' ') * col,
    - glutBitmapHeight(font) * (row+2) + viewport[3]
  );
  glutBitmapString(font, (unsigned char *) buf);

  glPopMatrix();
  glMatrixMode(GL_MODELVIEW);
  glPopMatrix();
}

/* GLUT callback Handlers */

static void
resize(int width, int height) {
  const float ar = (float) width / (float) height;

  glViewport(0, 0, width, height);

  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();
  if(ar > .5) {
    glFrustum(-ar, ar, -1.0, 1.0, 2.0, 100.0);
  }
  else {
    glFrustum(-1.0, 1.0, -1/ar, 1/ar, 2.0, 100.0);
  }
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity() ;
}

static void
display(void) {
  const double t = glutGet(GLUT_ELAPSED_TIME) / 1000.0;
  const double a = t*90.0;

  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

  glEnable(GL_LIGHTING);

  glColor3d(1,2,0);

  glPushMatrix();
  glTranslated(0,1.2,-6);
  glRotated(60,1,0,0);
  glRotated(a,0,0,1);
  table [function_index].solid();
  glPopMatrix();

  glPushMatrix();
  glTranslated(0,-1.2,-6);
  glRotated(60,1,0,0);
  glRotated(a,0,0,1);
  table [function_index].wire();
  glPopMatrix();

  glDisable(GL_LIGHTING);
  glColor3d(0.1,0.1,0.4);

  shapesPrintf(1, 3, "Shape PgUp PgDn: %s", table [function_index].name);
  shapesPrintf(2, 3, " Slices +-: %d   Stacks <>: %d", slices, stacks);
  shapesPrintf(3, 3, " nSides +-: %d   nRings <>: %d", slices, stacks);
  shapesPrintf(4, 3, " Depth  (): %d", depth);
  shapesPrintf(5, 3, " Outer radius  Up  Down : %f", orad);
  shapesPrintf(6, 3, " Inner radius Left Right: %f", irad);

  glutSwapBuffers();
}


static void
key(unsigned char key, int x, int y) {
  switch(key) {
    case 27 :
    case 'Q':
    case 'q': exit(0);                   break;

    case '=':
    case '+': slices++;                  break;

    case '-':
    case '_': if(slices > 3) {
        slices--;
      } break;

    case ',':
    case '<': if(stacks > 3) {
        stacks--;
      } break;

    case '.':
    case '>': stacks++;                  break;

    case '9':
    case '(': if(depth) {
        depth--;
      }       break;

    case '0':
    case ')': ++depth;                   break;

    default:
      break;
  }

  glutPostRedisplay();
}

static void
special(int key, int x, int y) {
  switch(key) {
    case GLUT_KEY_PAGE_UP:    ++function_index; break;
    case GLUT_KEY_PAGE_DOWN:  --function_index; break;
    case GLUT_KEY_UP:         orad *= 2;        break;
    case GLUT_KEY_DOWN:       orad /= 2;        break;

    case GLUT_KEY_RIGHT:      irad *= 2;        break;
    case GLUT_KEY_LEFT:       irad /= 2;        break;

    default:
      break;
  }

  if(0 > function_index) {
    function_index = NUMBEROF(table) - 1;
  }

  if(NUMBEROF(table) <= (unsigned)function_index) {
    function_index = 0;
  }
}


static void
idle(void) {
  glutPostRedisplay();
}

const GLfloat light_ambient[]  = { 0.0f, 0.0f, 0.0f, 1.0f };
const GLfloat light_diffuse[]  = { 1.0f, 1.0f, 1.0f, 1.0f };
const GLfloat light_specular[] = { 1.0f, 1.0f, 1.0f, 1.0f };
const GLfloat light_position[] = { 2.0f, 5.0f, 5.0f, 0.0f };

const GLfloat mat_ambient[]    = { 0.7f, 0.7f, 0.7f, 1.0f };
const GLfloat mat_diffuse[]    = { 0.8f, 0.8f, 0.8f, 1.0f };
const GLfloat mat_specular[]   = { 1.0f, 1.0f, 1.0f, 1.0f };
const GLfloat high_shininess[] = { 100.0f };

/* Program entry point */

int
main(int argc, char *argv[]) {
  glutInitWindowSize(640,480);
  glutInitWindowPosition(40,40);
  glutInit(&argc, argv);
  glutInitDisplayMode(GLUT_RGB | GLUT_DOUBLE | GLUT_DEPTH);

  glutCreateWindow("OpenGLUT Shapes");

  glutReshapeFunc(resize);
  glutDisplayFunc(display);
  glutKeyboardFunc(key);
  glutSpecialFunc(special);
  glutIdleFunc(idle);

  glClearColor(1,1,1,1);
  glEnable(GL_CULL_FACE);
  glCullFace(GL_BACK);

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  glEnable(GL_LIGHT0);
  glEnable(GL_NORMALIZE);
  glEnable(GL_COLOR_MATERIAL);

  glLightfv(GL_LIGHT0, GL_AMBIENT,  light_ambient);
  glLightfv(GL_LIGHT0, GL_DIFFUSE,  light_diffuse);
  glLightfv(GL_LIGHT0, GL_SPECULAR, light_specular);
  glLightfv(GL_LIGHT0, GL_POSITION, light_position);

  glMaterialfv(GL_FRONT, GL_AMBIENT,   mat_ambient);
  glMaterialfv(GL_FRONT, GL_DIFFUSE,   mat_diffuse);
  glMaterialfv(GL_FRONT, GL_SPECULAR,  mat_specular);
  glMaterialfv(GL_FRONT, GL_SHININESS, high_shininess);

  glutMainLoop();

  return EXIT_SUCCESS;
}

