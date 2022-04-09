#define __LIBRARY__

#include <errno.h>

#include <linux/sched.h>
#include <linux/kernel.h>
#include <asm/segment.h>
#include <asm/system.h>

int sys_print_val(int a){
  printk("in sys_print_val:  %d  \n",a);
  return 0;
}

int sys_str2num(char *str, int str_len, long *ret){
  int i;
  long result=0;
  long pow=1;
  char c;
    if(str_len>8){
      printk("sys_str2num overflow \n");
      *ret=0;
      return -1;  
    }
  for(i=str_len-1;i>=0;i--){
   c=get_fs_byte((char*)&str[i]);
   result+=pow*(c-'0');
   pow*=10;
  }

  put_fs_long(result,ret);

  return 0;

}
