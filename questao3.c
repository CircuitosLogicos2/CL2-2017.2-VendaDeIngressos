#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void){
	int i=0, cont=0, j=0;
	char string[50], invertido[50];

	printf("Digite a palavra:\n");
	scanf("%50s", string);
	
	while (string[i] != '\0'){
		cont++;
		i++;
	}
	
	printf("Ordem inversa:\n");
	for(i = cont; i>=0; i--){
		if(string[i] != '\0'){
			printf("%c", string[i]);
			invertido[j] = string[i];
			j++;
		}
	}
	invertido[j] = '\0';
	if(strcmp(string, invertido) == 0){
		printf("\nEh um palindromo\n");}
	else{
		printf("\nNao eh um palindromo\n");}
	return 0;
}
