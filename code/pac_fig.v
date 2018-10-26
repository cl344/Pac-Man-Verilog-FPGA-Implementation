module pac_fig(pos1, pos2, pic1, pic2, is_pac,up,left,down, right);



input up, left, down, right;

output is_pac;

input[31:0] pos1,pos2,pic1,pic2;

wire[31:0] x_diff, y_diff;
assign x_diff = pic1-pos1;
assign y_diff = pic2-pos2;



wire nocolordown,nocolorup, nocolorleft, nocolorright;
wire nocolor1, nocolor2,  nocolor3, nocolor4, nocolor5, nocolor6,nocolor7, nocolor8,color;

assign nocolor1 = (pic1 >= pos1) & (pic2 >= pos2) & (x_diff > y_diff);
assign nocolor2 = (pic1 >= pos1) & (pic2 <= pos2) & ( x_diff > (pos2-pic2));
assign nocolorright= nocolor1 | nocolor2;


assign nocolor3 = (pic1 >= pos1) & (pic2 <= pos2) & ( x_diff > (pos2-pic2));
assign nocolor4  = (pic1 <= pos1) & (pic2 <= pos2) & ( (pos1-pic1) > (pos2-pic2));
assign nocolorup = nocolor3 | nocolor4;

assign nocolor5 = (pic1 <= pos1) & (pic2 >= pos2) & ( (pos1-pic1) > y_diff);
assign nocolor6  = (pic1 <= pos1) & (pic2 <= pos2) & ( (pos1-pic1) > (pos2-pic2));
assign nocolorleft = nocolor5 | nocolor6;


assign nocolor7 = (pic1 <= pos1) & (pic2 >= pos2) & ( (pos1-pic1) < y_diff);
assign nocolor8  = (pic1 >= pos1) & (pic2 >= pos2) & ( x_diff < y_diff);
assign nocolordown = nocolor7 | nocolor8;



assign color = (x_diff * x_diff +   y_diff * y_diff) < 1000;

assign is_pac = color & ~(nocolorup & up) & ~(nocolordown & down) & ~(nocolorleft & left) & ~(nocolorright & right);


endmodule