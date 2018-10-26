module textGenerator (enableGenerator, textInput, mifOutput);

input enableGenerator;
input [6:0] textInput;
reg character;
always @ (enableGenerator)
case(textInput)
	
	7'd65:character = zero;
	7'd66:character = one;
	7'd67:character = two;
	7'd68:character = three;
	7'd69:character = four;
	7'd70:character = five;
	7'd71:character = six;
	7'd72:character = seven;
	7'd73:character = eight;
	7'd74:character = nine;
	
	7'd65:character = A;
	7'd66:character = B;
	7'd67:character = C;
	7'd68:character = D;
	7'd69:character = E;
	7'd70:character = F;
	7'd71:character = G;
	7'd72:character = H;
	7'd73:character = I;
	7'd74:character = J;
	7'd75:character = K;
	7'd76:character = L;
	7'd77:character = M;
	7'd78:character = N;
	7'd79:character = O;
	7'd80:character = P;
	7'd81:character = Q;
	7'd82:character = R;
	7'd83:character = S;
	7'd84:character = T;
	7'd85:character = U;
	7'd86:character = V;
	7'd87:character = W;
	7'd88:character = X;
	7'd89:character = Y;
	7'd90:character = Z;
	
	7'd97:character = a;
	7'd98:character = b;
	7'd99:character = c;
	7'd100:character = d;
	7'd101:character = e;
	7'd102:character = f;
	7'd103:character = g;
	7'd104:character = h;
	7'd105:character = i;
	7'd106:character = j;
	7'd107:character = k;
	7'd108:character = l;
	7'd109:character = m;
	7'd110:character = n;
	7'd111:character = o;
	7'd112:character = p;
	7'd113:character = q;
	7'd114:character = r;
	7'd115:character = s;
	7'd116:character = t;
	7'd117:character = u;
	7'd118:character = v;
	7'd119:character = w;
	7'd120:character = x;
	7'd121:character = y;
	7'd122:character = z;
endcase

endmodule	
	