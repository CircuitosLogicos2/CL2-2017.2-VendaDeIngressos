module Cinema(input [17:0]SW, input clk, output reg [17:0]LEDR , input [3:0]KEY, output [7:0]HEX0,
			  output [7:0]HEX4, output [7:0]HEX5, output [7:0]HEX6, output [7:0]HEX7, output [7:0]HEX1, output [7:0]HEX2, output [7:0]HEX3);

integer filmeEscolhido = 0; //flag que indica que o filme já foi escolhido e passa para a escolha do horário;
integer filme = 0; //variável que indica qual filme foi escolhido, 1 ou 2;
integer horarioEscolhido = 0; //flag que indica que o horário ja foi escolhido e passa para a escolha dos assentos;
integer horario = 0; //variável que indica qual horário foi escolhido, 1 ou 2;
integer assentoEscolhido = 0; //flag que indica que o(s) assento(s) foram escolhidos;
reg [17:0] assento11 = 18'b000000000000000000; //array que guarda os assentos da sessão do filme 1 horário 1;
reg [17:0] assento12 =   18'b000000000000000000; //array que guarda os assentos da sessão do filme 1 horário 2;
reg [17:0] assento21 = 18'b000000000000000000; //array que guarda os assentos da sessão do filme 2 horário 1;
reg [17:0] assento22 = 18'b000000000000000000; //array que guarda os assentos da sessão do filme 2 horário 2;
integer valorInserido = 0; //flag que indica que o valor foi inserido (se tivesse funcionando o estado de pagamento);
integer valor = 0; //variável que guarda o valor que o usuário deve pagar;
integer pago = 0; //flag que indica se já foi pago o valor;
integer quantidadeDeIngresso = 0; //variável que guarda a quantidade de ingressos que o usuário escolheu;
integer trocoFeito = 0; //flag que indica se o troco foi dado ao usuário;
integer troco = 0; //variável que indica quanto de troco deve ser dado;
reg [7:0]F = 4'hF; //array que armazena o "F" de filme no display;
reg [7:0]H = 4'hC; //array que armazena o "H" de horário no display;
reg [7:0]dFilme = 4'h0; //array que armazena qual filme deve ser indicado no display, 1 ou 2;
reg [7:0]dHorario = 4'h0; //array que armazena qual horário deve ser indicado no display, 1 ou 2;
reg [7:0]display1 = 4'h0; //array do primeiro display que indica a hora no display, 14:00 ou 16:00;
reg [7:0]display2 = 4'h0; //array do segundo display que indica a hora no display, 14:00 ou 16:00;
reg [7:0]display3 = 4'h0; //array do terceiro display que indica a hora no display, 14:00 ou 16:00;
reg [7:0]display4 = 4'h0; //array do quarto display que indica a hora no display, 14:00 ou 16:00;
integer bouncing = 0; //tentativa de uso de flag para parar o bouncing;
integer bouncing2 = 0; //tentativa de uso de flag para parar o bouncing;


always@(posedge clk) begin
    if(!filmeEscolhido && bouncing == 0) begin //início da escolha do filme;
		troco = 0;
        if(KEY == 4'b1110) begin //precionar o botao 4 da esquerda para a direita para escolher o filme 1;
            filme = 1; //confirmação de que filme é;
            filmeEscolhido = 1; //ativação da flag;
            dFilme = 4'h1; //variável do display;
            bouncing = 1; //tentativa de parar o bouncing;
        end
        if(KEY == 4'b1101) begin //precionar o botão 3 da esquerda para a direita para escolher o filme 2;
            filme = 2; //confirmação de que filme é;
            filmeEscolhido = 1; //ativação da flag;
            dFilme = 4'h2; //variável do display;
            //bouncing2 = 1;
        end
    end
    if(!horarioEscolhido && filmeEscolhido == 1) begin //início da escolha do horário;
        if(KEY == 4'b1011) begin //precionar o botao 2 da esquerda para a direita para escolher o horário 1;
            horario = 1; //confirmação de que horário é;
            horarioEscolhido = 1; //ativação da flag;
            dHorario = 4'h1; //variável do display para mostrar que é o horário 1
            display1 = 4'h1; //variável do display para mostrar a hora (1);
            display2 = 4'h4; //variável do display para mostrar a hora (4);
            display3 = 4'h0; //variável do display para mostrar a hora (0);
            display4 = 4'h0; //variável do display para mostrar a hora (0);
        end
        if(KEY == 4'b0111) begin //precionar o botao 1 da esquerda para a direita para escolher o horário 2;
            horario = 2; //confirmação de que horário é;
            horarioEscolhido = 1; //ativação da flag;
            dHorario = 4'h2; //variável do display para mostrar que é o horário 2
            display1 = 4'h1; //variável do display para mostrar a hora (1);
            display2 = 4'h6; //variável do display para mostrar a hora (6);
            display3 = 4'h0; //variável do display para mostrar a hora (0);
            display4 = 4'h0; //variável do display para mostrar a hora (0);
        end
    end
    quantidadeDeIngresso=0; //zera a quantidade de ingressos escolhidos;
    if(!assentoEscolhido && horarioEscolhido == 1) begin //início da escolha dos assentos;
        integer i; //variável do for;
        LEDR = 18'b111111111111111111; //acender todos os leds;
        for (i = 0; i<18; i = i + 1) begin
            if(SW[i] == 1) quantidadeDeIngresso = quantidadeDeIngresso + 1; //calcular quantas cadeiras foram escolhidas;
        end
        valor = quantidadeDeIngresso * 15; //calcular o preço do ingresso;
        if(KEY == 4'b0011) begin //pressionar os dois primeiros botões para confirmar os assentos;
            assentoEscolhido <= 1; //confirmar o que o assento foi escolhido para não entrar mais no if de escolher os assentos;
            if(filme == 1 && horario == 1) assento11 <= assento11 + SW; //guardar quais assentos foram escolhidos para o filme 1 horário 1
            if(filme == 1 && horario == 2) assento12 <= assento12 + SW; //guardar quais assentos foram escolhidos para o filme 1 horário 2
            if(filme == 2 && horario == 1) assento21 <= assento21 + SW; //guardar quais assentos foram escolhidos para o filme 2 horário 1
            if(filme == 2 && horario == 2) assento22 <= assento22 + SW; //guardar quais assentos foram escolhidos para o filme 2 horário 2
        end
    end

    if(filme == 1 && horario == 1)begin //apagar os leds dos respectivos assentos escolhidos
		LEDR = ~assento11;
		bouncing = 0;
	end
    if(filme == 1 && horario == 2)begin //apagar os leds dos respectivos assentos escolhidos
		LEDR = ~assento12;
		bouncing = 0;
    end
    if(filme == 2 && horario == 1)begin //apagar os leds dos respectivos assentos escolhidos
		LEDR = ~assento21;
		//bouncing2 = 0;
	end
    if(filme == 2 && horario == 2)begin //apagar os leds dos respectivos assentos escolhidos
		LEDR = ~assento22;
		//bouncing2 = 0;
	end

    if (!pago && assentoEscolhido == 1) begin //if que inicia a parte do pagamento;
        if(KEY == 4'b1110) begin //para inserir 5 reais;
            valorInserido = valorInserido + 5;
        end
        if(KEY == 4'b1101) begin //para inserir 10 reais;
            valorInserido = valorInserido + 10;
        end
        if(KEY == 4'b1011) begin //para inserir 20 reais;
            valorInserido = valorInserido + 20;
        end
        if(KEY == 4'b0111) begin //para inserir 50 reais;
            valorInserido = valorInserido + 50;
        end
        if(valor == valorInserido) begin //conferir se o valor inserido é igual ao que se deve pagar;
			pago = 1; //ativação da flag;
		end
		
		if (valor < valorInserido && !trocoFeito) begin //se o valor inserido for maior do que se deve pagar deverá ter troco
			troco <= valorInserido - valor; //cálculo do troco;
			pago <= 1; //ativação da flag;
			trocoFeito <= 1; //ativação da flag;
		end
    end
    
    if(pago == 1) begin //zerando todas as variáveis para começar o programa novamente;
		filmeEscolhido <= 0;
		horarioEscolhido <= 0;
		horario <= 0;
		assentoEscolhido <= 0;
		valorInserido <= 0;
		valor <= 0;
		pago <= 0;
		quantidadeDeIngresso <= 0;
		trocoFeito <= 0;
		dinheiroFeito <= 0;
		pago <= 0;
	end
end

reg [7:0] SevenSeg; // array auxiliar;
	always @(*) //display que mostra "F";
	case(F) //variável que vai mudar o display;
		4'h0: SevenSeg = 8'b11111100;
		4'h1: SevenSeg = 8'b01100000;
		4'h2: SevenSeg = 8'b11011010;
		4'h3: SevenSeg = 8'b11110010;
		4'h4: SevenSeg = 8'b01100110;
		4'h5: SevenSeg = 8'b10110110;
		4'h6: SevenSeg = 8'b10111110;
		4'h7: SevenSeg = 8'b11100000;
		4'h8: SevenSeg = 8'b11111110;
		4'h9: SevenSeg = 8'b11110110;
		4'hF: SevenSeg = 8'b10001110;
		default: SevenSeg = 8'b00000000;
	endcase
	assign {HEX7[0], HEX7[1], HEX7[2], HEX7[3], HEX7[4], HEX7[5], HEX7[6], HEX7[7]} = ~SevenSeg;
	
	reg [7:0] SevenSeg1;
	always @(*) //display que mostra "H";
	case(H)
		4'h0: SevenSeg1 = 8'b11111100;
		4'h1: SevenSeg1 = 8'b01100000;
		4'h2: SevenSeg1 = 8'b11011010;
		4'h3: SevenSeg1 = 8'b11110010;
		4'h4: SevenSeg1 = 8'b01100110;
		4'h5: SevenSeg1 = 8'b10110110;
		4'h6: SevenSeg1 = 8'b10111110;
		4'h7: SevenSeg1 = 8'b11100000;
		4'h8: SevenSeg1 = 8'b11111110;
		4'h9: SevenSeg1 = 8'b11110110;
		4'hC: SevenSeg1 = 8'b01101110;
		default: SevenSeg1 = 8'b00000000;
	endcase
	assign {HEX5[0], HEX5[1], HEX5[2], HEX5[3], HEX5[4], HEX5[5], HEX5[6], HEX5[7]} = ~SevenSeg1;
	
	reg [7:0] SevenSeg2;
	always @(*) //display que mostra qual filme vai ser, "1" ou "2";
	case(dFilme)
		4'h0: SevenSeg2 = 8'b11111100;
		4'h1: SevenSeg2 = 8'b01100000;
		4'h2: SevenSeg2 = 8'b11011010;
		4'h3: SevenSeg2 = 8'b11110010;
		4'h4: SevenSeg2 = 8'b01100110;
		4'h5: SevenSeg2 = 8'b10110110;
		4'h6: SevenSeg2 = 8'b10111110;
		4'h7: SevenSeg2 = 8'b11100000;
		4'h8: SevenSeg2 = 8'b11111110;
		4'h9: SevenSeg2 = 8'b11110110;
		4'hC: SevenSeg2 = 8'b01101110;
		default: SevenSeg2 = 8'b00000000;
	endcase
	assign {HEX6[0], HEX6[1], HEX6[2], HEX6[3], HEX6[4], HEX6[5], HEX6[6], HEX6[7]} = ~SevenSeg2;
	
	reg [7:0] SevenSeg3;
	always @(*) //display que mostra qual horário vai ser, "1" ou "2";
	case(dHorario)
		4'h0: SevenSeg3 = 8'b11111100;
		4'h1: SevenSeg3 = 8'b01100000;
		4'h2: SevenSeg3 = 8'b11011010;
		4'h3: SevenSeg3 = 8'b11110010;
		4'h4: SevenSeg3 = 8'b01100110;
		4'h5: SevenSeg3 = 8'b10110110;
		4'h6: SevenSeg3 = 8'b10111110;
		4'h7: SevenSeg3 = 8'b11100000;
		4'h8: SevenSeg3 = 8'b11111110;
		4'h9: SevenSeg3 = 8'b11110110;
		4'hC: SevenSeg3 = 8'b01101110;
		default: SevenSeg3 = 8'b00000000;
	endcase
	assign {HEX4[0], HEX4[1], HEX4[2], HEX4[3], HEX4[4], HEX4[5], HEX4[6], HEX4[7]} = ~SevenSeg3;
	
	reg [7:0] SevenSeg4;
	always @(*) //primeiro display que vai indicar a hora;
	case(display1)
		4'h0: SevenSeg4 = 8'b11111100;
		4'h1: SevenSeg4 = 8'b01100000;
		4'h2: SevenSeg4 = 8'b11011010;
		4'h3: SevenSeg4 = 8'b11110010;
		4'h4: SevenSeg4 = 8'b01100110;
		4'h5: SevenSeg4 = 8'b10110110;
		4'h6: SevenSeg4 = 8'b10111110;
		4'h7: SevenSeg4 = 8'b11100000;
		4'h8: SevenSeg4 = 8'b11111110;
		4'h9: SevenSeg4 = 8'b11110110;
		4'hC: SevenSeg4 = 8'b01101110;
		default: SevenSeg4 = 8'b00000000;
	endcase
	assign {HEX3[0], HEX3[1], HEX3[2], HEX3[3], HEX3[4], HEX3[5], HEX3[6], HEX3[7]} = ~SevenSeg4;
	
	reg [7:0] SevenSeg5;
	always @(*) //segundo display que vai indicar a hora;
	case(display2)
		4'h0: SevenSeg5 = 8'b11111100;
		4'h1: SevenSeg5 = 8'b01100000;
		4'h2: SevenSeg5 = 8'b11011010;
		4'h3: SevenSeg5 = 8'b11110010;
		4'h4: SevenSeg5 = 8'b01100110;
		4'h5: SevenSeg5 = 8'b10110110;
		4'h6: SevenSeg5 = 8'b10111110;
		4'h7: SevenSeg5 = 8'b11100000;
		4'h8: SevenSeg5 = 8'b11111110;
		4'h9: SevenSeg5 = 8'b11110110;
		4'hC: SevenSeg5 = 8'b01101110;
		default: SevenSeg5 = 8'b00000000;
	endcase
	assign {HEX2[0], HEX2[1], HEX2[2], HEX2[3], HEX2[4], HEX2[5], HEX2[6], HEX2[7]} = ~SevenSeg5;
	
	reg [7:0] SevenSeg6;
	always @(*) //terceiro display que vai indicar a hora;
	case(display3)
		4'h0: SevenSeg6 = 8'b11111100;
		4'h1: SevenSeg6 = 8'b01100000;
		4'h2: SevenSeg6 = 8'b11011010;
		4'h3: SevenSeg6 = 8'b11110010;
		4'h4: SevenSeg6 = 8'b01100110;
		4'h5: SevenSeg6 = 8'b10110110;
		4'h6: SevenSeg6 = 8'b10111110;
		4'h7: SevenSeg6 = 8'b11100000;
		4'h8: SevenSeg6 = 8'b11111110;
		4'h9: SevenSeg6 = 8'b11110110;
		4'hC: SevenSeg6 = 8'b01101110;
		default: SevenSeg6 = 8'b00000000;
	endcase
	assign {HEX1[0], HEX1[1], HEX1[2], HEX1[3], HEX1[4], HEX1[5], HEX1[6], HEX1[7]} = ~SevenSeg6;
	
	reg [7:0] SevenSeg7;
	always @(*) //quarto display que vai indicar a hora;
	case(display4)
		4'h0: SevenSeg7 = 8'b11111100;
		4'h1: SevenSeg7 = 8'b01100000;
		4'h2: SevenSeg7 = 8'b11011010;
		4'h3: SevenSeg7 = 8'b11110010;
		4'h4: SevenSeg7 = 8'b01100110;
		4'h5: SevenSeg7 = 8'b10110110;
		4'h6: SevenSeg7 = 8'b10111110;
		4'h7: SevenSeg7 = 8'b11100000;
		4'h8: SevenSeg7 = 8'b11111110;
		4'h9: SevenSeg7 = 8'b11110110;
		4'hC: SevenSeg7 = 8'b01101110;
		default: SevenSeg7 = 8'b00000000;
	endcase
	assign {HEX0[0], HEX0[1], HEX0[2], HEX0[3], HEX0[4], HEX0[5], HEX0[6], HEX0[7]} = ~SevenSeg7;
	
	
endmodule

/*  SW -> switches de 0 à 17;
	LEDR -> leds de 0 à 17;
	KEY -> botões de 0 à 3;
	HEX0 -> display 0;
	HEX1 -> display 1;
	HEX2 -> display 2;
	HEX3 -> display 3;
	HEX4 -> display 4;
	HEX5 -> display 5;
	HEX6 -> display 6;
	HEX7 -> display 7;