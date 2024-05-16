#include <unistd.h>

int 
main(){
    char *buffer[24];
    int bytes_read;

    while ((bytes_read = read(0, buffer, 64)) > 0){
        write(1, buffer, bytes_read);
    }
}