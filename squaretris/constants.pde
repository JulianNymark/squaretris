// squaretris constants!!! set in squaretris.pde -- initialize()

// atomic constants (less important & mainly visual)
int SCREEN_W;
int SCREEN_H;
int SPACING;

// atomic constants (important & affect gameplay)
int GRID_W; // game grid block count (width)
int GRID_H; // game grid block count (height) top 2 rows not drawn!

// compound constants (magic)
int GRID_SIZE;
float P1_GRID_X;
float P1_GRID_Y;
float P1_PANEL_X;
float P1_PANEL_Y;
float P1_NEXT_PANEL_X;
float P1_NEXT_PANEL_Y;

float P2_GRID_X;
float P2_GRID_Y;
float P2_PANEL_X;
float P2_PANEL_Y;
float P2_NEXT_PANEL_X;
float P2_NEXT_PANEL_Y;

// colors
final color CYAN = color(200,255,255);
final color YELLOW = color(255,255,200);
final color PURPLE = color(235,200,255);
final color GREEN = color(215,255,200);
final color RED = color(255,200,200);
final color BLUE = color(200,200,255);
final color ORANGE = color(255,210,150);

// for some reason, enums don't work in processing? D:
final int STATE_MAIN_MENU = 0;
final int STATE_GAME = 1;
final int STATE_GAME_OVER = 2;

// pieces
final char[] possible_pieces = {'o','i','s','z','l','j','t'};
