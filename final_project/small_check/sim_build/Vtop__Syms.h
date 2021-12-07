// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef _VTOP__SYMS_H_
#define _VTOP__SYMS_H_  // guard

#include "verilated_heavy.h"

// INCLUDE MODULE CLASSES
#include "Vtop.h"

// DPI TYPES for DPI Export callbacks (Internal use)

// SYMS CLASS
class Vtop__Syms : public VerilatedSyms {
  public:
    
    // LOCAL STATE
    const char* __Vm_namep;
    bool __Vm_activity;  ///< Used by trace routines to determine change occurred
    uint32_t __Vm_baseCode;  ///< Used by trace routines when tracing multiple models
    bool __Vm_didInit;
    
    // SUBCELL STATE
    Vtop*                          TOPp;
    
    // SCOPE NAMES
    VerilatedScope __Vscope_TOP;
    VerilatedScope __Vscope_mkcheck;
    VerilatedScope __Vscope_mkcheck__router1;
    VerilatedScope __Vscope_mkcheck__router1__input_link;
    VerilatedScope __Vscope_mkcheck__router1__input_link__error_checks;
    VerilatedScope __Vscope_mkcheck__router1__vir_chnl_1;
    VerilatedScope __Vscope_mkcheck__router1__vir_chnl_1__error_checks;
    VerilatedScope __Vscope_mkcheck__router1__vir_chnl_2;
    VerilatedScope __Vscope_mkcheck__router1__vir_chnl_2__error_checks;
    VerilatedScope __Vscope_mkcheck__router1__vir_chnl_3;
    VerilatedScope __Vscope_mkcheck__router1__vir_chnl_3__error_checks;
    VerilatedScope __Vscope_mkcheck__router1__vir_chnl_4;
    VerilatedScope __Vscope_mkcheck__router1__vir_chnl_4__error_checks;
    VerilatedScope __Vscope_mkcheck__router1__vir_chnl_5;
    VerilatedScope __Vscope_mkcheck__router1__vir_chnl_5__error_checks;
    VerilatedScope __Vscope_mkcheck__router1__vir_chnl_6;
    VerilatedScope __Vscope_mkcheck__router1__vir_chnl_6__error_checks;
    VerilatedScope __Vscope_mkcheck__router2;
    VerilatedScope __Vscope_mkcheck__router2__input_link;
    VerilatedScope __Vscope_mkcheck__router2__input_link__error_checks;
    VerilatedScope __Vscope_mkcheck__router2__vir_chnl_1;
    VerilatedScope __Vscope_mkcheck__router2__vir_chnl_1__error_checks;
    VerilatedScope __Vscope_mkcheck__router2__vir_chnl_2;
    VerilatedScope __Vscope_mkcheck__router2__vir_chnl_2__error_checks;
    VerilatedScope __Vscope_mkcheck__router2__vir_chnl_3;
    VerilatedScope __Vscope_mkcheck__router2__vir_chnl_3__error_checks;
    VerilatedScope __Vscope_mkcheck__router2__vir_chnl_4;
    VerilatedScope __Vscope_mkcheck__router2__vir_chnl_4__error_checks;
    VerilatedScope __Vscope_mkcheck__router2__vir_chnl_5;
    VerilatedScope __Vscope_mkcheck__router2__vir_chnl_5__error_checks;
    VerilatedScope __Vscope_mkcheck__router2__vir_chnl_6;
    VerilatedScope __Vscope_mkcheck__router2__vir_chnl_6__error_checks;
    
    // SCOPE HIERARCHY
    VerilatedHierarchy __Vhier;
    
    // CREATORS
    Vtop__Syms(Vtop* topp, const char* namep);
    ~Vtop__Syms() = default;
    
    // METHODS
    inline const char* name() { return __Vm_namep; }
    
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

#endif  // guard
