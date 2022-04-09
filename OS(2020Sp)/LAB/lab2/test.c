#define __LIBRARY__
#include<stdio.h>
#include<unistd.h>
 _syscall1(int, print_val,int, a); /* print_val()在用户空间的接口函数, 下同 */
 _syscall3(int, str2num,char*,str,int,str_len, long*, ret);

int main(){
        char input [10];
	long ret;
	int len=0;
        printf("Give me a string:\n");
	scanf("%s",input);
	while(input[len]!='\0'){
            len++;	
	}
	str2num(input,len,&ret);
	print_val((int)ret);
    return 0;
}
