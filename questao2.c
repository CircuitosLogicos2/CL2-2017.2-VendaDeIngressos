#include <stdio.h>

int Fibonacci(int termos){
	if(termos == 1 || termos == 2){
		return 1;}
	else{
		return Fibonacci(termos - 1) + Fibonacci(termos - 2);}
	}


int main(void){
	int termos, i;

	printf("Digite o numero de termos: ");
	scanf("%d", &termos);
	
	printf("A sequencia eh: ");	
	for(i=0; i<termos; i++){
		printf("%d, ", Fibonacci(i+1));}


	return 0;
	}
		
