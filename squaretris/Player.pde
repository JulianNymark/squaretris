class Player implements Runnable{
    // values & info
    int level;
    int lines;
    int score;

    int id;
    
    // pieces & positions
    Piece cur;
    Piece next;
    int piece_x, piece_y; // where on game_grid
    
    // panels
    PGraphics score_panel; // score panel
    PGraphics next_panel; // next piece

    // players gamegrid
    GameGrid game_grid;

    Player(int i){
	
	id = i;

	level = 1;
	lines = 0;
	score = 0;
	
	score_panel = createGraphics(512,512);
	next_panel = createGraphics(512,512);
	
	// assign pieces & location
	next = new Piece(possible_pieces[(int) random(7)]);
	cur = new Piece(possible_pieces[(int) random(7)]);
	piece_x = 3;
	piece_y = 0;

	game_grid = new GameGrid(id);
    }

    void draw_panel(){
	score_panel.clear();
	score_panel.beginDraw();

	score_panel.textAlign(LEFT, TOP);
	score_panel.textSize(30);
	
	score_panel.text("LEVEL: " + level, 0, 0);
	score_panel.text("LINES: " + lines, 0, 40);
	score_panel.text("SCORE: " + score, 0, 80);

	score_panel.endDraw();
    }
    
    void draw_next_panel(){
	next_panel.clear();
	next_panel.beginDraw();
	
	for (int y=0; y<4; ++y){
	    for (int x=0; x<4; ++x){
		int block = next.data[next.rot][x][y];
		if (block > 0){
		    switch (block){
		    case 0:
			next_panel.noFill();
			break;
		    case 1:
			next_panel.fill(CYAN);
			break;
		    case 2:
			next_panel.fill(YELLOW);
			break;
		    case 3:
			next_panel.fill(PURPLE);
			break;
		    case 4:
			next_panel.fill(GREEN);
			break;
		    case 5:
			next_panel.fill(RED);
			break;
		    case 6:
			next_panel.fill(BLUE);
			break;
		    case 7:
			next_panel.fill(ORANGE);
			break;
		    }
		    next_panel.rect((x*GRID_SIZE), (y*GRID_SIZE), 
				    GRID_SIZE, GRID_SIZE);
		}
	    }
	}
	
	next_panel.endDraw();
    }

    void addPiece(){
	for (int x=0; x<4; ++x) {
	    for (int y=0; y<4; ++y) {
		int block = cur.data[cur.rot][x][y];
		if ( block > 0) {
		    game_grid.grid[piece_x + x][piece_y + y] = block;
		}
	    }
	}
    }

    void removePiece(){
	for (int x=0; x<4; ++x) {
	    for (int y=0; y<4; ++y) {
		int block = cur.data[cur.rot][x][y];
		if ( block > 0) {
		    game_grid.grid[piece_x + x][piece_y + y] = 0;
		}
	    }
	}
    }

    void movePiece(char dir){
	removePiece(); // remove (don't collide vs self)

	switch (dir) {
	case 'u':
	    piece_y -= 1;
	    if (checkCollision()){
		piece_y +=1;
		addPiece();
	    }
	    break;
	case 'd':
	    piece_y += 1;
	    if (checkCollision()){
		piece_y -=1;
		landedPiece();
	    }
	    break;
	case 'l':
	    piece_x -= 1;
	    if (checkCollision()){
		piece_x +=1;
		addPiece();
	    }
	    break;
	case 'r':
	    piece_x += 1;
	    if (checkCollision()){
		piece_x -=1;
		addPiece();
	    }
	    break;
	}

// add current piece at its new location -> grid
	addPiece();
    }

    void rotatePiece(char dir){
	removePiece();
    
	switch (dir) {
	case 'r': // clockwise
	    cur.rot = (cur.rot + 1) % cur.max_rot;
	    if (checkCollision()) {
		if (cur.rot == 0){
		    cur.rot = cur.max_rot - 1;
		}
		else {
		    cur.rot = cur.rot - 1;
		}
	    }
	    break;
	case 'l': // counter_clockwise
	    if (cur.rot == 0){
		cur.rot = cur.max_rot - 1;
	    }
	    else {
		cur.rot = cur.rot - 1;
	    }
	    if (checkCollision()){
		cur.rot = (cur.rot + 1) % cur.max_rot;
	    }
	    break;
	}
	addPiece();
    }


    boolean checkCollision(){
	for (int x=0; x<4; ++x) {
	    for (int y=0; y<4; ++y) {
		int block = cur.data[cur.rot][x][y];
		if ( block > 0) {
		    if (piece_y + y > (GRID_H-1) ||
			piece_x + x > (GRID_W-1) ||
			piece_y + y < 0 ||
			piece_x + x < 0 ||
			game_grid.grid[piece_x + x][piece_y + y] > 0){
			return true;
		    }
		}
	    }
	}
	return false;
    }


    void landedPiece(){
	// add piece where it last collided (landed)
	addPiece();
    
	// check lines
	int lines_done = 0;
	for (int y =0; y<GRID_H; ++y) {
	    boolean full_line = true;
	    for (int x=0; x<GRID_W; ++x) {
		if(game_grid.grid[x][y] == 0){
		    full_line = false;
		    break;
		}
	    }
	    if (full_line) {
		// shift all above line down 1
		for (int y2=y; y2>1; --y2){
		    for (int x=0; x<GRID_W; ++x) {
			game_grid.grid[x][y2] =
			    game_grid.grid[x][y2-1];
		    }
		}
		lines_done += 1;
	    }
	}
    
	// score calculation
	scoreCalc(lines_done);
    
	// get new piece
	newPiece();
    }

    void scoreCalc(int lines_done){
	if (lines_done > 0) {
	    // lines & score ++
	    score += (lines_done * lines_done);
	    lines += lines_done;
	    if (lines > level*10) {
		level += 1;
	    }
	}
    }

    void dropPiece(){
	removePiece();
	boolean dropped = false;
	while(!dropped){
	    piece_y += 1;
	    if (checkCollision()){
		dropped = true;
		piece_y -=1;
		landedPiece();
	    }
	}
    }

    void newPiece(){
	cur = next;
	next = new Piece(possible_pieces[(int) random(7)]);
	piece_x = 3;
	piece_y = 0;
    
	// if collide on new piece = game over
	if (checkCollision()){
	    gameOver();
	    return;
	}
    
	addPiece(); // draw new piece
    }


/* Infinite update loop for the game. 
 * this thread runs concurrently with that other infinite loop, draw()
 * separating the draw loop from 'game-time'
 */
    public void run(){
	while (game_state == STATE_GAME) {
	    // sleep game tick (based on level)
	    try{
		Thread.sleep(1000/level);
	    }
	    catch (Exception e){
		System.out.println(e.toString());
	    }

	    // move piece 1 place down
	    movePiece('d');
	}
    }
}
