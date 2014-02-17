void initGame(){
    fill(255);
    textSize(20);
}

void drawGame(){
    if (init_state) {
	initGame();
	init_state = false;
    }

    // clear screen
    background(100);
  
    // draw grid
    p1.game_grid.draw(); // draw grid -> grid's buffer
    image(p1.game_grid.pg, P1_GRID_X, P1_GRID_Y); // draw grid's buffer
    
    // draw player info panel
    p1.draw_panel();
    image(p1.score_panel, P1_PANEL_X, P1_PANEL_Y);
    
    // draw next piece
    p1.draw_next_panel();
    image(p1.next_panel, P1_NEXT_PANEL_X, P1_NEXT_PANEL_Y);

    if (player_count == 2) {
	// draw grid
	p2.game_grid.draw(); // draw grid -> grid's buffer
	image(p2.game_grid.pg, P2_GRID_X, P2_GRID_Y);

	// draw player info panel
	p2.draw_panel();
	image(p2.score_panel, P2_PANEL_X, P2_PANEL_Y);
    
	// draw next piece
	p2.draw_next_panel();
	image(p2.next_panel, P2_NEXT_PANEL_X, P2_NEXT_PANEL_Y);
    }
    
    // DEBUG FPS counter
    text("FPS: " + int(frameRate), 10, 20);
}

void inputGame(){
    if (key == CODED) {
	if (p2.isAlive) {
	    // arrow keys are CODED
	    switch (keyCode) {
	    case P2_UP:
		p2.dropPiece();
		break;
	    case P2_DOWN:
		p2.movePiece('d');
		break;
	    case P2_LEFT:
		p2.movePiece('l');
		break;
	    case P2_RIGHT:
		p2.movePiece('r');
		break;
	    }
	}
    }
    
    if (p1.isAlive) {
	switch (key) {
	case P1_UP:
	    p1.dropPiece();
	    break;
	case P1_DOWN:
	    p1.movePiece('d');
	    break;
	case P1_LEFT:
	    p1.movePiece('l');
	    break;
	case P1_RIGHT:
	    p1.movePiece('r');
	    break;
	case START_BUTTON:
	    exit();
	    break;
	case SELECT_BUTTON:
	case ENTER:
	    exit();
	    break;
	case P1_ROTATE_LEFT:
	    p1.rotatePiece('l');
	    break;
	case P1_ROTATE_RIGHT:
	    p1.rotatePiece('r');
	    break;
	case P1_DROP:
	    p1.dropPiece();
	    break;
	case P1_EXTRA_BUTTON:
	    p1.level += 1; // DEBUG
	    break;
	}
    }
    if (p2.isAlive) {
	switch (key) {
	case P2_ROTATE_LEFT:
	    p2.rotatePiece('l');
	    break;
	case P2_ROTATE_RIGHT:
	    p2.rotatePiece('r');
	    break;
	case P2_DROP:
	    p2.dropPiece();
	    break;
	case P2_EXTRA_BUTTON:
	    p2.level += 1; // DEBUG
	    break;
	
	}
    }
}
