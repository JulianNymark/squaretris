Player p1;
Player p2;

int game_state; // 0 = main_menu, 1 = game, 2 = game_over
boolean init_state; // set when changing state!

int player_count;

void setup(){
    initialize();

    size(SCREEN_W,SCREEN_H);
  
    setGameState(STATE_MAIN_MENU);

    // player 1
    p1 = new Player(0);
    p1.addPiece();
    
    p2 = new Player(1);
    p2.addPiece();

}

void draw(){
    switch (game_state) {
    case 0: // MAIN_MENU
	drawMainMenu();
	break;
    case 1: // GAME
	drawGame();
	break;
    case 2: // GAME_OVER
	drawGameOver();
	break;
    }
}

void gameOver(){
    setGameState(STATE_GAME_OVER);
}

void setGameState(int i){
    init_state = true;
    game_state = i;
}

// draw a given shape at given coordinates
void drawPiece(Piece p, int loc_x, int loc_y){
    for (int y=0; y<4; ++y){
	for (int x=0; x<4; ++x){
	    int block = p.data[p.rot][x][y];
	    if (block > 0){
		setFillBlock(block);
		rect(loc_x+(x*GRID_SIZE), loc_y+(y*GRID_SIZE), 
		     GRID_SIZE, GRID_SIZE);
	    }
	}
    }
}

// color of block
void setFillBlock(int color_int){
    switch (color_int){
    case 0:
	noFill();
	break;
    case 1:
	fill(CYAN);
	break;
    case 2:
	fill(YELLOW);
	break;
    case 3:
	fill(PURPLE);
	break;
    case 4:
	fill(GREEN);
	break;
    case 5:
	fill(RED);
	break;
    case 6:
	fill(BLUE);
	break;
    case 7:
	fill(ORANGE);
	break;
    }
}

// initialize global variables
void initialize(){
    
    SCREEN_W = displayWidth;
    SCREEN_H = displayHeight;
    
    // atomic constants (important & affect gameplay)
    GRID_W = 10; // game grid block count (width)
    GRID_H = 22; // game grid block count (height) top 2 rows not drawn!

    // compound constants (magic)
    SPACING = SCREEN_W/25;
    GRID_SIZE = (SCREEN_H - (SPACING*2))/(GRID_H-2);

    P1_GRID_X = SPACING;
    P1_GRID_Y = SPACING;
    P1_PANEL_X = (2*SPACING) + (GRID_SIZE*GRID_W);
    P1_PANEL_Y = SCREEN_H*((float) 2/3);
    P1_NEXT_PANEL_X = P1_PANEL_X;
    P1_NEXT_PANEL_Y = SCREEN_H*((float) 1/3);

    P2_GRID_X = P1_PANEL_X + (3*SPACING);
    P2_GRID_Y = SPACING;
    P2_PANEL_X = P2_GRID_X + SPACING + (GRID_SIZE*GRID_W);
    P2_PANEL_Y = SCREEN_H*((float) 2/3);
    P2_NEXT_PANEL_X = P2_PANEL_X;
    P2_NEXT_PANEL_Y = SCREEN_H*((float) 1/3);

}
