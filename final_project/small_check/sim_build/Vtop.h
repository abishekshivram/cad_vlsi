// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Primary design header
//
// This header should be included by all source files instantiating the design.
// The class here is then constructed to instantiate the design.
// See the Verilator manual for examples.

#ifndef _VTOP_H_
#define _VTOP_H_  // guard

#include "verilated_heavy.h"
#include "Vtop__Dpi.h"

//==========

class Vtop__Syms;
class Vtop_VerilatedVcd;


//----------

VL_MODULE(Vtop) {
  public:
    
    // PORTS
    // The application code writes and reads these signals to
    // propagate new values into/out from the Verilated model.
    // Begin mtask footprint all: 
    VL_IN8(CLK,0,0);
    VL_IN8(RST_N,0,0);
    
    // LOCAL SIGNALS
    // Internals; generally not touched by application code
    // Anonymous structures to workaround compiler member-count bugs
    struct {
        // Begin mtask footprint all: 
        CData/*0:0*/ mkcheck__DOT__CLK;
        CData/*0:0*/ mkcheck__DOT__RST_N;
        CData/*0:0*/ mkcheck__DOT__check1_EN;
        CData/*0:0*/ mkcheck__DOT__check2_EN;
        CData/*0:0*/ mkcheck__DOT__counter_EN;
        CData/*0:0*/ mkcheck__DOT__router1_EN_get_valueVC1;
        CData/*0:0*/ mkcheck__DOT__router1_EN_get_valueVC2;
        CData/*0:0*/ mkcheck__DOT__router1_EN_get_valueVC3;
        CData/*0:0*/ mkcheck__DOT__router1_EN_get_valueVC4;
        CData/*0:0*/ mkcheck__DOT__router1_EN_get_valueVC5;
        CData/*0:0*/ mkcheck__DOT__router1_EN_get_valueVC6;
        CData/*0:0*/ mkcheck__DOT__router1_EN_put_value;
        CData/*0:0*/ mkcheck__DOT__router1_RDY_get_valueVC1;
        CData/*0:0*/ mkcheck__DOT__router1_RDY_get_valueVC2;
        CData/*0:0*/ mkcheck__DOT__router1_RDY_get_valueVC3;
        CData/*0:0*/ mkcheck__DOT__router1_RDY_get_valueVC4;
        CData/*0:0*/ mkcheck__DOT__router1_RDY_get_valueVC5;
        CData/*0:0*/ mkcheck__DOT__router1_RDY_get_valueVC6;
        CData/*0:0*/ mkcheck__DOT__router1_RDY_put_value;
        CData/*0:0*/ mkcheck__DOT__router2_EN_get_valueVC1;
        CData/*0:0*/ mkcheck__DOT__router2_EN_get_valueVC2;
        CData/*0:0*/ mkcheck__DOT__router2_EN_get_valueVC3;
        CData/*0:0*/ mkcheck__DOT__router2_EN_get_valueVC4;
        CData/*0:0*/ mkcheck__DOT__router2_EN_get_valueVC5;
        CData/*0:0*/ mkcheck__DOT__router2_EN_get_valueVC6;
        CData/*0:0*/ mkcheck__DOT__router2_EN_put_value;
        CData/*0:0*/ mkcheck__DOT__CAN_FIRE_RL_check1_update1;
        CData/*0:0*/ mkcheck__DOT__CAN_FIRE_RL_check1_update2;
        CData/*0:0*/ mkcheck__DOT__CAN_FIRE_RL_two_cycle1;
        CData/*0:0*/ mkcheck__DOT__CAN_FIRE_RL_two_cycle2;
        CData/*0:0*/ mkcheck__DOT__CAN_FIRE_RL_two_cycle3;
        CData/*0:0*/ mkcheck__DOT__CAN_FIRE_RL_two_cycle4;
        CData/*0:0*/ mkcheck__DOT__CAN_FIRE_RL_two_cycle5;
        CData/*0:0*/ mkcheck__DOT__CAN_FIRE_RL_two_cycle6;
        CData/*0:0*/ mkcheck__DOT__CAN_FIRE_RL_update_counter;
        CData/*0:0*/ mkcheck__DOT__WILL_FIRE_RL_check1_update1;
        CData/*0:0*/ mkcheck__DOT__WILL_FIRE_RL_check1_update2;
        CData/*0:0*/ mkcheck__DOT__WILL_FIRE_RL_two_cycle1;
        CData/*0:0*/ mkcheck__DOT__WILL_FIRE_RL_two_cycle2;
        CData/*0:0*/ mkcheck__DOT__WILL_FIRE_RL_two_cycle3;
        CData/*0:0*/ mkcheck__DOT__WILL_FIRE_RL_two_cycle4;
        CData/*0:0*/ mkcheck__DOT__WILL_FIRE_RL_two_cycle5;
        CData/*0:0*/ mkcheck__DOT__WILL_FIRE_RL_two_cycle6;
        CData/*0:0*/ mkcheck__DOT__WILL_FIRE_RL_update_counter;
        CData/*0:0*/ mkcheck__DOT__NOT_counter_SLT_2___05F_d10;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__CLK;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__RST_N;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__EN_put_value;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__RDY_put_value;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__EN_get_valueVC1;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__RDY_get_valueVC1;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__EN_get_valueVC2;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__RDY_get_valueVC2;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__EN_get_valueVC3;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__RDY_get_valueVC3;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__EN_get_valueVC4;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__RDY_get_valueVC4;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__EN_get_valueVC5;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__RDY_get_valueVC5;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__EN_get_valueVC6;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__RDY_get_valueVC6;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__cycle;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__cycle_D_IN;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__cycle_EN;
    };
    struct {
        CData/*0:0*/ mkcheck__DOT__router1__DOT__my_id_EN;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__input_link_CLR;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__input_link_DEQ;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__input_link_EMPTY_N;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__input_link_ENQ;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__input_link_FULL_N;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_1_CLR;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_1_DEQ;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_1_EMPTY_N;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_1_ENQ;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_1_FULL_N;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_2_CLR;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_2_DEQ;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_2_EMPTY_N;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_2_ENQ;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_2_FULL_N;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_3_CLR;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_3_DEQ;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_3_EMPTY_N;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_3_ENQ;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_3_FULL_N;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_4_CLR;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_4_DEQ;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_4_EMPTY_N;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_4_ENQ;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_4_FULL_N;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_5_CLR;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_5_DEQ;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_5_EMPTY_N;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_5_ENQ;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_5_FULL_N;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_6_CLR;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_6_DEQ;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_6_EMPTY_N;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_6_ENQ;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_6_FULL_N;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__CAN_FIRE_RL_invert_cycle;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__CAN_FIRE_RL_read_input_link_and_send_to_VC_even;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__CAN_FIRE_RL_read_input_link_and_send_to_VC_odd;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__CAN_FIRE_get_valueVC1;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__CAN_FIRE_get_valueVC2;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__CAN_FIRE_get_valueVC3;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__CAN_FIRE_get_valueVC4;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__CAN_FIRE_get_valueVC5;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__CAN_FIRE_get_valueVC6;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__CAN_FIRE_put_value;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__WILL_FIRE_RL_invert_cycle;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_even;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_odd;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__WILL_FIRE_get_valueVC1;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__WILL_FIRE_get_valueVC2;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__WILL_FIRE_get_valueVC3;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__WILL_FIRE_get_valueVC4;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__WILL_FIRE_get_valueVC5;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__WILL_FIRE_get_valueVC6;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__WILL_FIRE_put_value;
        CData/*0:0*/ mkcheck__DOT__router1__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_EQ_my___05FETC___05F_d15;
        CData/*0:0*/ mkcheck__DOT__router1__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_SLT_my_ETC___05F_d17;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__input_link__DOT__CLK;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__input_link__DOT__RST;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__input_link__DOT__ENQ;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__input_link__DOT__DEQ;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__input_link__DOT__CLR;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__input_link__DOT__FULL_N;
    };
    struct {
        CData/*0:0*/ mkcheck__DOT__router1__DOT__input_link__DOT__EMPTY_N;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__input_link__DOT__full_reg;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__input_link__DOT__empty_reg;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__input_link__DOT__d0di;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__input_link__DOT__d0d1;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__input_link__DOT__d0h;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__input_link__DOT__d1di;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__input_link__DOT__error_checks__DOT__deqerror;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__input_link__DOT__error_checks__DOT__enqerror;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__CLK;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__RST;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__ENQ;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__DEQ;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__CLR;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__FULL_N;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__EMPTY_N;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__full_reg;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__empty_reg;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__d0di;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__d0d1;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__d0h;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__d1di;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__error_checks__DOT__deqerror;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__error_checks__DOT__enqerror;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__CLK;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__RST;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__ENQ;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__DEQ;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__CLR;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__FULL_N;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__EMPTY_N;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__full_reg;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__empty_reg;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__d0di;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__d0d1;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__d0h;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__d1di;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__error_checks__DOT__deqerror;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__error_checks__DOT__enqerror;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__CLK;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__RST;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__ENQ;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__DEQ;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__CLR;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__FULL_N;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__EMPTY_N;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__full_reg;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__empty_reg;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__d0di;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__d0d1;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__d0h;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__d1di;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__error_checks__DOT__deqerror;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__error_checks__DOT__enqerror;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__CLK;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__RST;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__ENQ;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__DEQ;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__CLR;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__FULL_N;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__EMPTY_N;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__full_reg;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__empty_reg;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__d0di;
    };
    struct {
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__d0d1;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__d0h;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__d1di;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__error_checks__DOT__deqerror;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__error_checks__DOT__enqerror;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__CLK;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__RST;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__ENQ;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__DEQ;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__CLR;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__FULL_N;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__EMPTY_N;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__full_reg;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__empty_reg;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__d0di;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__d0d1;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__d0h;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__d1di;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__error_checks__DOT__deqerror;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__error_checks__DOT__enqerror;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__CLK;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__RST;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__ENQ;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__DEQ;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__CLR;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__FULL_N;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__EMPTY_N;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__full_reg;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__empty_reg;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__d0di;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__d0d1;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__d0h;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__d1di;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__error_checks__DOT__deqerror;
        CData/*0:0*/ mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__error_checks__DOT__enqerror;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__CLK;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__RST_N;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__EN_put_value;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__RDY_put_value;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__EN_get_valueVC1;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__RDY_get_valueVC1;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__EN_get_valueVC2;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__RDY_get_valueVC2;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__EN_get_valueVC3;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__RDY_get_valueVC3;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__EN_get_valueVC4;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__RDY_get_valueVC4;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__EN_get_valueVC5;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__RDY_get_valueVC5;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__EN_get_valueVC6;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__RDY_get_valueVC6;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__cycle;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__cycle_D_IN;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__cycle_EN;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__my_id_EN;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__input_link_CLR;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__input_link_DEQ;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__input_link_EMPTY_N;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__input_link_ENQ;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__input_link_FULL_N;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_1_CLR;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_1_DEQ;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_1_EMPTY_N;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_1_ENQ;
    };
    struct {
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_1_FULL_N;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_2_CLR;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_2_DEQ;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_2_EMPTY_N;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_2_ENQ;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_2_FULL_N;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_3_CLR;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_3_DEQ;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_3_EMPTY_N;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_3_ENQ;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_3_FULL_N;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_4_CLR;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_4_DEQ;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_4_EMPTY_N;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_4_ENQ;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_4_FULL_N;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_5_CLR;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_5_DEQ;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_5_EMPTY_N;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_5_ENQ;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_5_FULL_N;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_6_CLR;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_6_DEQ;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_6_EMPTY_N;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_6_ENQ;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_6_FULL_N;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__CAN_FIRE_RL_invert_cycle;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__CAN_FIRE_RL_read_input_link_and_send_to_VC_even;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__CAN_FIRE_RL_read_input_link_and_send_to_VC_odd;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__CAN_FIRE_get_valueVC1;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__CAN_FIRE_get_valueVC2;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__CAN_FIRE_get_valueVC3;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__CAN_FIRE_get_valueVC4;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__CAN_FIRE_get_valueVC5;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__CAN_FIRE_get_valueVC6;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__CAN_FIRE_put_value;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__WILL_FIRE_RL_invert_cycle;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_even;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__WILL_FIRE_RL_read_input_link_and_send_to_VC_odd;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__WILL_FIRE_get_valueVC1;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__WILL_FIRE_get_valueVC2;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__WILL_FIRE_get_valueVC3;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__WILL_FIRE_get_valueVC4;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__WILL_FIRE_get_valueVC5;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__WILL_FIRE_get_valueVC6;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__WILL_FIRE_put_value;
        CData/*0:0*/ mkcheck__DOT__router2__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_EQ_my___05FETC___05F_d15;
        CData/*0:0*/ mkcheck__DOT__router2__DOT___0_CONCAT_input_link_first___05F1_BIT_31_2_3_SLT_my_ETC___05F_d17;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__input_link__DOT__CLK;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__input_link__DOT__RST;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__input_link__DOT__ENQ;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__input_link__DOT__DEQ;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__input_link__DOT__CLR;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__input_link__DOT__FULL_N;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__input_link__DOT__EMPTY_N;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__input_link__DOT__full_reg;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__input_link__DOT__empty_reg;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__input_link__DOT__d0di;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__input_link__DOT__d0d1;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__input_link__DOT__d0h;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__input_link__DOT__d1di;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__input_link__DOT__error_checks__DOT__deqerror;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__input_link__DOT__error_checks__DOT__enqerror;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__CLK;
    };
    struct {
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__RST;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__ENQ;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__DEQ;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__CLR;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__FULL_N;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__EMPTY_N;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__full_reg;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__empty_reg;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__d0di;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__d0d1;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__d0h;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__d1di;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__error_checks__DOT__deqerror;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__error_checks__DOT__enqerror;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__CLK;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__RST;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__ENQ;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__DEQ;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__CLR;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__FULL_N;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__EMPTY_N;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__full_reg;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__empty_reg;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__d0di;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__d0d1;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__d0h;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__d1di;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__error_checks__DOT__deqerror;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__error_checks__DOT__enqerror;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__CLK;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__RST;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__ENQ;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__DEQ;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__CLR;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__FULL_N;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__EMPTY_N;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__full_reg;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__empty_reg;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__d0di;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__d0d1;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__d0h;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__d1di;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__error_checks__DOT__deqerror;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__error_checks__DOT__enqerror;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__CLK;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__RST;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__ENQ;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__DEQ;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__CLR;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__FULL_N;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__EMPTY_N;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__full_reg;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__empty_reg;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__d0di;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__d0d1;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__d0h;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__d1di;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__error_checks__DOT__deqerror;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__error_checks__DOT__enqerror;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__CLK;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__RST;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__ENQ;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__DEQ;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__CLR;
    };
    struct {
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__FULL_N;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__EMPTY_N;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__full_reg;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__empty_reg;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__d0di;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__d0d1;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__d0h;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__d1di;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__error_checks__DOT__deqerror;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__error_checks__DOT__enqerror;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__CLK;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__RST;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__ENQ;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__DEQ;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__CLR;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__FULL_N;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__EMPTY_N;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__full_reg;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__empty_reg;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__d0di;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__d0d1;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__d0h;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__d1di;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__error_checks__DOT__deqerror;
        CData/*0:0*/ mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__error_checks__DOT__enqerror;
        IData/*31:0*/ mkcheck__DOT__check1;
        IData/*31:0*/ mkcheck__DOT__check1_D_IN;
        IData/*31:0*/ mkcheck__DOT__check2;
        IData/*31:0*/ mkcheck__DOT__check2_D_IN;
        IData/*31:0*/ mkcheck__DOT__counter;
        IData/*31:0*/ mkcheck__DOT__counter_D_IN;
        IData/*31:0*/ mkcheck__DOT__router1_get_valueVC1;
        IData/*31:0*/ mkcheck__DOT__router1_get_valueVC2;
        IData/*31:0*/ mkcheck__DOT__router1_get_valueVC3;
        IData/*31:0*/ mkcheck__DOT__router1_get_valueVC4;
        IData/*31:0*/ mkcheck__DOT__router1_get_valueVC5;
        IData/*31:0*/ mkcheck__DOT__router1_get_valueVC6;
        IData/*31:0*/ mkcheck__DOT__router1_put_value_flit;
        IData/*31:0*/ mkcheck__DOT__router2_put_value_flit;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__put_value_flit;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__get_valueVC1;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__get_valueVC2;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__get_valueVC3;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__get_valueVC4;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__get_valueVC5;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__get_valueVC6;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__my_id;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__my_id_D_IN;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__input_link_D_IN;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__input_link_D_OUT;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__vir_chnl_1_D_IN;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__vir_chnl_1_D_OUT;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__vir_chnl_2_D_IN;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__vir_chnl_2_D_OUT;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__vir_chnl_3_D_IN;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__vir_chnl_3_D_OUT;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__vir_chnl_4_D_IN;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__vir_chnl_4_D_OUT;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__vir_chnl_5_D_IN;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__vir_chnl_5_D_OUT;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__vir_chnl_6_D_IN;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__vir_chnl_6_D_OUT;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__b___05Fh929;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__input_link__DOT__D_IN;
    };
    struct {
        IData/*31:0*/ mkcheck__DOT__router1__DOT__input_link__DOT__D_OUT;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__input_link__DOT__data0_reg;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__input_link__DOT__data1_reg;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__D_IN;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__D_OUT;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__data0_reg;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__vir_chnl_1__DOT__data1_reg;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__D_IN;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__D_OUT;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__data0_reg;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__vir_chnl_2__DOT__data1_reg;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__D_IN;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__D_OUT;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__data0_reg;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__vir_chnl_3__DOT__data1_reg;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__D_IN;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__D_OUT;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__data0_reg;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__vir_chnl_4__DOT__data1_reg;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__D_IN;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__D_OUT;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__data0_reg;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__vir_chnl_5__DOT__data1_reg;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__D_IN;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__D_OUT;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__data0_reg;
        IData/*31:0*/ mkcheck__DOT__router1__DOT__vir_chnl_6__DOT__data1_reg;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__put_value_flit;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__get_valueVC1;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__get_valueVC2;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__get_valueVC3;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__get_valueVC4;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__get_valueVC5;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__get_valueVC6;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__my_id;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__my_id_D_IN;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__input_link_D_IN;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__input_link_D_OUT;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__vir_chnl_1_D_IN;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__vir_chnl_1_D_OUT;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__vir_chnl_2_D_IN;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__vir_chnl_2_D_OUT;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__vir_chnl_3_D_IN;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__vir_chnl_3_D_OUT;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__vir_chnl_4_D_IN;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__vir_chnl_4_D_OUT;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__vir_chnl_5_D_IN;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__vir_chnl_5_D_OUT;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__vir_chnl_6_D_IN;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__vir_chnl_6_D_OUT;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__b___05Fh929;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__input_link__DOT__D_IN;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__input_link__DOT__D_OUT;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__input_link__DOT__data0_reg;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__input_link__DOT__data1_reg;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__D_IN;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__D_OUT;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__data0_reg;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__vir_chnl_1__DOT__data1_reg;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__D_IN;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__D_OUT;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__data0_reg;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__vir_chnl_2__DOT__data1_reg;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__D_IN;
    };
    struct {
        IData/*31:0*/ mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__D_OUT;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__data0_reg;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__vir_chnl_3__DOT__data1_reg;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__D_IN;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__D_OUT;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__data0_reg;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__vir_chnl_4__DOT__data1_reg;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__D_IN;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__D_OUT;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__data0_reg;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__vir_chnl_5__DOT__data1_reg;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__D_IN;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__D_OUT;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__data0_reg;
        IData/*31:0*/ mkcheck__DOT__router2__DOT__vir_chnl_6__DOT__data1_reg;
    };
    
    // LOCAL VARIABLES
    // Internals; generally not touched by application code
    // Begin mtask footprint all: 
    CData/*0:0*/ __Vclklast__TOP__CLK;
    CData/*0:0*/ __Vm_traceActivity[1];
    
    // INTERNAL VARIABLES
    // Internals; generally not touched by application code
    Vtop__Syms* __VlSymsp;  // Symbol table
    
    // CONSTRUCTORS
  private:
    VL_UNCOPYABLE(Vtop);  ///< Copying not allowed
  public:
    /// Construct the model; called by application code
    /// The special name  may be used to make a wrapper with a
    /// single model invisible with respect to DPI scope names.
    Vtop(const char* name = "TOP");
    /// Destroy the model; called (often implicitly) by application code
    ~Vtop();
    /// Trace signals in the model; called by application code
    void trace(VerilatedVcdC* tfp, int levels, int options = 0);
    
    // API METHODS
    /// Evaluate the model.  Application must call when inputs change.
    void eval() { eval_step(); }
    /// Evaluate when calling multiple units/models per time step.
    void eval_step();
    /// Evaluate at end of a timestep for tracing, when using eval_step().
    /// Application must call after all eval() and before time changes.
    void eval_end_step() {}
    /// Simulation complete, run final blocks.  Application must call on completion.
    void final();
    
    // INTERNAL METHODS
    static void _eval_initial_loop(Vtop__Syms* __restrict vlSymsp);
    void __Vconfigure(Vtop__Syms* symsp, bool first);
  private:
    static QData _change_request(Vtop__Syms* __restrict vlSymsp);
    static QData _change_request_1(Vtop__Syms* __restrict vlSymsp);
  public:
    static void _combo__TOP__3(Vtop__Syms* __restrict vlSymsp);
  private:
    void _ctor_var_reset() VL_ATTR_COLD;
  public:
    static void _eval(Vtop__Syms* __restrict vlSymsp);
  private:
#ifdef VL_DEBUG
    void _eval_debug_assertions();
#endif  // VL_DEBUG
  public:
    static void _eval_initial(Vtop__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    static void _eval_settle(Vtop__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    static void _initial__TOP__1(Vtop__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    static void _sequent__TOP__2(Vtop__Syms* __restrict vlSymsp);
    static void _sequent__TOP__5(Vtop__Syms* __restrict vlSymsp);
    static void _settle__TOP__4(Vtop__Syms* __restrict vlSymsp) VL_ATTR_COLD;
  private:
    static void traceChgSub0(void* userp, VerilatedVcd* tracep);
    static void traceChgTop0(void* userp, VerilatedVcd* tracep);
    static void traceCleanup(void* userp, VerilatedVcd* /*unused*/);
    static void traceFullSub0(void* userp, VerilatedVcd* tracep) VL_ATTR_COLD;
    static void traceFullTop0(void* userp, VerilatedVcd* tracep) VL_ATTR_COLD;
    static void traceInitSub0(void* userp, VerilatedVcd* tracep) VL_ATTR_COLD;
    static void traceInitTop(void* userp, VerilatedVcd* tracep) VL_ATTR_COLD;
    void traceRegister(VerilatedVcd* tracep) VL_ATTR_COLD;
    static void traceInit(void* userp, VerilatedVcd* tracep, uint32_t code) VL_ATTR_COLD;
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

//----------


#endif  // guard
