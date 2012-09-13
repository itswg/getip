//===========================================================================
// FILE:        getip.C
// DESCRIPTION: Program that gets IP address of interface of 1+ hosts
// AUTHOR:      Matthew Bruckler (matt@bruckler.net)
// ORIG_DATE:   Sep 10, 2012
//===========================================================================
#include "getip_code.h"
#include <iostream>
#include <string>
 using namespace std;
#include <stdlib.h>

void PrintUsage(void);

string MyName = "";

int main (int argc, const char *argv[])
{
  MyName = argv[0];
  char* host_ptr = "localhost";
  char* ip_ptr = NULL;

  for(int i=0; i<argc; ++i) {
    if(argc == 1) {
      ip_ptr = getip(host_ptr);
    } else if(i ==0) {
      continue;
    } else if ( string(argv[i]) == "-h" || string(argv[i]) == "-?" ) {
        PrintUsage();
        break;
    } else {
      ip_ptr = getip(argv[i]);
    }
    if(ip_ptr == NULL) {
      cerr<<"BadHost "<<argv[i]<<endl;
    } else {
      cout<<ip_ptr<<endl;
    }
  }
  return 0;
}

//========================================================================
void PrintUsage(void)
{
  cout<<"Usage:"<<endl
      <<" "<<MyName<<" [HOSTNAME:localhost)"<<endl
      <<endl
      <<"  -h   :  Display this message."<<endl
      <<"  -?   :  Display this message."<<endl
      <<endl;

  exit(1);
}

//------------------------------------------------------------------------

