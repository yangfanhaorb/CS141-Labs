/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

#include "xsi.h"

struct XSI_INFO xsi_info;



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    work_m_00000000004278842996_4122600708_init();
    work_m_00000000001101224573_3190593924_init();
    work_m_00000000001930915864_2813080386_init();
    work_m_00000000003616863062_3978046435_init();
    work_m_00000000003616863062_3908755369_init();
    work_m_00000000002644877524_1256557045_init();
    work_m_00000000004134447467_2073120511_init();


    xsi_register_tops("work_m_00000000002644877524_1256557045");
    xsi_register_tops("work_m_00000000004134447467_2073120511");


    return xsi_run_simulation(argc, argv);

}
