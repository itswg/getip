#include <arpa/inet.h>
#include <netdb.h>
#include <sys/types.h>
#include <signal.h>

#include <iostream>
#include <string>
 using namespace std;
#include <stdlib.h>

char* getip(const char*);
void PrintUsage(void);

string MyName = "";

int main (int argc, const char *argv[])
{
  MyName = argv[0];
  string buffer;
  gethostname(const_cast<char*>(buffer.c_str()), 256);

  for( int i=1; i<argc; i++) {
    if ( string(argv[i]) == "-h" ||
         string(argv[i]) == "-?" ) {
        PrintUsage();
    } else if ( string(argv[i]) == "localhost") {
    } else {
      buffer = argv[i];
    }
  }
  char* ip_ptr = getip(buffer.c_str());
  if (ip_ptr == NULL) {
    cerr<<"BadHost"<<endl;
    return 1;
  } else {
    string ip = ip_ptr;
    cout<<ip<<endl;
  }
  return 0;
}

//========================================================================
char* getip(const char* host)
{
  struct hostent* h;
  h = gethostbyname(host);

  char * val;
  if (h) {
    val = inet_ntoa(*(struct in_addr *)h->h_addr);
  } else {
   val = NULL;
  }
  return val;
}

//------------------------------------------------------------------------
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

