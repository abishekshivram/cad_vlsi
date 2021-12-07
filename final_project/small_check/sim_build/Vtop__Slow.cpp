// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop.h for the primary calling header

#include "Vtop.h"
#include "Vtop__Syms.h"

#include "verilated_dpi.h"

//==========

VL_CTOR_IMP(Vtop) {
    Vtop__Syms* __restrict vlSymsp = __VlSymsp = new Vtop__Syms(this, name());
    Vtop* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Reset internal values
    
    // Reset structure values
    _ctor_var_reset();
}

void Vtop::__Vconfigure(Vtop__Syms* vlSymsp, bool first) {
    if (false && first) {}  // Prevent unused
    this->__VlSymsp = vlSymsp;
    if (false && this->__VlSymsp) {}  // Prevent unused
    Verilated::timeunit(-9);
    Verilated::timeprecision(-12);
}

Vtop::~Vtop() {
    VL_DO_CLEAR(delete __VlSymsp, __VlSymsp = nullptr);
}

void Vtop::_initial__TOP__1(Vtop__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop::_initial__TOP__1\n"); );
    Vtop* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->mkcheck__DOT__CAN_FIRE_RL_update_counter = 1U;
    vlTOPp->mkcheck__DOT__WILL_FIRE_RL_update_counter = 1U;
    vlTOPp->mkcheck__DOT__router1__DOT__CAN_FIRE_RL_invert_cycle = 1U;
    vlTOPp->mkcheck__DOT__router1__DOT__WILL_FIRE_RL_invert_cycle = 1U;
    vlTOPp->mkcheck__DOT__router2__DOT__CAN_FIRE_RL_invert_cycle = 1U;
    vlTOPp->mkcheck__DOT__router2__DOT__WILL_FIRE_RL_invert_cycle = 1U;
    vlTOPp->mkcheck__DOT__router2_put_value_flit = 0U;
    vlTOPp->mkcheck__DOT__router2_EN_put_value = 0U;
    vlTOPp->mkcheck__DOT__router2_EN_get_valueVC1 = 0U;
    vlTOPp->mkcheck__DOT__router2_EN_get_valueVC2 = 0U;
    vlTOPp->mkcheck__DOT__router2_EN_get_valueVC3 = 0U;
    vlTOPp->mkcheck__DOT__router2_EN_get_valueVC4 = 0U;
    vlTOPp->mkcheck__DOT__router2_EN_get_valueVC5 = 0U;
    vlTOPp->mkcheck__DOT__router2_EN_get_valueVC6 = 0U;
    vlTOPp->mkcheck__DOT__router1__DOT__cycle = 0U;
    vlTOPp->mkcheck__DOT__router1__DOT__my_id = 0xaaaaaaaaU;
    vlTOPp->mkcheck__DOT__router2__DOT__cycle = 0U;
    vlTOPp->mkcheck__DOT__router2__DOT__my_id = 0xaaaaaaaaU;
    vlTOPp->mkcheck__DOT__check1 = 0xaaaaaaaaU;
    vlTOPp->mkcheck__DOT__check2 = 0xaaaaaaaaU;
    vlTOPp->mkcheck__DOT__counter = 0xaaaaaaaaU;
    vlTOPp->mkcheck__DOT__check1_D_IN = 0U;
    vlTOPp->mkcheck__DOT__check1_EN = 0U;
    vlTOPp->mkcheck__DOT__check2_D_IN = 0U;
    vlTOPp->mkcheck__DOT__check2_EN = 0U;
    vlTOPp->mkcheck__DOT__router1__DOT__cycle_EN = 1U;
    vlTOPp->mkcheck__DOT__router1__DOT__my_id_D_IN = 0U;
    vlTOPp->mkcheck__DOT__router1__DOT__my_id_EN = 0U;
    vlTOPp->mkcheck__DOT__router2__DOT__cycle_EN = 1U;
    vlTOPp->mkcheck__DOT__router2__DOT__my_id_D_IN = 0U;
    vlTOPp->mkcheck__DOT__router2__DOT__my_id_EN = 0U;
    vlTOPp->mkcheck__DOT__counter_EN = 1U;
    vlTOPp->mkcheck__DOT__router1__DOT__input_link_CLR = 0U;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_CLR = 0U;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_CLR = 0U;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_CLR = 0U;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_CLR = 0U;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_CLR = 0U;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_CLR = 0U;
    vlTOPp->mkcheck__DOT__router2__DOT__input_link_CLR = 0U;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_CLR = 0U;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_CLR = 0U;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_CLR = 0U;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_CLR = 0U;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_CLR = 0U;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_CLR = 0U;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__data0_reg = 0xaaaaaaaaU;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__data1_reg = 0xaaaaaaaaU;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__empty_reg = 0U;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__full_reg = 1U;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__data0_reg = 0xaaaaaaaaU;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__data1_reg = 0xaaaaaaaaU;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__empty_reg = 0U;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__full_reg = 1U;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__data0_reg = 0xaaaaaaaaU;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__data1_reg = 0xaaaaaaaaU;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__empty_reg = 0U;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__full_reg = 1U;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__data0_reg = 0xaaaaaaaaU;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__data1_reg = 0xaaaaaaaaU;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__empty_reg = 0U;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__full_reg = 1U;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__data0_reg = 0xaaaaaaaaU;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__data1_reg = 0xaaaaaaaaU;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__empty_reg = 0U;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__full_reg = 1U;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__data0_reg = 0xaaaaaaaaU;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__data1_reg = 0xaaaaaaaaU;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__empty_reg = 0U;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__full_reg = 1U;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__data0_reg = 0xaaaaaaaaU;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__data1_reg = 0xaaaaaaaaU;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__empty_reg = 0U;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__full_reg = 1U;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__data0_reg = 0xaaaaaaaaU;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__data1_reg = 0xaaaaaaaaU;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__empty_reg = 0U;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__full_reg = 1U;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__data0_reg = 0xaaaaaaaaU;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__data1_reg = 0xaaaaaaaaU;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__empty_reg = 0U;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__full_reg = 1U;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__data0_reg = 0xaaaaaaaaU;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__data1_reg = 0xaaaaaaaaU;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__empty_reg = 0U;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__full_reg = 1U;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__data0_reg = 0xaaaaaaaaU;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__data1_reg = 0xaaaaaaaaU;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__empty_reg = 0U;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__full_reg = 1U;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__data0_reg = 0xaaaaaaaaU;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__data1_reg = 0xaaaaaaaaU;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__empty_reg = 0U;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__full_reg = 1U;
    vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__data0_reg = 0xaaaaaaaaU;
    vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__data1_reg = 0xaaaaaaaaU;
    vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__empty_reg = 0U;
    vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__full_reg = 1U;
    vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__data0_reg = 0xaaaaaaaaU;
    vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__data1_reg = 0xaaaaaaaaU;
    vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__empty_reg = 0U;
    vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__full_reg = 1U;
    vlTOPp->mkcheck__DOT__router2__DOT__put_value_flit 
        = vlTOPp->mkcheck__DOT__router2_put_value_flit;
    vlTOPp->mkcheck__DOT__router2__DOT__input_link_D_IN 
        = vlTOPp->mkcheck__DOT__router2_put_value_flit;
    vlTOPp->mkcheck__DOT__router2__DOT__EN_put_value 
        = vlTOPp->mkcheck__DOT__router2_EN_put_value;
    vlTOPp->mkcheck__DOT__router2__DOT__WILL_FIRE_put_value 
        = vlTOPp->mkcheck__DOT__router2_EN_put_value;
    vlTOPp->mkcheck__DOT__router2__DOT__input_link_ENQ 
        = vlTOPp->mkcheck__DOT__router2_EN_put_value;
    vlTOPp->mkcheck__DOT__router2__DOT__EN_get_valueVC1 
        = vlTOPp->mkcheck__DOT__router2_EN_get_valueVC1;
    vlTOPp->mkcheck__DOT__router2__DOT__WILL_FIRE_get_valueVC1 
        = vlTOPp->mkcheck__DOT__router2_EN_get_valueVC1;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_DEQ 
        = vlTOPp->mkcheck__DOT__router2_EN_get_valueVC1;
    vlTOPp->mkcheck__DOT__router2__DOT__EN_get_valueVC2 
        = vlTOPp->mkcheck__DOT__router2_EN_get_valueVC2;
    vlTOPp->mkcheck__DOT__router2__DOT__WILL_FIRE_get_valueVC2 
        = vlTOPp->mkcheck__DOT__router2_EN_get_valueVC2;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_DEQ 
        = vlTOPp->mkcheck__DOT__router2_EN_get_valueVC2;
    vlTOPp->mkcheck__DOT__router2__DOT__EN_get_valueVC3 
        = vlTOPp->mkcheck__DOT__router2_EN_get_valueVC3;
    vlTOPp->mkcheck__DOT__router2__DOT__WILL_FIRE_get_valueVC3 
        = vlTOPp->mkcheck__DOT__router2_EN_get_valueVC3;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_DEQ 
        = vlTOPp->mkcheck__DOT__router2_EN_get_valueVC3;
    vlTOPp->mkcheck__DOT__router2__DOT__EN_get_valueVC4 
        = vlTOPp->mkcheck__DOT__router2_EN_get_valueVC4;
    vlTOPp->mkcheck__DOT__router2__DOT__WILL_FIRE_get_valueVC4 
        = vlTOPp->mkcheck__DOT__router2_EN_get_valueVC4;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_DEQ 
        = vlTOPp->mkcheck__DOT__router2_EN_get_valueVC4;
    vlTOPp->mkcheck__DOT__router2__DOT__EN_get_valueVC5 
        = vlTOPp->mkcheck__DOT__router2_EN_get_valueVC5;
    vlTOPp->mkcheck__DOT__router2__DOT__WILL_FIRE_get_valueVC5 
        = vlTOPp->mkcheck__DOT__router2_EN_get_valueVC5;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_DEQ 
        = vlTOPp->mkcheck__DOT__router2_EN_get_valueVC5;
    vlTOPp->mkcheck__DOT__router2__DOT__EN_get_valueVC6 
        = vlTOPp->mkcheck__DOT__router2_EN_get_valueVC6;
    vlTOPp->mkcheck__DOT__router2__DOT__WILL_FIRE_get_valueVC6 
        = vlTOPp->mkcheck__DOT__router2_EN_get_valueVC6;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_DEQ 
        = vlTOPp->mkcheck__DOT__router2_EN_get_valueVC6;
    vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__CLR 
        = vlTOPp->mkcheck__DOT__router1__DOT__input_link_CLR;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__CLR 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_CLR;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__CLR 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_CLR;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__CLR 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_CLR;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__CLR 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_CLR;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__CLR 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_CLR;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__CLR 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_CLR;
    vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__CLR 
        = vlTOPp->mkcheck__DOT__router2__DOT__input_link_CLR;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__CLR 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_CLR;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__CLR 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_CLR;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__CLR 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_CLR;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__CLR 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_CLR;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__CLR 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_CLR;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__CLR 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_CLR;
}

void Vtop::_settle__TOP__4(Vtop__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop::_settle__TOP__4\n"); );
    Vtop* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->mkcheck__DOT__CLK = vlTOPp->CLK;
    vlTOPp->mkcheck__DOT__RST_N = vlTOPp->RST_N;
    vlTOPp->mkcheck__DOT__router2__DOT__put_value_flit 
        = vlTOPp->mkcheck__DOT__router2_put_value_flit;
    vlTOPp->mkcheck__DOT__router2__DOT__input_link_D_IN 
        = vlTOPp->mkcheck__DOT__router2_put_value_flit;
    vlTOPp->mkcheck__DOT__router2__DOT__EN_put_value 
        = vlTOPp->mkcheck__DOT__router2_EN_put_value;
    vlTOPp->mkcheck__DOT__router2__DOT__WILL_FIRE_put_value 
        = vlTOPp->mkcheck__DOT__router2_EN_put_value;
    vlTOPp->mkcheck__DOT__router2__DOT__input_link_ENQ 
        = vlTOPp->mkcheck__DOT__router2_EN_put_value;
    vlTOPp->mkcheck__DOT__router2__DOT__EN_get_valueVC1 
        = vlTOPp->mkcheck__DOT__router2_EN_get_valueVC1;
    vlTOPp->mkcheck__DOT__router2__DOT__WILL_FIRE_get_valueVC1 
        = vlTOPp->mkcheck__DOT__router2_EN_get_valueVC1;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_DEQ 
        = vlTOPp->mkcheck__DOT__router2_EN_get_valueVC1;
    vlTOPp->mkcheck__DOT__router2__DOT__EN_get_valueVC2 
        = vlTOPp->mkcheck__DOT__router2_EN_get_valueVC2;
    vlTOPp->mkcheck__DOT__router2__DOT__WILL_FIRE_get_valueVC2 
        = vlTOPp->mkcheck__DOT__router2_EN_get_valueVC2;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_DEQ 
        = vlTOPp->mkcheck__DOT__router2_EN_get_valueVC2;
    vlTOPp->mkcheck__DOT__router2__DOT__EN_get_valueVC3 
        = vlTOPp->mkcheck__DOT__router2_EN_get_valueVC3;
    vlTOPp->mkcheck__DOT__router2__DOT__WILL_FIRE_get_valueVC3 
        = vlTOPp->mkcheck__DOT__router2_EN_get_valueVC3;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_DEQ 
        = vlTOPp->mkcheck__DOT__router2_EN_get_valueVC3;
    vlTOPp->mkcheck__DOT__router2__DOT__EN_get_valueVC4 
        = vlTOPp->mkcheck__DOT__router2_EN_get_valueVC4;
    vlTOPp->mkcheck__DOT__router2__DOT__WILL_FIRE_get_valueVC4 
        = vlTOPp->mkcheck__DOT__router2_EN_get_valueVC4;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_DEQ 
        = vlTOPp->mkcheck__DOT__router2_EN_get_valueVC4;
    vlTOPp->mkcheck__DOT__router2__DOT__EN_get_valueVC5 
        = vlTOPp->mkcheck__DOT__router2_EN_get_valueVC5;
    vlTOPp->mkcheck__DOT__router2__DOT__WILL_FIRE_get_valueVC5 
        = vlTOPp->mkcheck__DOT__router2_EN_get_valueVC5;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_DEQ 
        = vlTOPp->mkcheck__DOT__router2_EN_get_valueVC5;
    vlTOPp->mkcheck__DOT__router2__DOT__EN_get_valueVC6 
        = vlTOPp->mkcheck__DOT__router2_EN_get_valueVC6;
    vlTOPp->mkcheck__DOT__router2__DOT__WILL_FIRE_get_valueVC6 
        = vlTOPp->mkcheck__DOT__router2_EN_get_valueVC6;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_DEQ 
        = vlTOPp->mkcheck__DOT__router2_EN_get_valueVC6;
    vlTOPp->mkcheck__DOT__router1__DOT__cycle_D_IN 
        = (1U & ((IData)(1U) + (IData)(vlTOPp->mkcheck__DOT__router1__DOT__cycle)));
    vlTOPp->mkcheck__DOT__router2__DOT__cycle_D_IN 
        = (1U & ((IData)(1U) + (IData)(vlTOPp->mkcheck__DOT__router2__DOT__cycle)));
    vlTOPp->mkcheck__DOT__counter_D_IN = ((IData)(1U) 
                                          + vlTOPp->mkcheck__DOT__counter);
    vlTOPp->mkcheck__DOT__NOT_counter_SLT_2___05F_d10 
        = (0x80000002U <= (0x80000000U ^ vlTOPp->mkcheck__DOT__counter));
    vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__CLR 
        = vlTOPp->mkcheck__DOT__router1__DOT__input_link_CLR;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__CLR 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_CLR;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__CLR 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_CLR;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__CLR 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_CLR;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__CLR 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_CLR;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__CLR 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_CLR;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__CLR 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_CLR;
    vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__CLR 
        = vlTOPp->mkcheck__DOT__router2__DOT__input_link_CLR;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__CLR 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_CLR;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__CLR 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_CLR;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__CLR 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_CLR;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__CLR 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_CLR;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__CLR 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_CLR;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__CLR 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_CLR;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__D_OUT 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__data0_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__EMPTY_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__FULL_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__full_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__D_OUT 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__data0_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__EMPTY_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__FULL_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__full_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__D_OUT 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__data0_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__EMPTY_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__FULL_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__full_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__D_OUT 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__data0_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__EMPTY_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__FULL_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__full_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__D_OUT 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__data0_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__EMPTY_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__FULL_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__full_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__D_OUT 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__data0_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__EMPTY_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__FULL_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__full_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__D_OUT 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__data0_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__FULL_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__full_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__EMPTY_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__D_OUT 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__data0_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__FULL_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__full_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__EMPTY_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__D_OUT 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__data0_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__FULL_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__full_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__EMPTY_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__D_OUT 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__data0_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__FULL_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__full_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__EMPTY_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__D_OUT 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__data0_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__FULL_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__full_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__EMPTY_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__D_OUT 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__data0_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__FULL_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__full_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__EMPTY_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__FULL_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__full_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__EMPTY_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__D_OUT 
        = vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__data0_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__EMPTY_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__empty_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__D_OUT 
        = vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__data0_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__FULL_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__full_reg;
    vlTOPp->mkcheck__DOT__router1__DOT__CLK = vlTOPp->mkcheck__DOT__CLK;
    vlTOPp->mkcheck__DOT__router2__DOT__CLK = vlTOPp->mkcheck__DOT__CLK;
    vlTOPp->mkcheck__DOT__router1__DOT__RST_N = vlTOPp->mkcheck__DOT__RST_N;
    vlTOPp->mkcheck__DOT__router2__DOT__RST_N = vlTOPp->mkcheck__DOT__RST_N;
    vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__D_IN 
        = vlTOPp->mkcheck__DOT__router2__DOT__input_link_D_IN;
    vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__D_IN 
        = vlTOPp->mkcheck__DOT__router2__DOT__input_link_D_IN;
    vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__ENQ 
        = vlTOPp->mkcheck__DOT__router2__DOT__input_link_ENQ;
    vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__ENQ 
        = vlTOPp->mkcheck__DOT__router2__DOT__input_link_ENQ;
    vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__d1di 
        = ((IData)(vlTOPp->mkcheck__DOT__router2__DOT__input_link_ENQ) 
           & (IData)(vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__empty_reg));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__DEQ 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_DEQ;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__DEQ 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_DEQ;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__d0d1 
        = ((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_DEQ) 
           & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__full_reg)));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__DEQ 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_DEQ;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__DEQ 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_DEQ;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__d0d1 
        = ((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_DEQ) 
           & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__full_reg)));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__DEQ 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_DEQ;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__DEQ 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_DEQ;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__d0d1 
        = ((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_DEQ) 
           & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__full_reg)));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__DEQ 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_DEQ;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__DEQ 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_DEQ;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__d0d1 
        = ((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_DEQ) 
           & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__full_reg)));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__DEQ 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_DEQ;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__DEQ 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_DEQ;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__d0d1 
        = ((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_DEQ) 
           & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__full_reg)));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__DEQ 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_DEQ;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__DEQ 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_DEQ;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__d0d1 
        = ((IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_DEQ) 
           & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__full_reg)));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_D_OUT 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__D_OUT;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_EMPTY_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_FULL_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__FULL_N;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_D_OUT 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__D_OUT;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_EMPTY_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_FULL_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__FULL_N;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_D_OUT 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__D_OUT;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_EMPTY_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_FULL_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__FULL_N;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_D_OUT 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__D_OUT;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_EMPTY_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_FULL_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__FULL_N;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_D_OUT 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__D_OUT;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_EMPTY_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_FULL_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__FULL_N;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_D_OUT 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__D_OUT;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_EMPTY_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_FULL_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__FULL_N;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_D_OUT 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__D_OUT;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_FULL_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__FULL_N;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_EMPTY_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__EMPTY_N;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_D_OUT 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__D_OUT;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_FULL_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__FULL_N;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_EMPTY_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__EMPTY_N;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_D_OUT 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__D_OUT;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_FULL_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__FULL_N;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_EMPTY_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__EMPTY_N;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_D_OUT 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__D_OUT;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_FULL_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__FULL_N;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_EMPTY_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__EMPTY_N;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_D_OUT 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__D_OUT;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_FULL_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__FULL_N;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_EMPTY_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__EMPTY_N;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_D_OUT 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__D_OUT;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_FULL_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__FULL_N;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_EMPTY_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__input_link_FULL_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__FULL_N;
    vlTOPp->mkcheck__DOT__router2__DOT__input_link_EMPTY_N 
        = vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__input_link_D_OUT 
        = vlTOPp->mkcheck__DOT__router2__DOT__input_link__DOT__D_OUT;
    vlTOPp->mkcheck__DOT__router1__DOT__input_link_EMPTY_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__EMPTY_N;
    vlTOPp->mkcheck__DOT__router1__DOT__input_link_D_OUT 
        = vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__D_OUT;
    vlTOPp->mkcheck__DOT__router1__DOT__input_link_FULL_N 
        = vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__FULL_N;
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
    vlTOPp->mkcheck__DOT__router2__DOT__get_valueVC1 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_D_OUT;
    vlTOPp->mkcheck__DOT__router2__DOT__RDY_get_valueVC1 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__CAN_FIRE_get_valueVC1 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__get_valueVC2 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_D_OUT;
    vlTOPp->mkcheck__DOT__router2__DOT__RDY_get_valueVC2 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__CAN_FIRE_get_valueVC2 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__get_valueVC3 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_D_OUT;
    vlTOPp->mkcheck__DOT__router2__DOT__RDY_get_valueVC3 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__CAN_FIRE_get_valueVC3 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__get_valueVC4 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_D_OUT;
    vlTOPp->mkcheck__DOT__router2__DOT__RDY_get_valueVC4 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__CAN_FIRE_get_valueVC4 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__get_valueVC5 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_D_OUT;
    vlTOPp->mkcheck__DOT__router2__DOT__RDY_get_valueVC5 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__CAN_FIRE_get_valueVC5 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__get_valueVC6 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_D_OUT;
    vlTOPp->mkcheck__DOT__router2__DOT__RDY_get_valueVC6 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_EMPTY_N;
    vlTOPp->mkcheck__DOT__router2__DOT__CAN_FIRE_get_valueVC6 
        = vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_EMPTY_N;
    vlTOPp->mkcheck__DOT__router1__DOT__get_valueVC1 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_D_OUT;
    vlTOPp->mkcheck__DOT__router1__DOT__CAN_FIRE_get_valueVC1 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_EMPTY_N;
    vlTOPp->mkcheck__DOT__router1__DOT__RDY_get_valueVC1 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_EMPTY_N;
    vlTOPp->mkcheck__DOT__router1__DOT__get_valueVC2 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_D_OUT;
    vlTOPp->mkcheck__DOT__router1__DOT__CAN_FIRE_get_valueVC2 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_EMPTY_N;
    vlTOPp->mkcheck__DOT__router1__DOT__RDY_get_valueVC2 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_EMPTY_N;
    vlTOPp->mkcheck__DOT__router1__DOT__get_valueVC3 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_D_OUT;
    vlTOPp->mkcheck__DOT__router1__DOT__CAN_FIRE_get_valueVC3 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_EMPTY_N;
    vlTOPp->mkcheck__DOT__router1__DOT__RDY_get_valueVC3 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_EMPTY_N;
    vlTOPp->mkcheck__DOT__router1__DOT__get_valueVC4 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_D_OUT;
    vlTOPp->mkcheck__DOT__router1__DOT__CAN_FIRE_get_valueVC4 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_EMPTY_N;
    vlTOPp->mkcheck__DOT__router1__DOT__RDY_get_valueVC4 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_EMPTY_N;
    vlTOPp->mkcheck__DOT__router1__DOT__get_valueVC5 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_D_OUT;
    vlTOPp->mkcheck__DOT__router1__DOT__CAN_FIRE_get_valueVC5 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_EMPTY_N;
    vlTOPp->mkcheck__DOT__router1__DOT__RDY_get_valueVC5 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_EMPTY_N;
    vlTOPp->mkcheck__DOT__router1__DOT__get_valueVC6 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_D_OUT;
    vlTOPp->mkcheck__DOT__router1__DOT__CAN_FIRE_get_valueVC6 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_EMPTY_N;
    vlTOPp->mkcheck__DOT__router1__DOT__RDY_get_valueVC6 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_EMPTY_N;
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
    vlTOPp->mkcheck__DOT__router1__DOT__CAN_FIRE_put_value 
        = vlTOPp->mkcheck__DOT__router1__DOT__input_link_FULL_N;
    vlTOPp->mkcheck__DOT__router1__DOT__RDY_put_value 
        = vlTOPp->mkcheck__DOT__router1__DOT__input_link_FULL_N;
    vlTOPp->mkcheck__DOT__router1_get_valueVC1 = vlTOPp->mkcheck__DOT__router1__DOT__get_valueVC1;
    vlTOPp->mkcheck__DOT__router1_RDY_get_valueVC1 
        = vlTOPp->mkcheck__DOT__router1__DOT__RDY_get_valueVC1;
    vlTOPp->mkcheck__DOT__router1_get_valueVC2 = vlTOPp->mkcheck__DOT__router1__DOT__get_valueVC2;
    vlTOPp->mkcheck__DOT__router1_RDY_get_valueVC2 
        = vlTOPp->mkcheck__DOT__router1__DOT__RDY_get_valueVC2;
    vlTOPp->mkcheck__DOT__router1_get_valueVC3 = vlTOPp->mkcheck__DOT__router1__DOT__get_valueVC3;
    vlTOPp->mkcheck__DOT__router1_RDY_get_valueVC3 
        = vlTOPp->mkcheck__DOT__router1__DOT__RDY_get_valueVC3;
    vlTOPp->mkcheck__DOT__router1_get_valueVC4 = vlTOPp->mkcheck__DOT__router1__DOT__get_valueVC4;
    vlTOPp->mkcheck__DOT__router1_RDY_get_valueVC4 
        = vlTOPp->mkcheck__DOT__router1__DOT__RDY_get_valueVC4;
    vlTOPp->mkcheck__DOT__router1_get_valueVC5 = vlTOPp->mkcheck__DOT__router1__DOT__get_valueVC5;
    vlTOPp->mkcheck__DOT__router1_RDY_get_valueVC5 
        = vlTOPp->mkcheck__DOT__router1__DOT__RDY_get_valueVC5;
    vlTOPp->mkcheck__DOT__router1_get_valueVC6 = vlTOPp->mkcheck__DOT__router1__DOT__get_valueVC6;
    vlTOPp->mkcheck__DOT__router1_RDY_get_valueVC6 
        = vlTOPp->mkcheck__DOT__router1__DOT__RDY_get_valueVC6;
    vlTOPp->mkcheck__DOT__router2__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_odd 
        = vlTOPp->mkcheck__DOT__router2__DOT__CAN_FIRE_RL_read_input_link_and_send_to_VC_odd;
    vlTOPp->mkcheck__DOT__router2__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_even 
        = vlTOPp->mkcheck__DOT__router2__DOT__CAN_FIRE_RL_read_input_link_and_send_to_VC_even;
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
    vlTOPp->mkcheck__DOT__router1__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_odd 
        = vlTOPp->mkcheck__DOT__router1__DOT__CAN_FIRE_RL_read_input_link_and_send_to_VC_odd;
    vlTOPp->mkcheck__DOT__router1__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_even 
        = vlTOPp->mkcheck__DOT__router1__DOT__CAN_FIRE_RL_read_input_link_and_send_to_VC_even;
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
    vlTOPp->mkcheck__DOT__router1_RDY_put_value = vlTOPp->mkcheck__DOT__router1__DOT__RDY_put_value;
    vlTOPp->mkcheck__DOT__CAN_FIRE_RL_two_cycle1 = 
        ((IData)(vlTOPp->mkcheck__DOT__router1_RDY_get_valueVC1) 
         & (IData)(vlTOPp->mkcheck__DOT__NOT_counter_SLT_2___05F_d10));
    vlTOPp->mkcheck__DOT__CAN_FIRE_RL_two_cycle2 = 
        ((IData)(vlTOPp->mkcheck__DOT__router1_RDY_get_valueVC2) 
         & (IData)(vlTOPp->mkcheck__DOT__NOT_counter_SLT_2___05F_d10));
    vlTOPp->mkcheck__DOT__CAN_FIRE_RL_two_cycle3 = 
        ((IData)(vlTOPp->mkcheck__DOT__router1_RDY_get_valueVC3) 
         & (IData)(vlTOPp->mkcheck__DOT__NOT_counter_SLT_2___05F_d10));
    vlTOPp->mkcheck__DOT__CAN_FIRE_RL_two_cycle4 = 
        ((IData)(vlTOPp->mkcheck__DOT__router1_RDY_get_valueVC4) 
         & (IData)(vlTOPp->mkcheck__DOT__NOT_counter_SLT_2___05F_d10));
    vlTOPp->mkcheck__DOT__CAN_FIRE_RL_two_cycle5 = 
        ((IData)(vlTOPp->mkcheck__DOT__router1_RDY_get_valueVC5) 
         & (IData)(vlTOPp->mkcheck__DOT__NOT_counter_SLT_2___05F_d10));
    vlTOPp->mkcheck__DOT__CAN_FIRE_RL_two_cycle6 = 
        ((IData)(vlTOPp->mkcheck__DOT__router1_RDY_get_valueVC6) 
         & (IData)(vlTOPp->mkcheck__DOT__NOT_counter_SLT_2___05F_d10));
    vlTOPp->mkcheck__DOT__router2__DOT__input_link_DEQ 
        = ((IData)(vlTOPp->mkcheck__DOT__router2__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_even) 
           | (IData)(vlTOPp->mkcheck__DOT__router2__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_odd));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_1_ENQ 
        = ((IData)(vlTOPp->mkcheck__DOT__router2__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_odd) 
           & (IData)(vlTOPp->mkcheck__DOT__router2__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_EQ_my___05FETC___05F_d15));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_2_ENQ 
        = ((IData)(vlTOPp->mkcheck__DOT__router2__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_even) 
           & (IData)(vlTOPp->mkcheck__DOT__router2__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_EQ_my___05FETC___05F_d15));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_3_ENQ 
        = (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_odd) 
            & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_EQ_my___05FETC___05F_d15))) 
           & (IData)(vlTOPp->mkcheck__DOT__router2__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_SLT_my_ETC___05F_d17));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_4_ENQ 
        = (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_even) 
            & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_EQ_my___05FETC___05F_d15))) 
           & (IData)(vlTOPp->mkcheck__DOT__router2__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_SLT_my_ETC___05F_d17));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_5_ENQ 
        = (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_odd) 
            & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_EQ_my___05FETC___05F_d15))) 
           & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_SLT_my_ETC___05F_d17)));
    vlTOPp->mkcheck__DOT__router2__DOT__vir_chnl_6_ENQ 
        = (((IData)(vlTOPp->mkcheck__DOT__router2__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_even) 
            & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_EQ_my___05FETC___05F_d15))) 
           & (~ (IData)(vlTOPp->mkcheck__DOT__router2__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_SLT_my_ETC___05F_d17)));
    vlTOPp->mkcheck__DOT__router1__DOT__input_link_DEQ 
        = ((IData)(vlTOPp->mkcheck__DOT__router1__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_even) 
           | (IData)(vlTOPp->mkcheck__DOT__router1__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_odd));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_ENQ 
        = ((IData)(vlTOPp->mkcheck__DOT__router1__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_odd) 
           & (IData)(vlTOPp->mkcheck__DOT__router1__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_EQ_my___05FETC___05F_d15));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_ENQ 
        = ((IData)(vlTOPp->mkcheck__DOT__router1__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_even) 
           & (IData)(vlTOPp->mkcheck__DOT__router1__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_EQ_my___05FETC___05F_d15));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_ENQ 
        = (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_odd) 
            & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_EQ_my___05FETC___05F_d15))) 
           & (IData)(vlTOPp->mkcheck__DOT__router1__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_SLT_my_ETC___05F_d17));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_ENQ 
        = (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_even) 
            & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_EQ_my___05FETC___05F_d15))) 
           & (IData)(vlTOPp->mkcheck__DOT__router1__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_SLT_my_ETC___05F_d17));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_ENQ 
        = (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_odd) 
            & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_EQ_my___05FETC___05F_d15))) 
           & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_SLT_my_ETC___05F_d17)));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_ENQ 
        = (((IData)(vlTOPp->mkcheck__DOT__router1__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_even) 
            & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_EQ_my___05FETC___05F_d15))) 
           & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_SLT_my_ETC___05F_d17)));
    vlTOPp->mkcheck__DOT__CAN_FIRE_RL_check1_update1 
        = ((IData)(vlTOPp->mkcheck__DOT__router1_RDY_put_value) 
           & (0U == vlTOPp->mkcheck__DOT__counter));
    vlTOPp->mkcheck__DOT__CAN_FIRE_RL_check1_update2 
        = ((IData)(vlTOPp->mkcheck__DOT__router1_RDY_put_value) 
           & (1U == vlTOPp->mkcheck__DOT__counter));
    vlTOPp->mkcheck__DOT__WILL_FIRE_RL_two_cycle1 = vlTOPp->mkcheck__DOT__CAN_FIRE_RL_two_cycle1;
    vlTOPp->mkcheck__DOT__router1_EN_get_valueVC1 = vlTOPp->mkcheck__DOT__CAN_FIRE_RL_two_cycle1;
    vlTOPp->mkcheck__DOT__WILL_FIRE_RL_two_cycle2 = vlTOPp->mkcheck__DOT__CAN_FIRE_RL_two_cycle2;
    vlTOPp->mkcheck__DOT__router1_EN_get_valueVC2 = vlTOPp->mkcheck__DOT__CAN_FIRE_RL_two_cycle2;
    vlTOPp->mkcheck__DOT__WILL_FIRE_RL_two_cycle3 = vlTOPp->mkcheck__DOT__CAN_FIRE_RL_two_cycle3;
    vlTOPp->mkcheck__DOT__router1_EN_get_valueVC3 = vlTOPp->mkcheck__DOT__CAN_FIRE_RL_two_cycle3;
    vlTOPp->mkcheck__DOT__WILL_FIRE_RL_two_cycle4 = vlTOPp->mkcheck__DOT__CAN_FIRE_RL_two_cycle4;
    vlTOPp->mkcheck__DOT__router1_EN_get_valueVC4 = vlTOPp->mkcheck__DOT__CAN_FIRE_RL_two_cycle4;
    vlTOPp->mkcheck__DOT__WILL_FIRE_RL_two_cycle5 = vlTOPp->mkcheck__DOT__CAN_FIRE_RL_two_cycle5;
    vlTOPp->mkcheck__DOT__router1_EN_get_valueVC5 = vlTOPp->mkcheck__DOT__CAN_FIRE_RL_two_cycle5;
    vlTOPp->mkcheck__DOT__WILL_FIRE_RL_two_cycle6 = vlTOPp->mkcheck__DOT__CAN_FIRE_RL_two_cycle6;
    vlTOPp->mkcheck__DOT__router1_EN_get_valueVC6 = vlTOPp->mkcheck__DOT__CAN_FIRE_RL_two_cycle6;
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
    vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__DEQ 
        = vlTOPp->mkcheck__DOT__router1__DOT__input_link_DEQ;
    vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__d0d1 
        = ((IData)(vlTOPp->mkcheck__DOT__router1__DOT__input_link_DEQ) 
           & (~ (IData)(vlTOPp->mkcheck__DOT__router1__DOT__input_link__DOT__full_reg)));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__ENQ 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_ENQ;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__d1di 
        = ((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_ENQ) 
           & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__empty_reg));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__ENQ 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_ENQ;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__d1di 
        = ((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_ENQ) 
           & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__empty_reg));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__ENQ 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_ENQ;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__d1di 
        = ((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_ENQ) 
           & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__empty_reg));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__ENQ 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_ENQ;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__d1di 
        = ((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_ENQ) 
           & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__empty_reg));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__ENQ 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_ENQ;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__d1di 
        = ((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_ENQ) 
           & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__empty_reg));
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__ENQ 
        = vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_ENQ;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__d1di 
        = ((IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_ENQ) 
           & (IData)(vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__empty_reg));
    vlTOPp->mkcheck__DOT__WILL_FIRE_RL_check1_update1 
        = vlTOPp->mkcheck__DOT__CAN_FIRE_RL_check1_update1;
    vlTOPp->mkcheck__DOT__WILL_FIRE_RL_check1_update2 
        = vlTOPp->mkcheck__DOT__CAN_FIRE_RL_check1_update2;
    vlTOPp->mkcheck__DOT__router1__DOT__EN_get_valueVC1 
        = vlTOPp->mkcheck__DOT__router1_EN_get_valueVC1;
    vlTOPp->mkcheck__DOT__router1__DOT__WILL_FIRE_get_valueVC1 
        = vlTOPp->mkcheck__DOT__router1_EN_get_valueVC1;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_1_DEQ 
        = vlTOPp->mkcheck__DOT__router1_EN_get_valueVC1;
    vlTOPp->mkcheck__DOT__router1__DOT__EN_get_valueVC2 
        = vlTOPp->mkcheck__DOT__router1_EN_get_valueVC2;
    vlTOPp->mkcheck__DOT__router1__DOT__WILL_FIRE_get_valueVC2 
        = vlTOPp->mkcheck__DOT__router1_EN_get_valueVC2;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_2_DEQ 
        = vlTOPp->mkcheck__DOT__router1_EN_get_valueVC2;
    vlTOPp->mkcheck__DOT__router1__DOT__EN_get_valueVC3 
        = vlTOPp->mkcheck__DOT__router1_EN_get_valueVC3;
    vlTOPp->mkcheck__DOT__router1__DOT__WILL_FIRE_get_valueVC3 
        = vlTOPp->mkcheck__DOT__router1_EN_get_valueVC3;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_3_DEQ 
        = vlTOPp->mkcheck__DOT__router1_EN_get_valueVC3;
    vlTOPp->mkcheck__DOT__router1__DOT__EN_get_valueVC4 
        = vlTOPp->mkcheck__DOT__router1_EN_get_valueVC4;
    vlTOPp->mkcheck__DOT__router1__DOT__WILL_FIRE_get_valueVC4 
        = vlTOPp->mkcheck__DOT__router1_EN_get_valueVC4;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_4_DEQ 
        = vlTOPp->mkcheck__DOT__router1_EN_get_valueVC4;
    vlTOPp->mkcheck__DOT__router1__DOT__EN_get_valueVC5 
        = vlTOPp->mkcheck__DOT__router1_EN_get_valueVC5;
    vlTOPp->mkcheck__DOT__router1__DOT__WILL_FIRE_get_valueVC5 
        = vlTOPp->mkcheck__DOT__router1_EN_get_valueVC5;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_5_DEQ 
        = vlTOPp->mkcheck__DOT__router1_EN_get_valueVC5;
    vlTOPp->mkcheck__DOT__router1__DOT__EN_get_valueVC6 
        = vlTOPp->mkcheck__DOT__router1_EN_get_valueVC6;
    vlTOPp->mkcheck__DOT__router1__DOT__WILL_FIRE_get_valueVC6 
        = vlTOPp->mkcheck__DOT__router1_EN_get_valueVC6;
    vlTOPp->mkcheck__DOT__router1__DOT__vir_chnl_6_DEQ 
        = vlTOPp->mkcheck__DOT__router1_EN_get_valueVC6;
    vlTOPp->mkcheck__DOT__router1_put_value_flit = 
        ((IData)(vlTOPp->mkcheck__DOT__WILL_FIRE_RL_check1_update2)
          ? 0x80000000U : 0xffffffffU);
    vlTOPp->mkcheck__DOT__router1_EN_put_value = ((IData)(vlTOPp->mkcheck__DOT__WILL_FIRE_RL_check1_update2) 
                                                  | (IData)(vlTOPp->mkcheck__DOT__WILL_FIRE_RL_check1_update1));
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

void Vtop::_eval_initial(Vtop__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop::_eval_initial\n"); );
    Vtop* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->_initial__TOP__1(vlSymsp);
    vlTOPp->__Vclklast__TOP__CLK = vlTOPp->CLK;
}

void Vtop::final() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop::final\n"); );
    // Variables
    Vtop__Syms* __restrict vlSymsp = this->__VlSymsp;
    Vtop* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
}

void Vtop::_eval_settle(Vtop__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop::_eval_settle\n"); );
    Vtop* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->_settle__TOP__4(vlSymsp);
}

void Vtop::_ctor_var_reset() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop::_ctor_var_reset\n"); );
    // Body
    CLK = 0;
    RST_N = 0;
    mkcheck__DOT__CLK = 0;
    mkcheck__DOT__RST_N = 0;
    mkcheck__DOT__check1 = 0;
    mkcheck__DOT__check1_D_IN = 0;
    mkcheck__DOT__check1_EN = 0;
    mkcheck__DOT__check2 = 0;
    mkcheck__DOT__check2_D_IN = 0;
    mkcheck__DOT__check2_EN = 0;
    mkcheck__DOT__counter = 0;
    mkcheck__DOT__counter_D_IN = 0;
    mkcheck__DOT__counter_EN = 0;
    mkcheck__DOT__router1_get_valueVC1 = 0;
    mkcheck__DOT__router1_get_valueVC2 = 0;
    mkcheck__DOT__router1_get_valueVC3 = 0;
    mkcheck__DOT__router1_get_valueVC4 = 0;
    mkcheck__DOT__router1_get_valueVC5 = 0;
    mkcheck__DOT__router1_get_valueVC6 = 0;
    mkcheck__DOT__router1_put_value_flit = 0;
    mkcheck__DOT__router1_EN_get_valueVC1 = 0;
    mkcheck__DOT__router1_EN_get_valueVC2 = 0;
    mkcheck__DOT__router1_EN_get_valueVC3 = 0;
    mkcheck__DOT__router1_EN_get_valueVC4 = 0;
    mkcheck__DOT__router1_EN_get_valueVC5 = 0;
    mkcheck__DOT__router1_EN_get_valueVC6 = 0;
    mkcheck__DOT__router1_EN_put_value = 0;
    mkcheck__DOT__router1_RDY_get_valueVC1 = 0;
    mkcheck__DOT__router1_RDY_get_valueVC2 = 0;
    mkcheck__DOT__router1_RDY_get_valueVC3 = 0;
    mkcheck__DOT__router1_RDY_get_valueVC4 = 0;
    mkcheck__DOT__router1_RDY_get_valueVC5 = 0;
    mkcheck__DOT__router1_RDY_get_valueVC6 = 0;
    mkcheck__DOT__router1_RDY_put_value = 0;
    mkcheck__DOT__router2_put_value_flit = 0;
    mkcheck__DOT__router2_EN_get_valueVC1 = 0;
    mkcheck__DOT__router2_EN_get_valueVC2 = 0;
    mkcheck__DOT__router2_EN_get_valueVC3 = 0;
    mkcheck__DOT__router2_EN_get_valueVC4 = 0;
    mkcheck__DOT__router2_EN_get_valueVC5 = 0;
    mkcheck__DOT__router2_EN_get_valueVC6 = 0;
    mkcheck__DOT__router2_EN_put_value = 0;
    mkcheck__DOT__CAN_FIRE_RL_check1_update1 = 0;
    mkcheck__DOT__CAN_FIRE_RL_check1_update2 = 0;
    mkcheck__DOT__CAN_FIRE_RL_two_cycle1 = 0;
    mkcheck__DOT__CAN_FIRE_RL_two_cycle2 = 0;
    mkcheck__DOT__CAN_FIRE_RL_two_cycle3 = 0;
    mkcheck__DOT__CAN_FIRE_RL_two_cycle4 = 0;
    mkcheck__DOT__CAN_FIRE_RL_two_cycle5 = 0;
    mkcheck__DOT__CAN_FIRE_RL_two_cycle6 = 0;
    mkcheck__DOT__CAN_FIRE_RL_update_counter = 0;
    mkcheck__DOT__WILL_FIRE_RL_check1_update1 = 0;
    mkcheck__DOT__WILL_FIRE_RL_check1_update2 = 0;
    mkcheck__DOT__WILL_FIRE_RL_two_cycle1 = 0;
    mkcheck__DOT__WILL_FIRE_RL_two_cycle2 = 0;
    mkcheck__DOT__WILL_FIRE_RL_two_cycle3 = 0;
    mkcheck__DOT__WILL_FIRE_RL_two_cycle4 = 0;
    mkcheck__DOT__WILL_FIRE_RL_two_cycle5 = 0;
    mkcheck__DOT__WILL_FIRE_RL_two_cycle6 = 0;
    mkcheck__DOT__WILL_FIRE_RL_update_counter = 0;
    mkcheck__DOT__NOT_counter_SLT_2___05F_d10 = 0;
    mkcheck__DOT__router1__DOT__CLK = 0;
    mkcheck__DOT__router1__DOT__RST_N = 0;
    mkcheck__DOT__router1__DOT__put_value_flit = 0;
    mkcheck__DOT__router1__DOT__EN_put_value = 0;
    mkcheck__DOT__router1__DOT__RDY_put_value = 0;
    mkcheck__DOT__router1__DOT__EN_get_valueVC1 = 0;
    mkcheck__DOT__router1__DOT__get_valueVC1 = 0;
    mkcheck__DOT__router1__DOT__RDY_get_valueVC1 = 0;
    mkcheck__DOT__router1__DOT__EN_get_valueVC2 = 0;
    mkcheck__DOT__router1__DOT__get_valueVC2 = 0;
    mkcheck__DOT__router1__DOT__RDY_get_valueVC2 = 0;
    mkcheck__DOT__router1__DOT__EN_get_valueVC3 = 0;
    mkcheck__DOT__router1__DOT__get_valueVC3 = 0;
    mkcheck__DOT__router1__DOT__RDY_get_valueVC3 = 0;
    mkcheck__DOT__router1__DOT__EN_get_valueVC4 = 0;
    mkcheck__DOT__router1__DOT__get_valueVC4 = 0;
    mkcheck__DOT__router1__DOT__RDY_get_valueVC4 = 0;
    mkcheck__DOT__router1__DOT__EN_get_valueVC5 = 0;
    mkcheck__DOT__router1__DOT__get_valueVC5 = 0;
    mkcheck__DOT__router1__DOT__RDY_get_valueVC5 = 0;
    mkcheck__DOT__router1__DOT__EN_get_valueVC6 = 0;
    mkcheck__DOT__router1__DOT__get_valueVC6 = 0;
    mkcheck__DOT__router1__DOT__RDY_get_valueVC6 = 0;
    mkcheck__DOT__router1__DOT__cycle = 0;
    mkcheck__DOT__router1__DOT__cycle_D_IN = 0;
    mkcheck__DOT__router1__DOT__cycle_EN = 0;
    mkcheck__DOT__router1__DOT__my_id = 0;
    mkcheck__DOT__router1__DOT__my_id_D_IN = 0;
    mkcheck__DOT__router1__DOT__my_id_EN = 0;
    mkcheck__DOT__router1__DOT__input_link_D_IN = 0;
    mkcheck__DOT__router1__DOT__input_link_D_OUT = 0;
    mkcheck__DOT__router1__DOT__input_link_CLR = 0;
    mkcheck__DOT__router1__DOT__input_link_DEQ = 0;
    mkcheck__DOT__router1__DOT__input_link_EMPTY_N = 0;
    mkcheck__DOT__router1__DOT__input_link_ENQ = 0;
    mkcheck__DOT__router1__DOT__input_link_FULL_N = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_1_D_IN = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_1_D_OUT = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_1_CLR = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_1_DEQ = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_1_EMPTY_N = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_1_ENQ = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_1_FULL_N = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_2_D_IN = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_2_D_OUT = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_2_CLR = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_2_DEQ = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_2_EMPTY_N = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_2_ENQ = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_2_FULL_N = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_3_D_IN = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_3_D_OUT = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_3_CLR = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_3_DEQ = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_3_EMPTY_N = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_3_ENQ = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_3_FULL_N = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_4_D_IN = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_4_D_OUT = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_4_CLR = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_4_DEQ = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_4_EMPTY_N = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_4_ENQ = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_4_FULL_N = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_5_D_IN = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_5_D_OUT = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_5_CLR = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_5_DEQ = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_5_EMPTY_N = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_5_ENQ = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_5_FULL_N = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_6_D_IN = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_6_D_OUT = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_6_CLR = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_6_DEQ = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_6_EMPTY_N = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_6_ENQ = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_6_FULL_N = 0;
    mkcheck__DOT__router1__DOT__CAN_FIRE_RL_invert_cycle = 0;
    mkcheck__DOT__router1__DOT__CAN_FIRE_RL_read_input_link_and_send_to_VC_even = 0;
    mkcheck__DOT__router1__DOT__CAN_FIRE_RL_read_input_link_and_send_to_VC_odd = 0;
    mkcheck__DOT__router1__DOT__CAN_FIRE_get_valueVC1 = 0;
    mkcheck__DOT__router1__DOT__CAN_FIRE_get_valueVC2 = 0;
    mkcheck__DOT__router1__DOT__CAN_FIRE_get_valueVC3 = 0;
    mkcheck__DOT__router1__DOT__CAN_FIRE_get_valueVC4 = 0;
    mkcheck__DOT__router1__DOT__CAN_FIRE_get_valueVC5 = 0;
    mkcheck__DOT__router1__DOT__CAN_FIRE_get_valueVC6 = 0;
    mkcheck__DOT__router1__DOT__CAN_FIRE_put_value = 0;
    mkcheck__DOT__router1__DOT__WILL_FIRE_RL_invert_cycle = 0;
    mkcheck__DOT__router1__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_even = 0;
    mkcheck__DOT__router1__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_odd = 0;
    mkcheck__DOT__router1__DOT__WILL_FIRE_get_valueVC1 = 0;
    mkcheck__DOT__router1__DOT__WILL_FIRE_get_valueVC2 = 0;
    mkcheck__DOT__router1__DOT__WILL_FIRE_get_valueVC3 = 0;
    mkcheck__DOT__router1__DOT__WILL_FIRE_get_valueVC4 = 0;
    mkcheck__DOT__router1__DOT__WILL_FIRE_get_valueVC5 = 0;
    mkcheck__DOT__router1__DOT__WILL_FIRE_get_valueVC6 = 0;
    mkcheck__DOT__router1__DOT__WILL_FIRE_put_value = 0;
    mkcheck__DOT__router1__DOT__b___05Fh929 = 0;
    mkcheck__DOT__router1__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_EQ_my___05FETC___05F_d15 = 0;
    mkcheck__DOT__router1__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_SLT_my_ETC___05F_d17 = 0;
    mkcheck__DOT__router1__DOT__input_link__DOT__CLK = 0;
    mkcheck__DOT__router1__DOT__input_link__DOT__RST = 0;
    mkcheck__DOT__router1__DOT__input_link__DOT__D_IN = 0;
    mkcheck__DOT__router1__DOT__input_link__DOT__ENQ = 0;
    mkcheck__DOT__router1__DOT__input_link__DOT__DEQ = 0;
    mkcheck__DOT__router1__DOT__input_link__DOT__CLR = 0;
    mkcheck__DOT__router1__DOT__input_link__DOT__FULL_N = 0;
    mkcheck__DOT__router1__DOT__input_link__DOT__EMPTY_N = 0;
    mkcheck__DOT__router1__DOT__input_link__DOT__D_OUT = 0;
    mkcheck__DOT__router1__DOT__input_link__DOT__full_reg = 0;
    mkcheck__DOT__router1__DOT__input_link__DOT__empty_reg = 0;
    mkcheck__DOT__router1__DOT__input_link__DOT__data0_reg = 0;
    mkcheck__DOT__router1__DOT__input_link__DOT__data1_reg = 0;
    mkcheck__DOT__router1__DOT__input_link__DOT__d0di = 0;
    mkcheck__DOT__router1__DOT__input_link__DOT__d0d1 = 0;
    mkcheck__DOT__router1__DOT__input_link__DOT__d0h = 0;
    mkcheck__DOT__router1__DOT__input_link__DOT__d1di = 0;
    mkcheck__DOT__router1__DOT__input_link__DOT__error_checks__DOT__deqerror = 0;
    mkcheck__DOT__router1__DOT__input_link__DOT__error_checks__DOT__enqerror = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__CLK = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__RST = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__D_IN = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__ENQ = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__DEQ = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__CLR = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__FULL_N = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__EMPTY_N = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__D_OUT = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__full_reg = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__empty_reg = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__data0_reg = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__data1_reg = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__d0di = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__d0d1 = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__d0h = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__d1di = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__error_checks__DOT__deqerror = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__error_checks__DOT__enqerror = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__CLK = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__RST = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__D_IN = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__ENQ = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__DEQ = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__CLR = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__FULL_N = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__EMPTY_N = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__D_OUT = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__full_reg = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__empty_reg = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__data0_reg = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__data1_reg = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__d0di = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__d0d1 = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__d0h = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__d1di = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__error_checks__DOT__deqerror = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__error_checks__DOT__enqerror = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__CLK = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__RST = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__D_IN = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__ENQ = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__DEQ = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__CLR = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__FULL_N = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__EMPTY_N = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__D_OUT = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__full_reg = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__empty_reg = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__data0_reg = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__data1_reg = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__d0di = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__d0d1 = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__d0h = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__d1di = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__error_checks__DOT__deqerror = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__error_checks__DOT__enqerror = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__CLK = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__RST = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__D_IN = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__ENQ = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__DEQ = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__CLR = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__FULL_N = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__EMPTY_N = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__D_OUT = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__full_reg = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__empty_reg = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__data0_reg = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__data1_reg = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__d0di = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__d0d1 = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__d0h = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__d1di = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__error_checks__DOT__deqerror = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__error_checks__DOT__enqerror = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__CLK = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__RST = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__D_IN = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__ENQ = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__DEQ = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__CLR = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__FULL_N = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__EMPTY_N = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__D_OUT = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__full_reg = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__empty_reg = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__data0_reg = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__data1_reg = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__d0di = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__d0d1 = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__d0h = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__d1di = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__error_checks__DOT__deqerror = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__error_checks__DOT__enqerror = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__CLK = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__RST = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__D_IN = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__ENQ = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__DEQ = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__CLR = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__FULL_N = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__EMPTY_N = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__D_OUT = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__full_reg = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__empty_reg = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__data0_reg = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__data1_reg = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__d0di = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__d0d1 = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__d0h = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__d1di = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__error_checks__DOT__deqerror = 0;
    mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__error_checks__DOT__enqerror = 0;
    mkcheck__DOT__router2__DOT__CLK = 0;
    mkcheck__DOT__router2__DOT__RST_N = 0;
    mkcheck__DOT__router2__DOT__put_value_flit = 0;
    mkcheck__DOT__router2__DOT__EN_put_value = 0;
    mkcheck__DOT__router2__DOT__RDY_put_value = 0;
    mkcheck__DOT__router2__DOT__EN_get_valueVC1 = 0;
    mkcheck__DOT__router2__DOT__get_valueVC1 = 0;
    mkcheck__DOT__router2__DOT__RDY_get_valueVC1 = 0;
    mkcheck__DOT__router2__DOT__EN_get_valueVC2 = 0;
    mkcheck__DOT__router2__DOT__get_valueVC2 = 0;
    mkcheck__DOT__router2__DOT__RDY_get_valueVC2 = 0;
    mkcheck__DOT__router2__DOT__EN_get_valueVC3 = 0;
    mkcheck__DOT__router2__DOT__get_valueVC3 = 0;
    mkcheck__DOT__router2__DOT__RDY_get_valueVC3 = 0;
    mkcheck__DOT__router2__DOT__EN_get_valueVC4 = 0;
    mkcheck__DOT__router2__DOT__get_valueVC4 = 0;
    mkcheck__DOT__router2__DOT__RDY_get_valueVC4 = 0;
    mkcheck__DOT__router2__DOT__EN_get_valueVC5 = 0;
    mkcheck__DOT__router2__DOT__get_valueVC5 = 0;
    mkcheck__DOT__router2__DOT__RDY_get_valueVC5 = 0;
    mkcheck__DOT__router2__DOT__EN_get_valueVC6 = 0;
    mkcheck__DOT__router2__DOT__get_valueVC6 = 0;
    mkcheck__DOT__router2__DOT__RDY_get_valueVC6 = 0;
    mkcheck__DOT__router2__DOT__cycle = 0;
    mkcheck__DOT__router2__DOT__cycle_D_IN = 0;
    mkcheck__DOT__router2__DOT__cycle_EN = 0;
    mkcheck__DOT__router2__DOT__my_id = 0;
    mkcheck__DOT__router2__DOT__my_id_D_IN = 0;
    mkcheck__DOT__router2__DOT__my_id_EN = 0;
    mkcheck__DOT__router2__DOT__input_link_D_IN = 0;
    mkcheck__DOT__router2__DOT__input_link_D_OUT = 0;
    mkcheck__DOT__router2__DOT__input_link_CLR = 0;
    mkcheck__DOT__router2__DOT__input_link_DEQ = 0;
    mkcheck__DOT__router2__DOT__input_link_EMPTY_N = 0;
    mkcheck__DOT__router2__DOT__input_link_ENQ = 0;
    mkcheck__DOT__router2__DOT__input_link_FULL_N = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_1_D_IN = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_1_D_OUT = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_1_CLR = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_1_DEQ = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_1_EMPTY_N = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_1_ENQ = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_1_FULL_N = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_2_D_IN = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_2_D_OUT = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_2_CLR = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_2_DEQ = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_2_EMPTY_N = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_2_ENQ = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_2_FULL_N = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_3_D_IN = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_3_D_OUT = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_3_CLR = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_3_DEQ = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_3_EMPTY_N = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_3_ENQ = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_3_FULL_N = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_4_D_IN = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_4_D_OUT = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_4_CLR = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_4_DEQ = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_4_EMPTY_N = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_4_ENQ = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_4_FULL_N = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_5_D_IN = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_5_D_OUT = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_5_CLR = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_5_DEQ = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_5_EMPTY_N = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_5_ENQ = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_5_FULL_N = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_6_D_IN = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_6_D_OUT = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_6_CLR = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_6_DEQ = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_6_EMPTY_N = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_6_ENQ = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_6_FULL_N = 0;
    mkcheck__DOT__router2__DOT__CAN_FIRE_RL_invert_cycle = 0;
    mkcheck__DOT__router2__DOT__CAN_FIRE_RL_read_input_link_and_send_to_VC_even = 0;
    mkcheck__DOT__router2__DOT__CAN_FIRE_RL_read_input_link_and_send_to_VC_odd = 0;
    mkcheck__DOT__router2__DOT__CAN_FIRE_get_valueVC1 = 0;
    mkcheck__DOT__router2__DOT__CAN_FIRE_get_valueVC2 = 0;
    mkcheck__DOT__router2__DOT__CAN_FIRE_get_valueVC3 = 0;
    mkcheck__DOT__router2__DOT__CAN_FIRE_get_valueVC4 = 0;
    mkcheck__DOT__router2__DOT__CAN_FIRE_get_valueVC5 = 0;
    mkcheck__DOT__router2__DOT__CAN_FIRE_get_valueVC6 = 0;
    mkcheck__DOT__router2__DOT__CAN_FIRE_put_value = 0;
    mkcheck__DOT__router2__DOT__WILL_FIRE_RL_invert_cycle = 0;
    mkcheck__DOT__router2__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_even = 0;
    mkcheck__DOT__router2__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_odd = 0;
    mkcheck__DOT__router2__DOT__WILL_FIRE_get_valueVC1 = 0;
    mkcheck__DOT__router2__DOT__WILL_FIRE_get_valueVC2 = 0;
    mkcheck__DOT__router2__DOT__WILL_FIRE_get_valueVC3 = 0;
    mkcheck__DOT__router2__DOT__WILL_FIRE_get_valueVC4 = 0;
    mkcheck__DOT__router2__DOT__WILL_FIRE_get_valueVC5 = 0;
    mkcheck__DOT__router2__DOT__WILL_FIRE_get_valueVC6 = 0;
    mkcheck__DOT__router2__DOT__WILL_FIRE_put_value = 0;
    mkcheck__DOT__router2__DOT__b___05Fh929 = 0;
    mkcheck__DOT__router2__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_EQ_my___05FETC___05F_d15 = 0;
    mkcheck__DOT__router2__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_SLT_my_ETC___05F_d17 = 0;
    mkcheck__DOT__router2__DOT__input_link__DOT__CLK = 0;
    mkcheck__DOT__router2__DOT__input_link__DOT__RST = 0;
    mkcheck__DOT__router2__DOT__input_link__DOT__D_IN = 0;
    mkcheck__DOT__router2__DOT__input_link__DOT__ENQ = 0;
    mkcheck__DOT__router2__DOT__input_link__DOT__DEQ = 0;
    mkcheck__DOT__router2__DOT__input_link__DOT__CLR = 0;
    mkcheck__DOT__router2__DOT__input_link__DOT__FULL_N = 0;
    mkcheck__DOT__router2__DOT__input_link__DOT__EMPTY_N = 0;
    mkcheck__DOT__router2__DOT__input_link__DOT__D_OUT = 0;
    mkcheck__DOT__router2__DOT__input_link__DOT__full_reg = 0;
    mkcheck__DOT__router2__DOT__input_link__DOT__empty_reg = 0;
    mkcheck__DOT__router2__DOT__input_link__DOT__data0_reg = 0;
    mkcheck__DOT__router2__DOT__input_link__DOT__data1_reg = 0;
    mkcheck__DOT__router2__DOT__input_link__DOT__d0di = 0;
    mkcheck__DOT__router2__DOT__input_link__DOT__d0d1 = 0;
    mkcheck__DOT__router2__DOT__input_link__DOT__d0h = 0;
    mkcheck__DOT__router2__DOT__input_link__DOT__d1di = 0;
    mkcheck__DOT__router2__DOT__input_link__DOT__error_checks__DOT__deqerror = 0;
    mkcheck__DOT__router2__DOT__input_link__DOT__error_checks__DOT__enqerror = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__CLK = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__RST = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__D_IN = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__ENQ = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__DEQ = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__CLR = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__FULL_N = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__EMPTY_N = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__D_OUT = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__full_reg = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__empty_reg = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__data0_reg = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__data1_reg = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__d0di = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__d0d1 = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__d0h = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__d1di = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__error_checks__DOT__deqerror = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__error_checks__DOT__enqerror = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__CLK = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__RST = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__D_IN = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__ENQ = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__DEQ = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__CLR = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__FULL_N = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__EMPTY_N = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__D_OUT = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__full_reg = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__empty_reg = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__data0_reg = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__data1_reg = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__d0di = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__d0d1 = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__d0h = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__d1di = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__error_checks__DOT__deqerror = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__error_checks__DOT__enqerror = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__CLK = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__RST = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__D_IN = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__ENQ = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__DEQ = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__CLR = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__FULL_N = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__EMPTY_N = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__D_OUT = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__full_reg = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__empty_reg = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__data0_reg = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__data1_reg = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__d0di = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__d0d1 = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__d0h = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__d1di = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__error_checks__DOT__deqerror = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__error_checks__DOT__enqerror = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__CLK = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__RST = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__D_IN = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__ENQ = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__DEQ = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__CLR = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__FULL_N = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__EMPTY_N = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__D_OUT = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__full_reg = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__empty_reg = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__data0_reg = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__data1_reg = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__d0di = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__d0d1 = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__d0h = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__d1di = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__error_checks__DOT__deqerror = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__error_checks__DOT__enqerror = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__CLK = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__RST = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__D_IN = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__ENQ = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__DEQ = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__CLR = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__FULL_N = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__EMPTY_N = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__D_OUT = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__full_reg = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__empty_reg = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__data0_reg = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__data1_reg = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__d0di = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__d0d1 = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__d0h = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__d1di = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__error_checks__DOT__deqerror = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__error_checks__DOT__enqerror = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__CLK = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__RST = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__D_IN = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__ENQ = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__DEQ = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__CLR = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__FULL_N = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__EMPTY_N = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__D_OUT = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__full_reg = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__empty_reg = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__data0_reg = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__data1_reg = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__d0di = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__d0d1 = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__d0h = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__d1di = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__error_checks__DOT__deqerror = 0;
    mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__error_checks__DOT__enqerror = 0;
    for (int __Vi0=0; __Vi0<1; ++__Vi0) {
        __Vm_traceActivity[__Vi0] = 0;
    }
}
