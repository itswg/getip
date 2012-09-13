//===========================================================================
// FILE:        TclInterface.C
// DESCRIPTION: Tcl library using getip_code
// AUTHOR:      Matthew Bruckler (matt@bruckler.net)
// ORIG_DATE:   Sep 10, 2012
//===========================================================================
#include "getip_code.h"
#include <tcl.h>
#include <iostream>
#include <sstream>
#include <string>
 using namespace std;

int getip_interface(ClientData clientData,
          Tcl_Interp *interp, int argc, Tcl_Obj *const argv[]) {
  char* host_ptr = (char*)"localhost";
  char* ip_ptr = NULL;
  stringstream result;
  for(int i=0; i<argc; ++i) {
    if(argc == 1) {
      ip_ptr = getip(host_ptr);
    } else if(i ==0) {
      continue;
    } else {
      ip_ptr = getip(Tcl_GetString(argv[i]));
    }
    if(ip_ptr == NULL) {
      result<<"BadHost "<<Tcl_GetString(argv[i])<<endl;
    } else {
      result<<ip_ptr<<endl;
    }
  }
  Tcl_SetResult(interp,const_cast<char*>(result.str().c_str()), TCL_VOLATILE);
  return TCL_OK;
}

//-----------------------------------------------------------------------
extern "C" int Getiptcl_Init(Tcl_Interp *interp)
{
  if (Tcl_InitStubs(interp, "8.1", 0) == NULL) {
    return TCL_ERROR;
  }
  Tcl_CreateObjCommand(interp, "getip", getip_interface, NULL, NULL);
  return TCL_OK;
}

//-----------------------------------------------------------------------
