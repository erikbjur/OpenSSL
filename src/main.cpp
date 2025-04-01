#include <iostream>
#include <openssl/ssl.h>

int main() {
  std::cout << "OpenSSL version: " << OpenSSL_version(OPENSSL_VERSION)
            << std::endl;
  return 0;
}