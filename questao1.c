#include <stdio.h>

int main(void){
	double salario_bruto, salario_liquido, inss;
	printf("Insira o valor do salario bruto: ");
	scanf("%lf", &salario_bruto);
	
	if(salario_bruto <= 420){
		inss = salario_bruto*0.08;
		salario_liquido = salario_bruto - inss;}
	if(salario_bruto > 420 && salario_bruto <= 1350){
		inss = salario_bruto*0.09;
		salario_liquido = salario_bruto - inss;}
	if(salario_bruto > 1350){
		inss = salario_bruto*0.1;
		salario_liquido = salario_bruto - inss;}
	
	printf("\nValor de desconto do INSS: R$%.2lf\n", inss);
	printf("Salario liquido: R$%.2lf\n", salario_liquido);
	
	return 0;
	}
