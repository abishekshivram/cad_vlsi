// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop.h for the primary calling header

#include "Vtop.h"
#include "Vtop__Syms.h"

#include "verilated_dpi.h"

//==========

void Vtop::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vtop::eval\n"); );
    Vtop__Syms* __restrict vlSymsp = this->__VlSymsp;  // Setup global symbol table
    Vtop* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
#ifdef VL_DEBUG
    // Debug assertions
    _eval_debug_assertions();
#endif  // VL_DEBUG
    // Initialize
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) _eval_initial_loop(vlSymsp);
    // MTask 0 start
    VL_DEBUG_IF(VL_DBG_MSGF("MTask0 starting\n"););
    Verilated::mtaskId(0);
    // Evaluate till stable
    int __VclockLoop = 0;
    QData __Vchange = 1;
    do {
        VL_DEBUG_IF(VL_DBG_MSGF("+ Clock loop\n"););
        vlSymsp->__Vm_activity = true;
        _eval(vlSymsp);
        if (VL_UNLIKELY(++__VclockLoop > 100)) {
            // About to fail, so enable debug to see what's not settling.
            // Note you must run make with OPT=-DVL_DEBUG for debug prints.
            int __Vsaved_debug = Verilated::debug();
            Verilated::debug(1);
            __Vchange = _change_request(vlSymsp);
            Verilated::debug(__Vsaved_debug);
            VL_FATAL_MT("verilog/mkcheck.v", 29, "",
                "Verilated model didn't converge\n"
                "- See DIDNOTCONVERGE in the Verilator manual");
        } else {
            __Vchange = _change_request(vlSymsp);
        }
    } while (VL_UNLIKELY(__Vchange));
    Verilated::endOfThreadMTask(vlSymsp->__Vm_evalMsgQp);
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

void Vtop::_eval_initial_loop(Vtop__Syms* __restrict vlSymsp) {
    vlSymsp->__Vm_didInit = true;
    _eval_initial(vlSymsp);
    vlSymsp->__Vm_activity = true;
    // Evaluate till stable
    int __VclockLoop = 0;
    QData __Vchange = 1;
    do {
        _eval_settle(vlSymsp);
        _eval(vlSymsp);
        if (VL_UNLIKELY(++__VclockLoop > 100)) {
            // About to fail, so enable debug to see what's not settling.
            // Note you must run make with OPT=-DVL_DEBUG for debug prints.
            int __Vsaved_debug = Verilated::debug();
            Verilated::debug(1);
            __Vchange = _change_request(vlSymsp);
            Verilated::debug(__Vsaved_debug);
            VL_FATAL_MT("verilog/mkcheck.v", 29, "",
                "Verilated model didn't DC converge\n"
                "- See DIDNOTCONVERGE in the Verilator manual");
        } else {
            __Vchange = _change_request(vlSymsp);
        }
    } while (VL_UNLIKELY(__Vchange));
}

VL_INLINE_OPT void Vtop::_sequent__TOP__2(Vtop__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop::_sequent__TOP__2\n"); );
    Vtop* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Variables
    // Begin mtask footprint all: 
    CData/*0:0*/ __Vdly__mkcheck__DOT__router1__DOT__input_link__DOT__empty_reg;
    CData/*0:0*/ __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__empty_reg;
    CData/*0:0*/ __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__empty_reg;
    CData/*0:0*/ __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__empty_reg;
    CData/*0:0*/ __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__empty_reg;
    CData/*0:0*/ __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__empty_reg;
    CData/*0:0*/ __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__empty_reg;
    CData/*0:0*/ __Vdly__mkcheck__DOT__router2__DOT__input_link__DOT__empty_reg;
    CData/*0:0*/ __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__empty_reg;
    CData/*0:0*/ __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__empty_reg;
    CData/*0:0*/ __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__empty_reg;
    CData/*0:0*/ __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__empty_reg;
    CData/*0:0*/ __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__empty_reg;
    CData/*0:0*/ __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__empty_reg;
    // Body
    __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__empty_reg 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__empty_reg;
    __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__empty_reg 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__empty_reg;
    __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__empty_reg 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__empty_reg;
    __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__empty_reg 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__empty_reg;
    __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__empty_reg 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__empty_reg;
    __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__empty_reg 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__empty_reg;
    __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__empty_reg 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__empty_reg;
    __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__empty_reg 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__empty_reg;
    __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__empty_reg 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__empty_reg;
    __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__empty_reg 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__empty_reg;
    __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__empty_reg 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__empty_reg;
    __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__empty_reg 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__empty_reg;
    __Vdly__mkcheck__DOT__router2__DOT__input_link__DOT__empty_reg 
        = vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__empty_reg;
    __Vdly__mkcheck__DOT__router1__DOT__input_link__DOT__empty_reg 
        = vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__error_checks__DOT__deqerror = 0U;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__error_checks__DOT__enqerror = 0U;
    if (vlTOPp->RST_N) {
        if (VL_UNLIKELY(((~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__empty_reg)) 
                         & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_DEQ)))) {
            vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__error_checks__DOT__deqerror = 1U;
            VL_WRITEF("Warning: FIFO2: %Nmkcheck.router2.vir_chnl_1.error_checks -- Dequeuing from empty fifo\n",
                      vlSymsp->name());
            Verilated::runFlushCallbacks();
        }
        if (VL_UNLIKELY(((~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__full_reg)) 
                         & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_ENQ)))) {
            VL_WRITEF("Warning: FIFO2: %Nmkcheck.router2.vir_chnl_1.error_checks -- Enqueuing to a full fifo\n",
                      vlSymsp->name());
            Verilated::runFlushCallbacks();
            vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__error_checks__DOT__enqerror = 1U;
        }
    }
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__error_checks__DOT__deqerror = 0U;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__error_checks__DOT__enqerror = 0U;
    if (vlTOPp->RST_N) {
        if (VL_UNLIKELY(((~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__empty_reg)) 
                         & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_DEQ)))) {
            vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__error_checks__DOT__deqerror = 1U;
            VL_WRITEF("Warning: FIFO2: %Nmkcheck.router2.vir_chnl_2.error_checks -- Dequeuing from empty fifo\n",
                      vlSymsp->name());
            Verilated::runFlushCallbacks();
        }
        if (VL_UNLIKELY(((~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__full_reg)) 
                         & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_ENQ)))) {
            VL_WRITEF("Warning: FIFO2: %Nmkcheck.router2.vir_chnl_2.error_checks -- Enqueuing to a full fifo\n",
                      vlSymsp->name());
            Verilated::runFlushCallbacks();
            vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__error_checks__DOT__enqerror = 1U;
        }
    }
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__error_checks__DOT__deqerror = 0U;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__error_checks__DOT__enqerror = 0U;
    if (vlTOPp->RST_N) {
        if (VL_UNLIKELY(((~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__empty_reg)) 
                         & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_DEQ)))) {
            vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__error_checks__DOT__deqerror = 1U;
            VL_WRITEF("Warning: FIFO2: %Nmkcheck.router2.vir_chnl_3.error_checks -- Dequeuing from empty fifo\n",
                      vlSymsp->name());
            Verilated::runFlushCallbacks();
        }
        if (VL_UNLIKELY(((~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__full_reg)) 
                         & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_ENQ)))) {
            VL_WRITEF("Warning: FIFO2: %Nmkcheck.router2.vir_chnl_3.error_checks -- Enqueuing to a full fifo\n",
                      vlSymsp->name());
            Verilated::runFlushCallbacks();
            vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__error_checks__DOT__enqerror = 1U;
        }
    }
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__error_checks__DOT__deqerror = 0U;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__error_checks__DOT__enqerror = 0U;
    if (vlTOPp->RST_N) {
        if (VL_UNLIKELY(((~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__empty_reg)) 
                         & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_DEQ)))) {
            vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__error_checks__DOT__deqerror = 1U;
            VL_WRITEF("Warning: FIFO2: %Nmkcheck.router2.vir_chnl_4.error_checks -- Dequeuing from empty fifo\n",
                      vlSymsp->name());
            Verilated::runFlushCallbacks();
        }
        if (VL_UNLIKELY(((~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__full_reg)) 
                         & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_ENQ)))) {
            VL_WRITEF("Warning: FIFO2: %Nmkcheck.router2.vir_chnl_4.error_checks -- Enqueuing to a full fifo\n",
                      vlSymsp->name());
            Verilated::runFlushCallbacks();
            vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__error_checks__DOT__enqerror = 1U;
        }
    }
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__error_checks__DOT__deqerror = 0U;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__error_checks__DOT__enqerror = 0U;
    if (vlTOPp->RST_N) {
        if (VL_UNLIKELY(((~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__empty_reg)) 
                         & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_DEQ)))) {
            vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__error_checks__DOT__deqerror = 1U;
            VL_WRITEF("Warning: FIFO2: %Nmkcheck.router2.vir_chnl_5.error_checks -- Dequeuing from empty fifo\n",
                      vlSymsp->name());
            Verilated::runFlushCallbacks();
        }
        if (VL_UNLIKELY(((~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__full_reg)) 
                         & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_ENQ)))) {
            VL_WRITEF("Warning: FIFO2: %Nmkcheck.router2.vir_chnl_5.error_checks -- Enqueuing to a full fifo\n",
                      vlSymsp->name());
            Verilated::runFlushCallbacks();
            vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__error_checks__DOT__enqerror = 1U;
        }
    }
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__error_checks__DOT__deqerror = 0U;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__error_checks__DOT__enqerror = 0U;
    if (vlTOPp->RST_N) {
        if (VL_UNLIKELY(((~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__empty_reg)) 
                         & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_DEQ)))) {
            vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__error_checks__DOT__deqerror = 1U;
            VL_WRITEF("Warning: FIFO2: %Nmkcheck.router2.vir_chnl_6.error_checks -- Dequeuing from empty fifo\n",
                      vlSymsp->name());
            Verilated::runFlushCallbacks();
        }
        if (VL_UNLIKELY(((~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__full_reg)) 
                         & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_ENQ)))) {
            VL_WRITEF("Warning: FIFO2: %Nmkcheck.router2.vir_chnl_6.error_checks -- Enqueuing to a full fifo\n",
                      vlSymsp->name());
            Verilated::runFlushCallbacks();
            vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__error_checks__DOT__enqerror = 1U;
        }
    }
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__error_checks__DOT__deqerror = 0U;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__error_checks__DOT__enqerror = 0U;
    if (vlTOPp->RST_N) {
        if (VL_UNLIKELY(((~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__empty_reg)) 
                         & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_DEQ)))) {
            vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__error_checks__DOT__deqerror = 1U;
            VL_WRITEF("Warning: FIFO2: %Nmkcheck.router1.vir_chnl_1.error_checks -- Dequeuing from empty fifo\n",
                      vlSymsp->name());
            Verilated::runFlushCallbacks();
        }
        if (VL_UNLIKELY(((~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__full_reg)) 
                         & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_ENQ)))) {
            VL_WRITEF("Warning: FIFO2: %Nmkcheck.router1.vir_chnl_1.error_checks -- Enqueuing to a full fifo\n",
                      vlSymsp->name());
            Verilated::runFlushCallbacks();
            vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__error_checks__DOT__enqerror = 1U;
        }
    }
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__error_checks__DOT__deqerror = 0U;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__error_checks__DOT__enqerror = 0U;
    if (vlTOPp->RST_N) {
        if (VL_UNLIKELY(((~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__empty_reg)) 
                         & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_DEQ)))) {
            vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__error_checks__DOT__deqerror = 1U;
            VL_WRITEF("Warning: FIFO2: %Nmkcheck.router1.vir_chnl_2.error_checks -- Dequeuing from empty fifo\n",
                      vlSymsp->name());
            Verilated::runFlushCallbacks();
        }
        if (VL_UNLIKELY(((~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__full_reg)) 
                         & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_ENQ)))) {
            VL_WRITEF("Warning: FIFO2: %Nmkcheck.router1.vir_chnl_2.error_checks -- Enqueuing to a full fifo\n",
                      vlSymsp->name());
            Verilated::runFlushCallbacks();
            vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__error_checks__DOT__enqerror = 1U;
        }
    }
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__error_checks__DOT__deqerror = 0U;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__error_checks__DOT__enqerror = 0U;
    if (vlTOPp->RST_N) {
        if (VL_UNLIKELY(((~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__empty_reg)) 
                         & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_DEQ)))) {
            vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__error_checks__DOT__deqerror = 1U;
            VL_WRITEF("Warning: FIFO2: %Nmkcheck.router1.vir_chnl_3.error_checks -- Dequeuing from empty fifo\n",
                      vlSymsp->name());
            Verilated::runFlushCallbacks();
        }
        if (VL_UNLIKELY(((~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__full_reg)) 
                         & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_ENQ)))) {
            VL_WRITEF("Warning: FIFO2: %Nmkcheck.router1.vir_chnl_3.error_checks -- Enqueuing to a full fifo\n",
                      vlSymsp->name());
            Verilated::runFlushCallbacks();
            vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__error_checks__DOT__enqerror = 1U;
        }
    }
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__error_checks__DOT__deqerror = 0U;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__error_checks__DOT__enqerror = 0U;
    if (vlTOPp->RST_N) {
        if (VL_UNLIKELY(((~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__empty_reg)) 
                         & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_DEQ)))) {
            vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__error_checks__DOT__deqerror = 1U;
            VL_WRITEF("Warning: FIFO2: %Nmkcheck.router1.vir_chnl_4.error_checks -- Dequeuing from empty fifo\n",
                      vlSymsp->name());
            Verilated::runFlushCallbacks();
        }
        if (VL_UNLIKELY(((~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__full_reg)) 
                         & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_ENQ)))) {
            VL_WRITEF("Warning: FIFO2: %Nmkcheck.router1.vir_chnl_4.error_checks -- Enqueuing to a full fifo\n",
                      vlSymsp->name());
            Verilated::runFlushCallbacks();
            vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__error_checks__DOT__enqerror = 1U;
        }
    }
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__error_checks__DOT__deqerror = 0U;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__error_checks__DOT__enqerror = 0U;
    if (vlTOPp->RST_N) {
        if (VL_UNLIKELY(((~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__empty_reg)) 
                         & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_DEQ)))) {
            vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__error_checks__DOT__deqerror = 1U;
            VL_WRITEF("Warning: FIFO2: %Nmkcheck.router1.vir_chnl_5.error_checks -- Dequeuing from empty fifo\n",
                      vlSymsp->name());
            Verilated::runFlushCallbacks();
        }
        if (VL_UNLIKELY(((~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__full_reg)) 
                         & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_ENQ)))) {
            VL_WRITEF("Warning: FIFO2: %Nmkcheck.router1.vir_chnl_5.error_checks -- Enqueuing to a full fifo\n",
                      vlSymsp->name());
            Verilated::runFlushCallbacks();
            vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__error_checks__DOT__enqerror = 1U;
        }
    }
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__error_checks__DOT__deqerror = 0U;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__error_checks__DOT__enqerror = 0U;
    if (vlTOPp->RST_N) {
        if (VL_UNLIKELY(((~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__empty_reg)) 
                         & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_DEQ)))) {
            vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__error_checks__DOT__deqerror = 1U;
            VL_WRITEF("Warning: FIFO2: %Nmkcheck.router1.vir_chnl_6.error_checks -- Dequeuing from empty fifo\n",
                      vlSymsp->name());
            Verilated::runFlushCallbacks();
        }
        if (VL_UNLIKELY(((~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__full_reg)) 
                         & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_ENQ)))) {
            VL_WRITEF("Warning: FIFO2: %Nmkcheck.router1.vir_chnl_6.error_checks -- Enqueuing to a full fifo\n",
                      vlSymsp->name());
            Verilated::runFlushCallbacks();
            vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__error_checks__DOT__enqerror = 1U;
        }
    }
    vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__error_checks__DOT__deqerror = 0U;
    vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__error_checks__DOT__enqerror = 0U;
    if (vlTOPp->RST_N) {
        if (VL_UNLIKELY(((~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__empty_reg)) 
                         & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__input_link_DEQ)))) {
            vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__error_checks__DOT__deqerror = 1U;
            VL_WRITEF("Warning: FIFO2: %Nmkcheck.router2.input_link.error_checks -- Dequeuing from empty fifo\n",
                      vlSymsp->name());
            Verilated::runFlushCallbacks();
        }
        if (VL_UNLIKELY(((~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__full_reg)) 
                         & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__input_link_ENQ)))) {
            VL_WRITEF("Warning: FIFO2: %Nmkcheck.router2.input_link.error_checks -- Enqueuing to a full fifo\n",
                      vlSymsp->name());
            Verilated::runFlushCallbacks();
            vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__error_checks__DOT__enqerror = 1U;
        }
    }
    vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__error_checks__DOT__deqerror = 0U;
    vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__error_checks__DOT__enqerror = 0U;
    if (vlTOPp->RST_N) {
        if (VL_UNLIKELY(((~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__empty_reg)) 
                         & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__input_link_DEQ)))) {
            vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__error_checks__DOT__deqerror = 1U;
            VL_WRITEF("Warning: FIFO2: %Nmkcheck.router1.input_link.error_checks -- Dequeuing from empty fifo\n",
                      vlSymsp->name());
            Verilated::runFlushCallbacks();
        }
        if (VL_UNLIKELY(((~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__full_reg)) 
                         & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__input_link_ENQ)))) {
            VL_WRITEF("Warning: FIFO2: %Nmkcheck.router1.input_link.error_checks -- Enqueuing to a full fifo\n",
                      vlSymsp->name());
            Verilated::runFlushCallbacks();
            vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__error_checks__DOT__enqerror = 1U;
        }
    }
    if (vlTOPp->RST_N) {
        if (vlTOPp->mkcheck__DOT__check2_EN) {
            vlTOPp->mkcheck__DOT__check2 = vlTOPp->mkcheck__DOT__check2_D_IN;
        }
    } else {
        vlTOPp->mkcheck__DOT__check2 = 0U;
    }
    if (vlTOPp->RST_N) {
        if (vlTOPp->mkcheck__DOT__check1_EN) {
            vlTOPp->mkcheck__DOT__check1 = vlTOPp->mkcheck__DOT__check1_D_IN;
        }
    } else {
        vlTOPp->mkcheck__DOT__check1 = 0U;
    }
    if (vlTOPp->RST_N) {
        if (vlTOPp->mkcheck__DOT__router2__DOT__my_id_EN) {
            vlTOPp->mkcheck__DOT__router2__DOT__my_id 
                = vlTOPp->mkcheck__DOT__router2__DOT__my_id_D_IN;
        }
    } else {
        vlTOPp->mkcheck__DOT__router2__DOT__my_id = 1U;
    }
    if (vlTOPp->RST_N) {
        if (vlTOPp->mkcheck__DOT__router1__DOT__my_id_EN) {
            vlTOPp->mkcheck__DOT__router1__DOT__my_id 
                = vlTOPp->mkcheck__DOT__router1__DOT__my_id_D_IN;
        }
    } else {
        vlTOPp->mkcheck__DOT__router1__DOT__my_id = 0U;
    }
    if (vlTOPp->RST_N) {
        if (vlTOPp->mkcheck__DOT__router2__DOT__cycle_EN) {
            vlTOPp->mkcheck__DOT__router2__DOT__cycle 
                = vlTOPp->mkcheck__DOT__router2__DOT__cycle_D_IN;
        }
    } else {
        vlTOPp->mkcheck__DOT__router2__DOT__cycle = 0U;
    }
    if (vlTOPp->RST_N) {
        if (vlTOPp->mkcheck__DOT__router1__DOT__cycle_EN) {
            vlTOPp->mkcheck__DOT__router1__DOT__cycle 
                = vlTOPp->mkcheck__DOT__router1__DOT__cycle_D_IN;
        }
    } else {
        vlTOPp->mkcheck__DOT__router1__DOT__cycle = 0U;
    }
    if (vlTOPp->RST_N) {
        vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__data0_reg 
            = ((((- (IData)((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__d0di))) 
                 & vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_D_IN) 
                | ((- (IData)((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__d0d1))) 
                   & vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__data1_reg)) 
               | ((- (IData)((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__d0h))) 
                  & vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__data0_reg));
        vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__data1_reg 
            = ((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__d1di)
                ? vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_D_IN
                : vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__data1_reg);
    } else {
        vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__data0_reg = 0U;
        vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__data1_reg = 0U;
    }
    if (vlTOPp->RST_N) {
        vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__data0_reg 
            = ((((- (IData)((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__d0di))) 
                 & vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_D_IN) 
                | ((- (IData)((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__d0d1))) 
                   & vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__data1_reg)) 
               | ((- (IData)((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__d0h))) 
                  & vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__data0_reg));
        vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__data1_reg 
            = ((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__d1di)
                ? vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_D_IN
                : vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__data1_reg);
    } else {
        vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__data0_reg = 0U;
        vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__data1_reg = 0U;
    }
    if (vlTOPp->RST_N) {
        vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__data0_reg 
            = ((((- (IData)((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__d0di))) 
                 & vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_D_IN) 
                | ((- (IData)((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__d0d1))) 
                   & vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__data1_reg)) 
               | ((- (IData)((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__d0h))) 
                  & vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__data0_reg));
        vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__data1_reg 
            = ((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__d1di)
                ? vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_D_IN
                : vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__data1_reg);
    } else {
        vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__data0_reg = 0U;
        vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__data1_reg = 0U;
    }
    if (vlTOPp->RST_N) {
        vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__data0_reg 
            = ((((- (IData)((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__d0di))) 
                 & vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_D_IN) 
                | ((- (IData)((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__d0d1))) 
                   & vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__data1_reg)) 
               | ((- (IData)((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__d0h))) 
                  & vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__data0_reg));
        vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__data1_reg 
            = ((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__d1di)
                ? vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_D_IN
                : vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__data1_reg);
    } else {
        vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__data0_reg = 0U;
        vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__data1_reg = 0U;
    }
    if (vlTOPp->RST_N) {
        vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__data0_reg 
            = ((((- (IData)((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__d0di))) 
                 & vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_D_IN) 
                | ((- (IData)((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__d0d1))) 
                   & vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__data1_reg)) 
               | ((- (IData)((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__d0h))) 
                  & vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__data0_reg));
        vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__data1_reg 
            = ((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__d1di)
                ? vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_D_IN
                : vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__data1_reg);
    } else {
        vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__data0_reg = 0U;
        vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__data1_reg = 0U;
    }
    if (vlTOPp->RST_N) {
        vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__data0_reg 
            = ((((- (IData)((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__d0di))) 
                 & vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_D_IN) 
                | ((- (IData)((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__d0d1))) 
                   & vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__data1_reg)) 
               | ((- (IData)((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__d0h))) 
                  & vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__data0_reg));
        vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__data1_reg 
            = ((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__d1di)
                ? vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_D_IN
                : vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__data1_reg);
    } else {
        vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__data0_reg = 0U;
        vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__data1_reg = 0U;
    }
    if (vlTOPp->RST_N) {
        if (vlTOPp->mkcheck__DOT__counter_EN) {
            vlTOPp->mkcheck__DOT__counter = vlTOPp->mkcheck__DOT__counter_D_IN;
        }
    } else {
        vlTOPp->mkcheck__DOT__counter = 0U;
    }
    if (vlTOPp->RST_N) {
        vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__data0_reg 
            = ((((- (IData)((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__d0di))) 
                 & vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_D_IN) 
                | ((- (IData)((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__d0d1))) 
                   & vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__data1_reg)) 
               | ((- (IData)((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__d0h))) 
                  & vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__data0_reg));
        vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__data1_reg 
            = ((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__d1di)
                ? vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_D_IN
                : vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__data1_reg);
    } else {
        vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__data0_reg = 0U;
        vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__data1_reg = 0U;
    }
    if (vlTOPp->RST_N) {
        vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__data0_reg 
            = ((((- (IData)((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__d0di))) 
                 & vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_D_IN) 
                | ((- (IData)((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__d0d1))) 
                   & vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__data1_reg)) 
               | ((- (IData)((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__d0h))) 
                  & vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__data0_reg));
        vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__data1_reg 
            = ((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__d1di)
                ? vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_D_IN
                : vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__data1_reg);
    } else {
        vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__data0_reg = 0U;
        vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__data1_reg = 0U;
    }
    if (vlTOPp->RST_N) {
        vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__data0_reg 
            = ((((- (IData)((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__d0di))) 
                 & vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_D_IN) 
                | ((- (IData)((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__d0d1))) 
                   & vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__data1_reg)) 
               | ((- (IData)((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__d0h))) 
                  & vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__data0_reg));
        vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__data1_reg 
            = ((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__d1di)
                ? vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_D_IN
                : vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__data1_reg);
    } else {
        vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__data0_reg = 0U;
        vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__data1_reg = 0U;
    }
    if (vlTOPp->RST_N) {
        vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__data0_reg 
            = ((((- (IData)((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__d0di))) 
                 & vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_D_IN) 
                | ((- (IData)((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__d0d1))) 
                   & vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__data1_reg)) 
               | ((- (IData)((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__d0h))) 
                  & vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__data0_reg));
        vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__data1_reg 
            = ((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__d1di)
                ? vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_D_IN
                : vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__data1_reg);
    } else {
        vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__data0_reg = 0U;
        vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__data1_reg = 0U;
    }
    if (vlTOPp->RST_N) {
        vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__data0_reg 
            = ((((- (IData)((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__d0di))) 
                 & vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_D_IN) 
                | ((- (IData)((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__d0d1))) 
                   & vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__data1_reg)) 
               | ((- (IData)((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__d0h))) 
                  & vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__data0_reg));
        vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__data1_reg 
            = ((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__d1di)
                ? vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_D_IN
                : vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__data1_reg);
    } else {
        vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__data0_reg = 0U;
        vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__data1_reg = 0U;
    }
    if (vlTOPp->RST_N) {
        vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__data0_reg 
            = ((((- (IData)((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__d0di))) 
                 & vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_D_IN) 
                | ((- (IData)((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__d0d1))) 
                   & vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__data1_reg)) 
               | ((- (IData)((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__d0h))) 
                  & vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__data0_reg));
        vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__data1_reg 
            = ((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__d1di)
                ? vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_D_IN
                : vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__data1_reg);
    } else {
        vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__data0_reg = 0U;
        vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__data1_reg = 0U;
    }
    if (vlTOPp->RST_N) {
        if (vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_CLR) {
            __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__empty_reg = 0U;
        } else {
            if (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_ENQ) 
                 & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_DEQ)))) {
                __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__empty_reg = 1U;
            } else {
                if (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_DEQ) 
                     & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_ENQ)))) {
                    __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__empty_reg 
                        = (1U & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__full_reg)));
                }
            }
        }
    } else {
        __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__empty_reg = 0U;
    }
    if (vlTOPp->RST_N) {
        if (vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_CLR) {
            __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__empty_reg = 0U;
        } else {
            if (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_ENQ) 
                 & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_DEQ)))) {
                __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__empty_reg = 1U;
            } else {
                if (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_DEQ) 
                     & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_ENQ)))) {
                    __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__empty_reg 
                        = (1U & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__full_reg)));
                }
            }
        }
    } else {
        __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__empty_reg = 0U;
    }
    if (vlTOPp->RST_N) {
        if (vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_CLR) {
            __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__empty_reg = 0U;
        } else {
            if (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_ENQ) 
                 & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_DEQ)))) {
                __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__empty_reg = 1U;
            } else {
                if (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_DEQ) 
                     & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_ENQ)))) {
                    __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__empty_reg 
                        = (1U & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__full_reg)));
                }
            }
        }
    } else {
        __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__empty_reg = 0U;
    }
    if (vlTOPp->RST_N) {
        if (vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_CLR) {
            __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__empty_reg = 0U;
        } else {
            if (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_ENQ) 
                 & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_DEQ)))) {
                __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__empty_reg = 1U;
            } else {
                if (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_DEQ) 
                     & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_ENQ)))) {
                    __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__empty_reg 
                        = (1U & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__full_reg)));
                }
            }
        }
    } else {
        __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__empty_reg = 0U;
    }
    if (vlTOPp->RST_N) {
        if (vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_CLR) {
            __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__empty_reg = 0U;
        } else {
            if (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_ENQ) 
                 & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_DEQ)))) {
                __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__empty_reg = 1U;
            } else {
                if (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_DEQ) 
                     & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_ENQ)))) {
                    __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__empty_reg 
                        = (1U & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__full_reg)));
                }
            }
        }
    } else {
        __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__empty_reg = 0U;
    }
    if (vlTOPp->RST_N) {
        if (vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_CLR) {
            __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__empty_reg = 0U;
        } else {
            if (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_ENQ) 
                 & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_DEQ)))) {
                __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__empty_reg = 1U;
            } else {
                if (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_DEQ) 
                     & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_ENQ)))) {
                    __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__empty_reg 
                        = (1U & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__full_reg)));
                }
            }
        }
    } else {
        __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__empty_reg = 0U;
    }
    if (vlTOPp->RST_N) {
        if (vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_CLR) {
            __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__empty_reg = 0U;
        } else {
            if (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_ENQ) 
                 & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_DEQ)))) {
                __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__empty_reg = 1U;
            } else {
                if (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_DEQ) 
                     & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_ENQ)))) {
                    __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__empty_reg 
                        = (1U & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__full_reg)));
                }
            }
        }
    } else {
        __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__empty_reg = 0U;
    }
    if (vlTOPp->RST_N) {
        if (vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_CLR) {
            __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__empty_reg = 0U;
        } else {
            if (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_ENQ) 
                 & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_DEQ)))) {
                __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__empty_reg = 1U;
            } else {
                if (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_DEQ) 
                     & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_ENQ)))) {
                    __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__empty_reg 
                        = (1U & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__full_reg)));
                }
            }
        }
    } else {
        __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__empty_reg = 0U;
    }
    if (vlTOPp->RST_N) {
        if (vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_CLR) {
            __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__empty_reg = 0U;
        } else {
            if (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_ENQ) 
                 & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_DEQ)))) {
                __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__empty_reg = 1U;
            } else {
                if (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_DEQ) 
                     & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_ENQ)))) {
                    __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__empty_reg 
                        = (1U & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__full_reg)));
                }
            }
        }
    } else {
        __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__empty_reg = 0U;
    }
    if (vlTOPp->RST_N) {
        if (vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_CLR) {
            __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__empty_reg = 0U;
        } else {
            if (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_ENQ) 
                 & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_DEQ)))) {
                __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__empty_reg = 1U;
            } else {
                if (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_DEQ) 
                     & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_ENQ)))) {
                    __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__empty_reg 
                        = (1U & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__full_reg)));
                }
            }
        }
    } else {
        __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__empty_reg = 0U;
    }
    if (vlTOPp->RST_N) {
        if (vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_CLR) {
            __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__empty_reg = 0U;
        } else {
            if (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_ENQ) 
                 & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_DEQ)))) {
                __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__empty_reg = 1U;
            } else {
                if (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_DEQ) 
                     & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_ENQ)))) {
                    __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__empty_reg 
                        = (1U & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__full_reg)));
                }
            }
        }
    } else {
        __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__empty_reg = 0U;
    }
    if (vlTOPp->RST_N) {
        if (vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_CLR) {
            __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__empty_reg = 0U;
        } else {
            if (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_ENQ) 
                 & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_DEQ)))) {
                __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__empty_reg = 1U;
            } else {
                if (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_DEQ) 
                     & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_ENQ)))) {
                    __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__empty_reg 
                        = (1U & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__full_reg)));
                }
            }
        }
    } else {
        __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__empty_reg = 0U;
    }
    if (vlTOPp->RST_N) {
        if (vlTOPp->mkcheck__DOT__router2__DOT__input_link_CLR) {
            __Vdly__mkcheck__DOT__router2__DOT__input_link__DOT__empty_reg = 0U;
        } else {
            if (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__input_link_ENQ) 
                 & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__input_link_DEQ)))) {
                __Vdly__mkcheck__DOT__router2__DOT__input_link__DOT__empty_reg = 1U;
            } else {
                if (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__input_link_DEQ) 
                     & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__input_link_ENQ)))) {
                    __Vdly__mkcheck__DOT__router2__DOT__input_link__DOT__empty_reg 
                        = (1U & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__full_reg)));
                }
            }
        }
    } else {
        __Vdly__mkcheck__DOT__router2__DOT__input_link__DOT__empty_reg = 0U;
    }
    if (vlTOPp->RST_N) {
        vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__data0_reg 
            = ((((- (IData)((IData)(vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__d0di))) 
                 & vlTOPp->mkcheck__DOT__router2__DOT__input_link_D_IN) 
                | ((- (IData)((IData)(vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__d0d1))) 
                   & vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__data1_reg)) 
               | ((- (IData)((IData)(vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__d0h))) 
                  & vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__data0_reg));
        vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__data1_reg 
            = ((IData)(vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__d1di)
                ? vlTOPp->mkcheck__DOT__router2__DOT__input_link_D_IN
                : vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__data1_reg);
    } else {
        vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__data0_reg = 0U;
        vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__data1_reg = 0U;
    }
    if (vlTOPp->RST_N) {
        vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__data0_reg 
            = ((((- (IData)((IData)(vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__d0di))) 
                 & vlTOPp->mkcheck__DOT__router1__DOT__input_link_D_IN) 
                | ((- (IData)((IData)(vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__d0d1))) 
                   & vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__data1_reg)) 
               | ((- (IData)((IData)(vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__d0h))) 
                  & vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__data0_reg));
        vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__data1_reg 
            = ((IData)(vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__d1di)
                ? vlTOPp->mkcheck__DOT__router1__DOT__input_link_D_IN
                : vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__data1_reg);
    } else {
        vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__data0_reg = 0U;
        vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__data1_reg = 0U;
    }
    if (vlTOPp->RST_N) {
        if (vlTOPp->mkcheck__DOT__router1__DOT__input_link_CLR) {
            __Vdly__mkcheck__DOT__router1__DOT__input_link__DOT__empty_reg = 0U;
        } else {
            if (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__input_link_ENQ) 
                 & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__input_link_DEQ)))) {
                __Vdly__mkcheck__DOT__router1__DOT__input_link__DOT__empty_reg = 1U;
            } else {
                if (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__input_link_DEQ) 
                     & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__input_link_ENQ)))) {
                    __Vdly__mkcheck__DOT__router1__DOT__input_link__DOT__empty_reg 
                        = (1U & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__full_reg)));
                }
            }
        }
    } else {
        __Vdly__mkcheck__DOT__router1__DOT__input_link__DOT__empty_reg = 0U;
    }
    vlTOPp->mkcheck__DOT__router2__DOT__cycle_D_IN 
        = (1U & ((IData)(1U) + (IData)(vlTOPp->mkcheck__DOT__router2__DOT__cycle)));
    vlTOPp->mkcheck__DOT__router1__DOT__cycle_D_IN 
        = (1U & ((IData)(1U) + (IData)(vlTOPp->mkcheck__DOT__router1__DOT__cycle)));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__D_OUT 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__data0_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__D_OUT 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__data0_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__D_OUT 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__data0_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__D_OUT 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__data0_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__D_OUT 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__data0_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__D_OUT 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__data0_reg;
    vlTOPp->mkcheck__DOT__counter_D_IN = ((IData)(1U) 
                                          + vlTOPp->mkcheck__DOT__counter);
    vlTOPp->mkcheck__DOT__NOT_counter_SLT_2___05F_d10 
        = (0x80000002U <= (0x80000000U ^ vlTOPp->mkcheck__DOT__counter));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__D_OUT 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__data0_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__D_OUT 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__data0_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__D_OUT 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__data0_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__D_OUT 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__data0_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__D_OUT 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__data0_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__D_OUT 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__data0_reg;
    if (vlTOPp->RST_N) {
        if (vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_CLR) {
            vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__full_reg = 1U;
        } else {
            if (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_ENQ) 
                 & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_DEQ)))) {
                vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__full_reg 
                    = (1U & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__empty_reg)));
            } else {
                if (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_DEQ) 
                     & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_ENQ)))) {
                    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__full_reg = 1U;
                }
            }
        }
    } else {
        vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__full_reg = 1U;
    }
    if (vlTOPp->RST_N) {
        if (vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_CLR) {
            vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__full_reg = 1U;
        } else {
            if (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_ENQ) 
                 & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_DEQ)))) {
                vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__full_reg 
                    = (1U & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__empty_reg)));
            } else {
                if (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_DEQ) 
                     & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_ENQ)))) {
                    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__full_reg = 1U;
                }
            }
        }
    } else {
        vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__full_reg = 1U;
    }
    if (vlTOPp->RST_N) {
        if (vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_CLR) {
            vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__full_reg = 1U;
        } else {
            if (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_ENQ) 
                 & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_DEQ)))) {
                vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__full_reg 
                    = (1U & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__empty_reg)));
            } else {
                if (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_DEQ) 
                     & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_ENQ)))) {
                    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__full_reg = 1U;
                }
            }
        }
    } else {
        vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__full_reg = 1U;
    }
    if (vlTOPp->RST_N) {
        if (vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_CLR) {
            vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__full_reg = 1U;
        } else {
            if (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_ENQ) 
                 & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_DEQ)))) {
                vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__full_reg 
                    = (1U & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__empty_reg)));
            } else {
                if (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_DEQ) 
                     & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_ENQ)))) {
                    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__full_reg = 1U;
                }
            }
        }
    } else {
        vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__full_reg = 1U;
    }
    if (vlTOPp->RST_N) {
        if (vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_CLR) {
            vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__full_reg = 1U;
        } else {
            if (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_ENQ) 
                 & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_DEQ)))) {
                vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__full_reg 
                    = (1U & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__empty_reg)));
            } else {
                if (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_DEQ) 
                     & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_ENQ)))) {
                    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__full_reg = 1U;
                }
            }
        }
    } else {
        vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__full_reg = 1U;
    }
    if (vlTOPp->RST_N) {
        if (vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_CLR) {
            vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__full_reg = 1U;
        } else {
            if (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_ENQ) 
                 & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_DEQ)))) {
                vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__full_reg 
                    = (1U & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__empty_reg)));
            } else {
                if (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_DEQ) 
                     & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_ENQ)))) {
                    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__full_reg = 1U;
                }
            }
        }
    } else {
        vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__full_reg = 1U;
    }
    if (vlTOPp->RST_N) {
        if (vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_CLR) {
            vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__full_reg = 1U;
        } else {
            if (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_ENQ) 
                 & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_DEQ)))) {
                vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__full_reg 
                    = (1U & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__empty_reg)));
            } else {
                if (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_DEQ) 
                     & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_ENQ)))) {
                    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__full_reg = 1U;
                }
            }
        }
    } else {
        vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__full_reg = 1U;
    }
    if (vlTOPp->RST_N) {
        if (vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_CLR) {
            vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__full_reg = 1U;
        } else {
            if (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_ENQ) 
                 & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_DEQ)))) {
                vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__full_reg 
                    = (1U & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__empty_reg)));
            } else {
                if (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_DEQ) 
                     & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_ENQ)))) {
                    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__full_reg = 1U;
                }
            }
        }
    } else {
        vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__full_reg = 1U;
    }
    if (vlTOPp->RST_N) {
        if (vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_CLR) {
            vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__full_reg = 1U;
        } else {
            if (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_ENQ) 
                 & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_DEQ)))) {
                vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__full_reg 
                    = (1U & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__empty_reg)));
            } else {
                if (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_DEQ) 
                     & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_ENQ)))) {
                    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__full_reg = 1U;
                }
            }
        }
    } else {
        vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__full_reg = 1U;
    }
    if (vlTOPp->RST_N) {
        if (vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_CLR) {
            vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__full_reg = 1U;
        } else {
            if (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_ENQ) 
                 & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_DEQ)))) {
                vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__full_reg 
                    = (1U & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__empty_reg)));
            } else {
                if (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_DEQ) 
                     & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_ENQ)))) {
                    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__full_reg = 1U;
                }
            }
        }
    } else {
        vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__full_reg = 1U;
    }
    if (vlTOPp->RST_N) {
        if (vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_CLR) {
            vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__full_reg = 1U;
        } else {
            if (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_ENQ) 
                 & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_DEQ)))) {
                vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__full_reg 
                    = (1U & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__empty_reg)));
            } else {
                if (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_DEQ) 
                     & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_ENQ)))) {
                    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__full_reg = 1U;
                }
            }
        }
    } else {
        vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__full_reg = 1U;
    }
    if (vlTOPp->RST_N) {
        if (vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_CLR) {
            vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__full_reg = 1U;
        } else {
            if (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_ENQ) 
                 & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_DEQ)))) {
                vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__full_reg 
                    = (1U & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__empty_reg)));
            } else {
                if (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_DEQ) 
                     & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_ENQ)))) {
                    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__full_reg = 1U;
                }
            }
        }
    } else {
        vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__full_reg = 1U;
    }
    if (vlTOPp->RST_N) {
        if (vlTOPp->mkcheck__DOT__router2__DOT__input_link_CLR) {
            vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__full_reg = 1U;
        } else {
            if (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__input_link_ENQ) 
                 & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__input_link_DEQ)))) {
                vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__full_reg 
                    = (1U & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__empty_reg)));
            } else {
                if (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__input_link_DEQ) 
                     & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__input_link_ENQ)))) {
                    vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__full_reg = 1U;
                }
            }
        }
    } else {
        vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__full_reg = 1U;
    }
    vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__D_OUT 
        = vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__data0_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__D_OUT 
        = vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__data0_reg;
    if (vlTOPp->RST_N) {
        if (vlTOPp->mkcheck__DOT__router1__DOT__input_link_CLR) {
            vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__full_reg = 1U;
        } else {
            if (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__input_link_ENQ) 
                 & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__input_link_DEQ)))) {
                vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__full_reg 
                    = (1U & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__empty_reg)));
            } else {
                if (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__input_link_DEQ) 
                     & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__input_link_ENQ)))) {
                    vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__full_reg = 1U;
                }
            }
        }
    } else {
        vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__full_reg = 1U;
    }
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_D_OUT 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__D_OUT;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_D_OUT 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__D_OUT;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_D_OUT 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__D_OUT;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_D_OUT 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__D_OUT;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_D_OUT 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__D_OUT;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_D_OUT 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__D_OUT;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_D_OUT 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__D_OUT;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_D_OUT 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__D_OUT;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_D_OUT 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__D_OUT;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_D_OUT 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__D_OUT;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_D_OUT 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__D_OUT;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_D_OUT 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__D_OUT;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__empty_reg 
        = __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__empty_reg 
        = __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__empty_reg 
        = __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__empty_reg 
        = __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__empty_reg 
        = __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__empty_reg 
        = __Vdly__mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__empty_reg 
        = __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__empty_reg 
        = __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__empty_reg 
        = __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__empty_reg 
        = __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__empty_reg 
        = __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__empty_reg 
        = __Vdly__mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__empty_reg 
        = __Vdly__mkcheck__DOT__router2__DOT__input_link__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__input_link_D_OUT 
        = vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__D_OUT;
    vlTOPp->mkcheck__DOT__router1__DOT__input_link_D_OUT 
        = vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__D_OUT;
    vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__empty_reg 
        = __Vdly__mkcheck__DOT__router1__DOT__input_link__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__get_valueVC6 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_D_OUT;
    vlTOPp->mkcheck__DOT__router2__DOT__get_valueVC5 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_D_OUT;
    vlTOPp->mkcheck__DOT__router2__DOT__get_valueVC4 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_D_OUT;
    vlTOPp->mkcheck__DOT__router2__DOT__get_valueVC3 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_D_OUT;
    vlTOPp->mkcheck__DOT__router2__DOT__get_valueVC2 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_D_OUT;
    vlTOPp->mkcheck__DOT__router2__DOT__get_valueVC1 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_D_OUT;
    vlTOPp->mkcheck__DOT__router1__DOT__get_valueVC6 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_D_OUT;
    vlTOPp->mkcheck__DOT__router1__DOT__get_valueVC5 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_D_OUT;
    vlTOPp->mkcheck__DOT__router1__DOT__get_valueVC4 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_D_OUT;
    vlTOPp->mkcheck__DOT__router1__DOT__get_valueVC3 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_D_OUT;
    vlTOPp->mkcheck__DOT__router1__DOT__get_valueVC2 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_D_OUT;
    vlTOPp->mkcheck__DOT__router1__DOT__get_valueVC1 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_D_OUT;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__d0d1 
        = ((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_DEQ) 
           & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__full_reg)));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__FULL_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__full_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__EMPTY_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__d0d1 
        = ((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_DEQ) 
           & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__full_reg)));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__FULL_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__full_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__EMPTY_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__d0d1 
        = ((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_DEQ) 
           & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__full_reg)));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__FULL_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__full_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__EMPTY_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__d0d1 
        = ((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_DEQ) 
           & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__full_reg)));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__FULL_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__full_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__EMPTY_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__d0d1 
        = ((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_DEQ) 
           & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__full_reg)));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__FULL_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__full_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__EMPTY_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__d0d1 
        = ((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_DEQ) 
           & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__full_reg)));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__FULL_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__full_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__EMPTY_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__FULL_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__full_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__EMPTY_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__FULL_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__full_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__EMPTY_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__FULL_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__full_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__EMPTY_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__FULL_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__full_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__EMPTY_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__FULL_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__full_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__EMPTY_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__FULL_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__full_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__EMPTY_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__FULL_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__full_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__d1di 
        = ((IData)(vlTOPp->mkcheck__DOT__router2__DOT__input_link_ENQ) 
           & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__empty_reg));
    vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__EMPTY_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_D_IN 
        = vlTOPp->mkcheck__DOT__router2__DOT__input_link_D_OUT;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_D_IN 
        = vlTOPp->mkcheck__DOT__router2__DOT__input_link_D_OUT;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_D_IN 
        = vlTOPp->mkcheck__DOT__router2__DOT__input_link_D_OUT;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_D_IN 
        = vlTOPp->mkcheck__DOT__router2__DOT__input_link_D_OUT;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_D_IN 
        = vlTOPp->mkcheck__DOT__router2__DOT__input_link_D_OUT;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_D_IN 
        = vlTOPp->mkcheck__DOT__router2__DOT__input_link_D_OUT;
    vlTOPp->mkcheck__DOT__router2__DOT__b___05Fh929 
        = (1U & (vlTOPp->mkcheck__DOT__router2__DOT__input_link_D_OUT 
                 >> 0x1fU));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_D_IN 
        = vlTOPp->mkcheck__DOT__router1__DOT__input_link_D_OUT;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_D_IN 
        = vlTOPp->mkcheck__DOT__router1__DOT__input_link_D_OUT;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_D_IN 
        = vlTOPp->mkcheck__DOT__router1__DOT__input_link_D_OUT;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_D_IN 
        = vlTOPp->mkcheck__DOT__router1__DOT__input_link_D_OUT;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_D_IN 
        = vlTOPp->mkcheck__DOT__router1__DOT__input_link_D_OUT;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_D_IN 
        = vlTOPp->mkcheck__DOT__router1__DOT__input_link_D_OUT;
    vlTOPp->mkcheck__DOT__router1__DOT__b___05Fh929 
        = (1U & (vlTOPp->mkcheck__DOT__router1__DOT__input_link_D_OUT 
                 >> 0x1fU));
    vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__FULL_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__full_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__EMPTY_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router1_get_valueVC6 = vlTOPp->mkcheck__DOT__router1__DOT__get_valueVC6;
    vlTOPp->mkcheck__DOT__router1_get_valueVC5 = vlTOPp->mkcheck__DOT__router1__DOT__get_valueVC5;
    vlTOPp->mkcheck__DOT__router1_get_valueVC4 = vlTOPp->mkcheck__DOT__router1__DOT__get_valueVC4;
    vlTOPp->mkcheck__DOT__router1_get_valueVC3 = vlTOPp->mkcheck__DOT__router1__DOT__get_valueVC3;
    vlTOPp->mkcheck__DOT__router1_get_valueVC2 = vlTOPp->mkcheck__DOT__router1__DOT__get_valueVC2;
    vlTOPp->mkcheck__DOT__router1_get_valueVC1 = vlTOPp->mkcheck__DOT__router1__DOT__get_valueVC1;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_FULL_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__FULL_N;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_EMPTY_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_FULL_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__FULL_N;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_EMPTY_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_FULL_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__FULL_N;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_EMPTY_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_FULL_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__FULL_N;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_EMPTY_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_FULL_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__FULL_N;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_EMPTY_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_FULL_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__FULL_N;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_EMPTY_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__EMPTY_N;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_FULL_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__FULL_N;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_EMPTY_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__EMPTY_N;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_FULL_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__FULL_N;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_EMPTY_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__EMPTY_N;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_FULL_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__FULL_N;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_EMPTY_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__EMPTY_N;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_FULL_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__FULL_N;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_EMPTY_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__EMPTY_N;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_FULL_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__FULL_N;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_EMPTY_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__EMPTY_N;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_FULL_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__FULL_N;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_EMPTY_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__input_link_FULL_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__FULL_N;
    vlTOPp->mkcheck__DOT__router2__DOT__input_link_EMPTY_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__D_IN 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_D_IN;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__D_IN 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_D_IN;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__D_IN 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_D_IN;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__D_IN 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_D_IN;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__D_IN 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_D_IN;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__D_IN 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_D_IN;
    vlTOPp->mkcheck__DOT__router2__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_SLT_my_ETC___05F_d17 
        = ((0x80000000U ^ vlTOPp->mkcheck__DOT__router2__DOT__b___05Fh929) 
           < (0x80000000U ^ vlTOPp->mkcheck__DOT__router2__DOT__my_id));
    vlTOPp->mkcheck__DOT__router2__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_EQ_my___05FETC___05F_d15 
        = (vlTOPp->mkcheck__DOT__router2__DOT__b___05Fh929 
           == vlTOPp->mkcheck__DOT__router2__DOT__my_id);
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__D_IN 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_D_IN;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__D_IN 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_D_IN;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__D_IN 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_D_IN;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__D_IN 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_D_IN;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__D_IN 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_D_IN;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__D_IN 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_D_IN;
    vlTOPp->mkcheck__DOT__router1__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_SLT_my_ETC___05F_d17 
        = ((0x80000000U ^ vlTOPp->mkcheck__DOT__router1__DOT__b___05Fh929) 
           < (0x80000000U ^ vlTOPp->mkcheck__DOT__router1__DOT__my_id));
    vlTOPp->mkcheck__DOT__router1__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_EQ_my___05FETC___05F_d15 
        = (vlTOPp->mkcheck__DOT__router1__DOT__b___05Fh929 
           == vlTOPp->mkcheck__DOT__router1__DOT__my_id);
    vlTOPp->mkcheck__DOT__router1__DOT__input_link_FULL_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__FULL_N;
    vlTOPp->mkcheck__DOT__router1__DOT__input_link_EMPTY_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__RDY_get_valueVC2 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__CAN_FIRE_get_valueVC2 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__RDY_get_valueVC1 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__CAN_FIRE_get_valueVC1 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__RDY_get_valueVC6 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__CAN_FIRE_get_valueVC6 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__RDY_get_valueVC5 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__CAN_FIRE_get_valueVC5 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__RDY_get_valueVC4 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__CAN_FIRE_get_valueVC4 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__RDY_get_valueVC3 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__CAN_FIRE_get_valueVC3 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_EMPTY_N;
    vlTOPp->mkcheck__DOT__router1__DOT__CAN_FIRE_get_valueVC2 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_EMPTY_N;
    vlTOPp->mkcheck__DOT__router1__DOT__RDY_get_valueVC2 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_EMPTY_N;
    vlTOPp->mkcheck__DOT__router1__DOT__CAN_FIRE_get_valueVC1 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_EMPTY_N;
    vlTOPp->mkcheck__DOT__router1__DOT__RDY_get_valueVC1 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_EMPTY_N;
    vlTOPp->mkcheck__DOT__router1__DOT__CAN_FIRE_get_valueVC6 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_EMPTY_N;
    vlTOPp->mkcheck__DOT__router1__DOT__RDY_get_valueVC6 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_EMPTY_N;
    vlTOPp->mkcheck__DOT__router1__DOT__CAN_FIRE_get_valueVC5 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_EMPTY_N;
    vlTOPp->mkcheck__DOT__router1__DOT__RDY_get_valueVC5 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_EMPTY_N;
    vlTOPp->mkcheck__DOT__router1__DOT__CAN_FIRE_get_valueVC4 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_EMPTY_N;
    vlTOPp->mkcheck__DOT__router1__DOT__RDY_get_valueVC4 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_EMPTY_N;
    vlTOPp->mkcheck__DOT__router1__DOT__CAN_FIRE_get_valueVC3 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_EMPTY_N;
    vlTOPp->mkcheck__DOT__router1__DOT__RDY_get_valueVC3 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__RDY_put_value 
        = vlTOPp->mkcheck__DOT__router2__DOT__input_link_FULL_N;
    vlTOPp->mkcheck__DOT__router2__DOT__CAN_FIRE_put_value 
        = vlTOPp->mkcheck__DOT__router2__DOT__input_link_FULL_N;
    vlTOPp->mkcheck__DOT__router2__DOT__CAN_FIRE_RL_read_input_link_and_send_to_VC_odd 
        = (((((IData)(vlTOPp->mkcheck__DOT__router2__DOT__input_link_EMPTY_N) 
              & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_FULL_N)) 
             & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_FULL_N)) 
            & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_FULL_N)) 
           & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__cycle));
    vlTOPp->mkcheck__DOT__router2__DOT__CAN_FIRE_RL_read_input_link_and_send_to_VC_even 
        = (((((IData)(vlTOPp->mkcheck__DOT__router2__DOT__input_link_EMPTY_N) 
              & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_FULL_N)) 
             & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_FULL_N)) 
            & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_FULL_N)) 
           & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__cycle)));
    vlTOPp->mkcheck__DOT__router1__DOT__CAN_FIRE_put_value 
        = vlTOPp->mkcheck__DOT__router1__DOT__input_link_FULL_N;
    vlTOPp->mkcheck__DOT__router1__DOT__RDY_put_value 
        = vlTOPp->mkcheck__DOT__router1__DOT__input_link_FULL_N;
    vlTOPp->mkcheck__DOT__router1__DOT__CAN_FIRE_RL_read_input_link_and_send_to_VC_odd 
        = (((((IData)(vlTOPp->mkcheck__DOT__router1__DOT__input_link_EMPTY_N) 
              & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_FULL_N)) 
             & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_FULL_N)) 
            & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_FULL_N)) 
           & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__cycle));
    vlTOPp->mkcheck__DOT__router1__DOT__CAN_FIRE_RL_read_input_link_and_send_to_VC_even 
        = (((((IData)(vlTOPp->mkcheck__DOT__router1__DOT__input_link_EMPTY_N) 
              & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_FULL_N)) 
             & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_FULL_N)) 
            & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_FULL_N)) 
           & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__cycle)));
    vlTOPp->mkcheck__DOT__router1_RDY_get_valueVC2 
        = vlTOPp->mkcheck__DOT__router1__DOT__RDY_get_valueVC2;
    vlTOPp->mkcheck__DOT__router1_RDY_get_valueVC1 
        = vlTOPp->mkcheck__DOT__router1__DOT__RDY_get_valueVC1;
    vlTOPp->mkcheck__DOT__router1_RDY_get_valueVC6 
        = vlTOPp->mkcheck__DOT__router1__DOT__RDY_get_valueVC6;
    vlTOPp->mkcheck__DOT__router1_RDY_get_valueVC5 
        = vlTOPp->mkcheck__DOT__router1__DOT__RDY_get_valueVC5;
    vlTOPp->mkcheck__DOT__router1_RDY_get_valueVC4 
        = vlTOPp->mkcheck__DOT__router1__DOT__RDY_get_valueVC4;
    vlTOPp->mkcheck__DOT__router1_RDY_get_valueVC3 
        = vlTOPp->mkcheck__DOT__router1__DOT__RDY_get_valueVC3;
    vlTOPp->mkcheck__DOT__router2__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_odd 
        = vlTOPp->mkcheck__DOT__router2__DOT__CAN_FIRE_RL_read_input_link_and_send_to_VC_odd;
    vlTOPp->mkcheck__DOT__router2__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_even 
        = vlTOPp->mkcheck__DOT__router2__DOT__CAN_FIRE_RL_read_input_link_and_send_to_VC_even;
    vlTOPp->mkcheck__DOT__router1_RDY_put_value = vlTOPp->mkcheck__DOT__router1__DOT__RDY_put_value;
    vlTOPp->mkcheck__DOT__router1__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_odd 
        = vlTOPp->mkcheck__DOT__router1__DOT__CAN_FIRE_RL_read_input_link_and_send_to_VC_odd;
    vlTOPp->mkcheck__DOT__router1__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_even 
        = vlTOPp->mkcheck__DOT__router1__DOT__CAN_FIRE_RL_read_input_link_and_send_to_VC_even;
    vlTOPp->mkcheck__DOT__CAN_FIRE_RL_two_cycle2 = 
        ((IData)(vlTOPp->mkcheck__DOT__router1_RDY_get_valueVC2) 
         & (IData)(vlTOPp->mkcheck__DOT__NOT_counter_SLT_2___05F_d10));
    vlTOPp->mkcheck__DOT__CAN_FIRE_RL_two_cycle1 = 
        ((IData)(vlTOPp->mkcheck__DOT__router1_RDY_get_valueVC1) 
         & (IData)(vlTOPp->mkcheck__DOT__NOT_counter_SLT_2___05F_d10));
    vlTOPp->mkcheck__DOT__CAN_FIRE_RL_two_cycle6 = 
        ((IData)(vlTOPp->mkcheck__DOT__router1_RDY_get_valueVC6) 
         & (IData)(vlTOPp->mkcheck__DOT__NOT_counter_SLT_2___05F_d10));
    vlTOPp->mkcheck__DOT__CAN_FIRE_RL_two_cycle5 = 
        ((IData)(vlTOPp->mkcheck__DOT__router1_RDY_get_valueVC5) 
         & (IData)(vlTOPp->mkcheck__DOT__NOT_counter_SLT_2___05F_d10));
    vlTOPp->mkcheck__DOT__CAN_FIRE_RL_two_cycle4 = 
        ((IData)(vlTOPp->mkcheck__DOT__router1_RDY_get_valueVC4) 
         & (IData)(vlTOPp->mkcheck__DOT__NOT_counter_SLT_2___05F_d10));
    vlTOPp->mkcheck__DOT__CAN_FIRE_RL_two_cycle3 = 
        ((IData)(vlTOPp->mkcheck__DOT__router1_RDY_get_valueVC3) 
         & (IData)(vlTOPp->mkcheck__DOT__NOT_counter_SLT_2___05F_d10));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_ENQ 
        = ((IData)(vlTOPp->mkcheck__DOT__router2__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_odd) 
           & (IData)(vlTOPp->mkcheck__DOT__router2__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_EQ_my___05FETC___05F_d15));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_ENQ 
        = (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_odd) 
            & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_EQ_my___05FETC___05F_d15))) 
           & (IData)(vlTOPp->mkcheck__DOT__router2__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_SLT_my_ETC___05F_d17));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_ENQ 
        = (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_odd) 
            & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_EQ_my___05FETC___05F_d15))) 
           & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_SLT_my_ETC___05F_d17)));
    vlTOPp->mkcheck__DOT__router2__DOT__input_link_DEQ 
        = ((IData)(vlTOPp->mkcheck__DOT__router2__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_even) 
           | (IData)(vlTOPp->mkcheck__DOT__router2__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_odd));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_ENQ 
        = ((IData)(vlTOPp->mkcheck__DOT__router2__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_even) 
           & (IData)(vlTOPp->mkcheck__DOT__router2__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_EQ_my___05FETC___05F_d15));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_ENQ 
        = (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_even) 
            & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_EQ_my___05FETC___05F_d15))) 
           & (IData)(vlTOPp->mkcheck__DOT__router2__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_SLT_my_ETC___05F_d17));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_ENQ 
        = (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_even) 
            & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_EQ_my___05FETC___05F_d15))) 
           & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_SLT_my_ETC___05F_d17)));
    vlTOPp->mkcheck__DOT__CAN_FIRE_RL_check1_update1 
        = ((IData)(vlTOPp->mkcheck__DOT__router1_RDY_put_value) 
           & (0U == vlTOPp->mkcheck__DOT__counter));
    vlTOPp->mkcheck__DOT__CAN_FIRE_RL_check1_update2 
        = ((IData)(vlTOPp->mkcheck__DOT__router1_RDY_put_value) 
           & (1U == vlTOPp->mkcheck__DOT__counter));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_ENQ 
        = ((IData)(vlTOPp->mkcheck__DOT__router1__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_odd) 
           & (IData)(vlTOPp->mkcheck__DOT__router1__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_EQ_my___05FETC___05F_d15));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_ENQ 
        = (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_odd) 
            & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_EQ_my___05FETC___05F_d15))) 
           & (IData)(vlTOPp->mkcheck__DOT__router1__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_SLT_my_ETC___05F_d17));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_ENQ 
        = (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_odd) 
            & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_EQ_my___05FETC___05F_d15))) 
           & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_SLT_my_ETC___05F_d17)));
    vlTOPp->mkcheck__DOT__router1__DOT__input_link_DEQ 
        = ((IData)(vlTOPp->mkcheck__DOT__router1__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_even) 
           | (IData)(vlTOPp->mkcheck__DOT__router1__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_odd));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_ENQ 
        = ((IData)(vlTOPp->mkcheck__DOT__router1__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_even) 
           & (IData)(vlTOPp->mkcheck__DOT__router1__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_EQ_my___05FETC___05F_d15));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_ENQ 
        = (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_even) 
            & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_EQ_my___05FETC___05F_d15))) 
           & (IData)(vlTOPp->mkcheck__DOT__router1__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_SLT_my_ETC___05F_d17));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_ENQ 
        = (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_even) 
            & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_EQ_my___05FETC___05F_d15))) 
           & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_SLT_my_ETC___05F_d17)));
    vlTOPp->mkcheck__DOT__WILL_FIRE_RL_two_cycle2 = vlTOPp->mkcheck__DOT__CAN_FIRE_RL_two_cycle2;
    vlTOPp->mkcheck__DOT__router1_EN_get_valueVC2 = vlTOPp->mkcheck__DOT__CAN_FIRE_RL_two_cycle2;
    vlTOPp->mkcheck__DOT__WILL_FIRE_RL_two_cycle1 = vlTOPp->mkcheck__DOT__CAN_FIRE_RL_two_cycle1;
    vlTOPp->mkcheck__DOT__router1_EN_get_valueVC1 = vlTOPp->mkcheck__DOT__CAN_FIRE_RL_two_cycle1;
    vlTOPp->mkcheck__DOT__WILL_FIRE_RL_two_cycle6 = vlTOPp->mkcheck__DOT__CAN_FIRE_RL_two_cycle6;
    vlTOPp->mkcheck__DOT__router1_EN_get_valueVC6 = vlTOPp->mkcheck__DOT__CAN_FIRE_RL_two_cycle6;
    vlTOPp->mkcheck__DOT__WILL_FIRE_RL_two_cycle5 = vlTOPp->mkcheck__DOT__CAN_FIRE_RL_two_cycle5;
    vlTOPp->mkcheck__DOT__router1_EN_get_valueVC5 = vlTOPp->mkcheck__DOT__CAN_FIRE_RL_two_cycle5;
    vlTOPp->mkcheck__DOT__WILL_FIRE_RL_two_cycle4 = vlTOPp->mkcheck__DOT__CAN_FIRE_RL_two_cycle4;
    vlTOPp->mkcheck__DOT__router1_EN_get_valueVC4 = vlTOPp->mkcheck__DOT__CAN_FIRE_RL_two_cycle4;
    vlTOPp->mkcheck__DOT__WILL_FIRE_RL_two_cycle3 = vlTOPp->mkcheck__DOT__CAN_FIRE_RL_two_cycle3;
    vlTOPp->mkcheck__DOT__router1_EN_get_valueVC3 = vlTOPp->mkcheck__DOT__CAN_FIRE_RL_two_cycle3;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__ENQ 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_ENQ;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__d1di 
        = ((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_ENQ) 
           & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__empty_reg));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__d0di 
        = (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_ENQ) 
            & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__empty_reg))) 
           | (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_ENQ) 
               & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_DEQ)) 
              & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__full_reg)));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__d0h 
        = (1U & ((((~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_DEQ)) 
                   & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_ENQ))) 
                  | ((~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_DEQ)) 
                     & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__empty_reg))) 
                 | ((~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_ENQ)) 
                    & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__full_reg))));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__ENQ 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_ENQ;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__d1di 
        = ((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_ENQ) 
           & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__empty_reg));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__d0di 
        = (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_ENQ) 
            & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__empty_reg))) 
           | (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_ENQ) 
               & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_DEQ)) 
              & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__full_reg)));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__d0h 
        = (1U & ((((~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_DEQ)) 
                   & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_ENQ))) 
                  | ((~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_DEQ)) 
                     & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__empty_reg))) 
                 | ((~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_ENQ)) 
                    & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__full_reg))));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__ENQ 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_ENQ;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__d1di 
        = ((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_ENQ) 
           & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__empty_reg));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__d0di 
        = (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_ENQ) 
            & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__empty_reg))) 
           | (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_ENQ) 
               & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_DEQ)) 
              & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__full_reg)));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__d0h 
        = (1U & ((((~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_DEQ)) 
                   & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_ENQ))) 
                  | ((~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_DEQ)) 
                     & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__empty_reg))) 
                 | ((~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_ENQ)) 
                    & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__full_reg))));
    vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__DEQ 
        = vlTOPp->mkcheck__DOT__router2__DOT__input_link_DEQ;
    vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__d0d1 
        = ((IData)(vlTOPp->mkcheck__DOT__router2__DOT__input_link_DEQ) 
           & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__full_reg)));
    vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__d0di 
        = (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__input_link_ENQ) 
            & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__empty_reg))) 
           | (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__input_link_ENQ) 
               & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__input_link_DEQ)) 
              & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__full_reg)));
    vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__d0h 
        = (1U & ((((~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__input_link_DEQ)) 
                   & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__input_link_ENQ))) 
                  | ((~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__input_link_DEQ)) 
                     & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__empty_reg))) 
                 | ((~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__input_link_ENQ)) 
                    & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__full_reg))));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__ENQ 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_ENQ;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__d1di 
        = ((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_ENQ) 
           & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__empty_reg));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__d0di 
        = (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_ENQ) 
            & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__empty_reg))) 
           | (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_ENQ) 
               & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_DEQ)) 
              & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__full_reg)));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__d0h 
        = (1U & ((((~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_DEQ)) 
                   & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_ENQ))) 
                  | ((~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_DEQ)) 
                     & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__empty_reg))) 
                 | ((~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_ENQ)) 
                    & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__full_reg))));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__ENQ 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_ENQ;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__d1di 
        = ((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_ENQ) 
           & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__empty_reg));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__d0di 
        = (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_ENQ) 
            & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__empty_reg))) 
           | (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_ENQ) 
               & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_DEQ)) 
              & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__full_reg)));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__d0h 
        = (1U & ((((~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_DEQ)) 
                   & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_ENQ))) 
                  | ((~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_DEQ)) 
                     & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__empty_reg))) 
                 | ((~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_ENQ)) 
                    & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__full_reg))));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__ENQ 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_ENQ;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__d1di 
        = ((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_ENQ) 
           & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__empty_reg));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__d0di 
        = (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_ENQ) 
            & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__empty_reg))) 
           | (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_ENQ) 
               & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_DEQ)) 
              & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__full_reg)));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__d0h 
        = (1U & ((((~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_DEQ)) 
                   & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_ENQ))) 
                  | ((~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_DEQ)) 
                     & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__empty_reg))) 
                 | ((~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_ENQ)) 
                    & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__full_reg))));
    vlTOPp->mkcheck__DOT__WILL_FIRE_RL_check1_update1 
        = vlTOPp->mkcheck__DOT__CAN_FIRE_RL_check1_update1;
    vlTOPp->mkcheck__DOT__WILL_FIRE_RL_check1_update2 
        = vlTOPp->mkcheck__DOT__CAN_FIRE_RL_check1_update2;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__ENQ 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_ENQ;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__d1di 
        = ((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_ENQ) 
           & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__empty_reg));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__ENQ 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_ENQ;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__d1di 
        = ((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_ENQ) 
           & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__empty_reg));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__ENQ 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_ENQ;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__d1di 
        = ((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_ENQ) 
           & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__empty_reg));
    vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__DEQ 
        = vlTOPp->mkcheck__DOT__router1__DOT__input_link_DEQ;
    vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__d0d1 
        = ((IData)(vlTOPp->mkcheck__DOT__router1__DOT__input_link_DEQ) 
           & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__full_reg)));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__ENQ 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_ENQ;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__d1di 
        = ((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_ENQ) 
           & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__empty_reg));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__ENQ 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_ENQ;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__d1di 
        = ((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_ENQ) 
           & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__empty_reg));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__ENQ 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_ENQ;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__d1di 
        = ((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_ENQ) 
           & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__empty_reg));
    vlTOPp->mkcheck__DOT__router1__DOT__EN_get_valueVC2 
        = vlTOPp->mkcheck__DOT__router1_EN_get_valueVC2;
    vlTOPp->mkcheck__DOT__router1__DOT__WILL_FIRE_get_valueVC2 
        = vlTOPp->mkcheck__DOT__router1_EN_get_valueVC2;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_DEQ 
        = vlTOPp->mkcheck__DOT__router1_EN_get_valueVC2;
    vlTOPp->mkcheck__DOT__router1__DOT__EN_get_valueVC1 
        = vlTOPp->mkcheck__DOT__router1_EN_get_valueVC1;
    vlTOPp->mkcheck__DOT__router1__DOT__WILL_FIRE_get_valueVC1 
        = vlTOPp->mkcheck__DOT__router1_EN_get_valueVC1;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_DEQ 
        = vlTOPp->mkcheck__DOT__router1_EN_get_valueVC1;
    vlTOPp->mkcheck__DOT__router1__DOT__EN_get_valueVC6 
        = vlTOPp->mkcheck__DOT__router1_EN_get_valueVC6;
    vlTOPp->mkcheck__DOT__router1__DOT__WILL_FIRE_get_valueVC6 
        = vlTOPp->mkcheck__DOT__router1_EN_get_valueVC6;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_DEQ 
        = vlTOPp->mkcheck__DOT__router1_EN_get_valueVC6;
    vlTOPp->mkcheck__DOT__router1__DOT__EN_get_valueVC5 
        = vlTOPp->mkcheck__DOT__router1_EN_get_valueVC5;
    vlTOPp->mkcheck__DOT__router1__DOT__WILL_FIRE_get_valueVC5 
        = vlTOPp->mkcheck__DOT__router1_EN_get_valueVC5;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_DEQ 
        = vlTOPp->mkcheck__DOT__router1_EN_get_valueVC5;
    vlTOPp->mkcheck__DOT__router1__DOT__EN_get_valueVC4 
        = vlTOPp->mkcheck__DOT__router1_EN_get_valueVC4;
    vlTOPp->mkcheck__DOT__router1__DOT__WILL_FIRE_get_valueVC4 
        = vlTOPp->mkcheck__DOT__router1_EN_get_valueVC4;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_DEQ 
        = vlTOPp->mkcheck__DOT__router1_EN_get_valueVC4;
    vlTOPp->mkcheck__DOT__router1__DOT__EN_get_valueVC3 
        = vlTOPp->mkcheck__DOT__router1_EN_get_valueVC3;
    vlTOPp->mkcheck__DOT__router1__DOT__WILL_FIRE_get_valueVC3 
        = vlTOPp->mkcheck__DOT__router1_EN_get_valueVC3;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_DEQ 
        = vlTOPp->mkcheck__DOT__router1_EN_get_valueVC3;
    vlTOPp->mkcheck__DOT__router1_put_value_flit = 
        ((IData)(vlTOPp->mkcheck__DOT__WILL_FIRE_RL_check1_update2)
          ? 0x80000000U : 0xffffffffU);
    vlTOPp->mkcheck__DOT__router1_EN_put_value = ((IData)(vlTOPp->mkcheck__DOT__WILL_FIRE_RL_check1_update2) 
                                                  | (IData)(vlTOPp->mkcheck__DOT__WILL_FIRE_RL_check1_update1));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__DEQ 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_DEQ;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__d0d1 
        = ((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_DEQ) 
           & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__full_reg)));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__d0di 
        = (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_ENQ) 
            & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__empty_reg))) 
           | (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_ENQ) 
               & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_DEQ)) 
              & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__full_reg)));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__d0h 
        = (1U & ((((~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_DEQ)) 
                   & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_ENQ))) 
                  | ((~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_DEQ)) 
                     & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__empty_reg))) 
                 | ((~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_ENQ)) 
                    & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__full_reg))));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__DEQ 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_DEQ;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__d0d1 
        = ((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_DEQ) 
           & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__full_reg)));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__d0di 
        = (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_ENQ) 
            & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__empty_reg))) 
           | (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_ENQ) 
               & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_DEQ)) 
              & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__full_reg)));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__d0h 
        = (1U & ((((~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_DEQ)) 
                   & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_ENQ))) 
                  | ((~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_DEQ)) 
                     & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__empty_reg))) 
                 | ((~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_ENQ)) 
                    & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__full_reg))));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__DEQ 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_DEQ;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__d0d1 
        = ((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_DEQ) 
           & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__full_reg)));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__d0di 
        = (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_ENQ) 
            & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__empty_reg))) 
           | (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_ENQ) 
               & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_DEQ)) 
              & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__full_reg)));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__d0h 
        = (1U & ((((~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_DEQ)) 
                   & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_ENQ))) 
                  | ((~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_DEQ)) 
                     & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__empty_reg))) 
                 | ((~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_ENQ)) 
                    & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__full_reg))));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__DEQ 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_DEQ;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__d0d1 
        = ((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_DEQ) 
           & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__full_reg)));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__d0di 
        = (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_ENQ) 
            & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__empty_reg))) 
           | (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_ENQ) 
               & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_DEQ)) 
              & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__full_reg)));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__d0h 
        = (1U & ((((~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_DEQ)) 
                   & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_ENQ))) 
                  | ((~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_DEQ)) 
                     & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__empty_reg))) 
                 | ((~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_ENQ)) 
                    & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__full_reg))));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__DEQ 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_DEQ;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__d0d1 
        = ((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_DEQ) 
           & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__full_reg)));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__d0di 
        = (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_ENQ) 
            & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__empty_reg))) 
           | (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_ENQ) 
               & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_DEQ)) 
              & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__full_reg)));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__d0h 
        = (1U & ((((~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_DEQ)) 
                   & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_ENQ))) 
                  | ((~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_DEQ)) 
                     & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__empty_reg))) 
                 | ((~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_ENQ)) 
                    & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__full_reg))));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__DEQ 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_DEQ;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__d0d1 
        = ((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_DEQ) 
           & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__full_reg)));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__d0di 
        = (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_ENQ) 
            & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__empty_reg))) 
           | (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_ENQ) 
               & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_DEQ)) 
              & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__full_reg)));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__d0h 
        = (1U & ((((~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_DEQ)) 
                   & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_ENQ))) 
                  | ((~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_DEQ)) 
                     & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__empty_reg))) 
                 | ((~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_ENQ)) 
                    & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__full_reg))));
    vlTOPp->mkcheck__DOT__router1__DOT__put_value_flit 
        = vlTOPp->mkcheck__DOT__router1_put_value_flit;
    vlTOPp->mkcheck__DOT__router1__DOT__input_link_D_IN 
        = vlTOPp->mkcheck__DOT__router1_put_value_flit;
    vlTOPp->mkcheck__DOT__router1__DOT__EN_put_value 
        = vlTOPp->mkcheck__DOT__router1_EN_put_value;
    vlTOPp->mkcheck__DOT__router1__DOT__WILL_FIRE_put_value 
        = vlTOPp->mkcheck__DOT__router1_EN_put_value;
    vlTOPp->mkcheck__DOT__router1__DOT__input_link_ENQ 
        = vlTOPp->mkcheck__DOT__router1_EN_put_value;
    vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__D_IN 
        = vlTOPp->mkcheck__DOT__router1__DOT__input_link_D_IN;
    vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__ENQ 
        = vlTOPp->mkcheck__DOT__router1__DOT__input_link_ENQ;
    vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__d1di 
        = ((IData)(vlTOPp->mkcheck__DOT__router1__DOT__input_link_ENQ) 
           & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__empty_reg));
    vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__d0di 
        = (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__input_link_ENQ) 
            & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__empty_reg))) 
           | (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__input_link_ENQ) 
               & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__input_link_DEQ)) 
              & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__full_reg)));
    vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__d0h 
        = (1U & ((((~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__input_link_DEQ)) 
                   & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__input_link_ENQ))) 
                  | ((~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__input_link_DEQ)) 
                     & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__empty_reg))) 
                 | ((~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__input_link_ENQ)) 
                    & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__full_reg))));
}

VL_INLINE_OPT void Vtop::_combo__TOP__3(Vtop__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop::_combo__TOP__3\n"); );
    Vtop* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->mkcheck__DOT__CLK = vlTOPp->CLK;
    vlTOPp->mkcheck__DOT__RST_N = vlTOPp->RST_N;
    vlTOPp->mkcheck__DOT__router1__DOT__CLK = vlTOPp->mkcheck__DOT__CLK;
    vlTOPp->mkcheck__DOT__router2__DOT__CLK = vlTOPp->mkcheck__DOT__CLK;
    vlTOPp->mkcheck__DOT__router1__DOT__RST_N = vlTOPp->mkcheck__DOT__RST_N;
    vlTOPp->mkcheck__DOT__router2__DOT__RST_N = vlTOPp->mkcheck__DOT__RST_N;
    vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__CLK 
        = vlTOPp->mkcheck__DOT__router1__DOT__CLK;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__CLK 
        = vlTOPp->mkcheck__DOT__router1__DOT__CLK;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__CLK 
        = vlTOPp->mkcheck__DOT__router1__DOT__CLK;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__CLK 
        = vlTOPp->mkcheck__DOT__router1__DOT__CLK;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__CLK 
        = vlTOPp->mkcheck__DOT__router1__DOT__CLK;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__CLK 
        = vlTOPp->mkcheck__DOT__router1__DOT__CLK;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__CLK 
        = vlTOPp->mkcheck__DOT__router1__DOT__CLK;
    vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__CLK 
        = vlTOPp->mkcheck__DOT__router2__DOT__CLK;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__CLK 
        = vlTOPp->mkcheck__DOT__router2__DOT__CLK;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__CLK 
        = vlTOPp->mkcheck__DOT__router2__DOT__CLK;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__CLK 
        = vlTOPp->mkcheck__DOT__router2__DOT__CLK;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__CLK 
        = vlTOPp->mkcheck__DOT__router2__DOT__CLK;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__CLK 
        = vlTOPp->mkcheck__DOT__router2__DOT__CLK;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__CLK 
        = vlTOPp->mkcheck__DOT__router2__DOT__CLK;
    vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__RST 
        = vlTOPp->mkcheck__DOT__router1__DOT__RST_N;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__RST 
        = vlTOPp->mkcheck__DOT__router1__DOT__RST_N;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__RST 
        = vlTOPp->mkcheck__DOT__router1__DOT__RST_N;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__RST 
        = vlTOPp->mkcheck__DOT__router1__DOT__RST_N;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__RST 
        = vlTOPp->mkcheck__DOT__router1__DOT__RST_N;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__RST 
        = vlTOPp->mkcheck__DOT__router1__DOT__RST_N;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__RST 
        = vlTOPp->mkcheck__DOT__router1__DOT__RST_N;
    vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__RST 
        = vlTOPp->mkcheck__DOT__router2__DOT__RST_N;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__RST 
        = vlTOPp->mkcheck__DOT__router2__DOT__RST_N;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__RST 
        = vlTOPp->mkcheck__DOT__router2__DOT__RST_N;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__RST 
        = vlTOPp->mkcheck__DOT__router2__DOT__RST_N;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__RST 
        = vlTOPp->mkcheck__DOT__router2__DOT__RST_N;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__RST 
        = vlTOPp->mkcheck__DOT__router2__DOT__RST_N;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__RST 
        = vlTOPp->mkcheck__DOT__router2__DOT__RST_N;
}

VL_INLINE_OPT void Vtop::_sequent__TOP__5(Vtop__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop::_sequent__TOP__5\n"); );
    Vtop* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    if (vlTOPp->RST_N) {
        if (VL_UNLIKELY(vlTOPp->mkcheck__DOT__WILL_FIRE_RL_check1_update1)) {
            VL_WRITEF("put at 0\n");
            Verilated::runFlushCallbacks();
        }
    }
    if (vlTOPp->RST_N) {
        if (VL_UNLIKELY(vlTOPp->mkcheck__DOT__WILL_FIRE_RL_check1_update2)) {
            VL_WRITEF("put at 1\n");
            Verilated::runFlushCallbacks();
        }
    }
    if (vlTOPp->RST_N) {
        if (VL_UNLIKELY(vlTOPp->mkcheck__DOT__WILL_FIRE_RL_two_cycle1)) {
            VL_WRITEF("counter==%11d, data=%x from VC1\n",
                      32,vlTOPp->mkcheck__DOT__counter,
                      32,vlTOPp->mkcheck__DOT__router1_get_valueVC1);
            Verilated::runFlushCallbacks();
        }
    }
    if (vlTOPp->RST_N) {
        if (VL_UNLIKELY(vlTOPp->mkcheck__DOT__WILL_FIRE_RL_two_cycle2)) {
            VL_WRITEF("counter==%11d, data=%x from VC2\n",
                      32,vlTOPp->mkcheck__DOT__counter,
                      32,vlTOPp->mkcheck__DOT__router1_get_valueVC2);
            Verilated::runFlushCallbacks();
        }
    }
    if (vlTOPp->RST_N) {
        if (VL_UNLIKELY(vlTOPp->mkcheck__DOT__WILL_FIRE_RL_two_cycle3)) {
            VL_WRITEF("counter==%11d, data=%x from VC3\n",
                      32,vlTOPp->mkcheck__DOT__counter,
                      32,vlTOPp->mkcheck__DOT__router1_get_valueVC3);
            Verilated::runFlushCallbacks();
        }
    }
    if (vlTOPp->RST_N) {
        if (VL_UNLIKELY(vlTOPp->mkcheck__DOT__WILL_FIRE_RL_two_cycle4)) {
            VL_WRITEF("counter==%11d, data=%x from VC4\n",
                      32,vlTOPp->mkcheck__DOT__counter,
                      32,vlTOPp->mkcheck__DOT__router1_get_valueVC4);
            Verilated::runFlushCallbacks();
        }
    }
    if (vlTOPp->RST_N) {
        if (VL_UNLIKELY(vlTOPp->mkcheck__DOT__WILL_FIRE_RL_two_cycle5)) {
            VL_WRITEF("counter==%11d, data=%x from VC5\n",
                      32,vlTOPp->mkcheck__DOT__counter,
                      32,vlTOPp->mkcheck__DOT__router1_get_valueVC5);
            Verilated::runFlushCallbacks();
        }
    }
    if (vlTOPp->RST_N) {
        if (VL_UNLIKELY(vlTOPp->mkcheck__DOT__WILL_FIRE_RL_two_cycle6)) {
            VL_WRITEF("counter==%11d, data=%x from VC6\n",
                      32,vlTOPp->mkcheck__DOT__counter,
                      32,vlTOPp->mkcheck__DOT__router1_get_valueVC6);
            Verilated::runFlushCallbacks();
        }
    }
}

void Vtop::_eval(Vtop__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop::_eval\n"); );
    Vtop* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    if (((IData)(vlTOPp->CLK) & (~ (IData)(vlTOPp->__Vclklast__TOP__CLK)))) {
        vlTOPp->_sequent__TOP__2(vlSymsp);
    }
    vlTOPp->_combo__TOP__3(vlSymsp);
    if (((~ (IData)(vlTOPp->CLK)) & (IData)(vlTOPp->__Vclklast__TOP__CLK))) {
        vlTOPp->_sequent__TOP__5(vlSymsp);
    }
    // Final
    vlTOPp->__Vclklast__TOP__CLK = vlTOPp->CLK;
}

VL_INLINE_OPT QData Vtop::_change_request(Vtop__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop::_change_request\n"); );
    Vtop* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    return (vlTOPp->_change_request_1(vlSymsp));
}

VL_INLINE_OPT QData Vtop::_change_request_1(Vtop__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop::_change_request_1\n"); );
    Vtop* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    // Change detection
    QData __req = false;  // Logically a bool
    return __req;
}

#ifdef VL_DEBUG
void Vtop::_eval_debug_assertions() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop::_eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((CLK & 0xfeU))) {
        Verilated::overWidthError("CLK");}
    if (VL_UNLIKELY((RST_N & 0xfeU))) {
        Verilated::overWidthError("RST_N");}
}
#endif  // VL_DEBUG
