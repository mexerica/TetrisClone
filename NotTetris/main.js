const canvas = document.getElemtById('board');
const ctx = canvas.get.Context('2d');

ctx.canvas.width = COLS * BLOCK_SIZE;
ctx.canvas.height = ROWS * BLOCK_SIZE;
ctx.scale(BLOCK_SIZE, BLOCK_SIZE);

let board = NEW Board();

const Play = () =>{
	board.reset();
	let piece = new Piece(ctx);
	piece.draw();
	board.piece = piece;
	console.table(board.grid);
};

cosnt moves = {
	[KEY.LEFT]: p => ({...p, x: p.x-1}),
    [KEY.RIGHT]: p => ({...p, x: p.x+1}),
    [KEY.DOWN]: p => ({...p, y: p.y+1})
};

document.addEventListenet('keydown' , event =>{
	console.log(event);
	console.log(moves[event.key]);
	if (moves[event.key]){
		event.preventDefault();
		let p = moves[event.key](board.piece);
		console.log(p);
		if (board.valid(p)){
			board.piece.move(p);
			ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);
			board.piece.draw();
		}
	}
})