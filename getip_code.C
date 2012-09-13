//===========================================================================
// FILE:        getip_code.C
// DESCRIPTION: Program that gets IP address of interface of 1+ hosts
// AUTHOR:      Matthew Bruckler (matt@bruckler.net)
// ORIG_DATE:   Sep 10, 2012
//===========================================================================
#include "getip_code.h"
#include <arpa/inet.h>
#include <netdb.h>
#include <sys/types.h>

#include <string.h>
#include <algorithm>
#include <string>
#include <iostream>
 using namespace std;

//-----------------------------------------------------------------------
char* getip(const char* host)
{
  struct hostent* h;
  char buffer[256];
  string tmp = host;
  transform(tmp.begin(),tmp.end(),tmp.begin(),::tolower);
  if (tmp == "localhost" || tmp == "") {
    gethostname(buffer, 256);
  }else {
   strcpy(buffer,host);
  }
  h = gethostbyname(buffer);
  char * val;
  if (h) {
    val = inet_ntoa(*(struct in_addr *)h->h_addr);
  } else {
   val = NULL;
  }
  return val;
}

//-----------------------------------------------------------------------