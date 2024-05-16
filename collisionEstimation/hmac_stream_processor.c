#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <openssl/hmac.h>
#include <openssl/sha.h>

void compute_and_print_hmac(unsigned char *data, size_t data_len) {
    unsigned char *key = (unsigned char *)"secretkey";
    unsigned int result_len;
    unsigned char *result;

    result = HMAC(EVP_sha256(), key, strlen((char *)key), data, data_len, NULL, &result_len);

    // Print the HMAC for demonstration
    printf("HMAC: ");
    for (int i = 0; i < result_len; i++) {
        printf("%02x", result[i]);
    }
    printf("\n");
}

int main(){
    unsigned char buffer[64];  // Fixed size buffer for reading data
    int bytes_read;

    while ((bytes_read = read(STDIN_FILENO, buffer, sizeof(buffer))) > 0) {
        compute_and_print_hmac(buffer, bytes_read);  // Compute HMAC of the read data
        write(STDOUT_FILENO, buffer, bytes_read);    // Echo the data back
    }
    return 0;
}