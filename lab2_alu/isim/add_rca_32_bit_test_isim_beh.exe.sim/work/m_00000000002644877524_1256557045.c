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

/* This file is designed for use with ISim build 0x8ef4fb42 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Users/cs141/Desktop/CS141-Labs/lab2_alu/add_rca_32_bit_test.v";
static int ng1[] = {0, 0};
static int ng2[] = {2, 0};
static int ng3[] = {16, 0};
static int ng4[] = {1, 0};
static const char *ng5 = "TEST FAILURE!!!  TEST FAILED with %d ERRORS";
static const char *ng6 = "!!! TEST SUCCESS !!!";
static int ng7[] = {32, 0};
static const char *ng8 = "ERROR: X = %b, Y = %b, ci = %b, sum = %b, co = %b";



static void Initial_31_0(char *t0)
{
    char t6[8];
    char t17[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;

LAB0:    t1 = (t0 + 2088U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(31, ng0);

LAB4:    xsi_set_current_line(33, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 920);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);
    xsi_set_current_line(34, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 1012);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);
    xsi_set_current_line(35, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 1104);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(36, ng0);
    xsi_set_current_line(36, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 1380);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);

LAB5:    t2 = (t0 + 1380);
    t3 = (t2 + 36U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng2)));
    memset(t6, 0, 8);
    xsi_vlog_signed_less(t6, 32, t4, 32, t5, 32);
    t7 = (t6 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t6);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB6;

LAB7:    xsi_set_current_line(49, ng0);
    t2 = (t0 + 1564);
    t3 = (t2 + 36U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng1)));
    memset(t6, 0, 8);
    xsi_vlog_signed_greater(t6, 32, t4, 32, t5, 32);
    t7 = (t6 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t6);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB18;

LAB19:    xsi_set_current_line(52, ng0);

LAB22:    xsi_set_current_line(53, ng0);
    xsi_vlogfile_write(1, 0, 0, ng6, 1, t0);

LAB20:    xsi_set_current_line(56, ng0);
    xsi_vlog_finish(1);

LAB1:    return;
LAB6:    xsi_set_current_line(36, ng0);

LAB8:    xsi_set_current_line(37, ng0);
    t13 = (t0 + 1380);
    t14 = (t13 + 36U);
    t15 = *((char **)t14);
    t16 = (t0 + 1104);
    xsi_vlogvar_assign_value(t16, t15, 0, 0, 1);
    xsi_set_current_line(38, ng0);
    xsi_set_current_line(38, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 1196);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);

LAB9:    t2 = (t0 + 1196);
    t3 = (t2 + 36U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng3)));
    memset(t6, 0, 8);
    xsi_vlog_signed_less(t6, 32, t4, 32, t5, 32);
    t7 = (t6 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t6);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB10;

LAB11:    xsi_set_current_line(36, ng0);
    t2 = (t0 + 1380);
    t3 = (t2 + 36U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng4)));
    memset(t6, 0, 8);
    xsi_vlog_signed_add(t6, 32, t4, 32, t5, 32);
    t7 = (t0 + 1380);
    xsi_vlogvar_assign_value(t7, t6, 0, 0, 32);
    goto LAB5;

LAB10:    xsi_set_current_line(38, ng0);

LAB12:    xsi_set_current_line(39, ng0);
    *((int *)t17) = xsi_vlog_rtl_dist_uniform(0, 0, -2147483648, 2147483647);
    t13 = (t17 + 4);
    *((int *)t13) = 0;
    t14 = (t0 + 1472);
    xsi_vlogvar_assign_value(t14, t17, 0, 0, 32);
    xsi_set_current_line(40, ng0);
    t2 = (t0 + 1472);
    t3 = (t2 + 36U);
    t4 = *((char **)t3);
    t5 = (t0 + 920);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 32);
    xsi_set_current_line(41, ng0);
    xsi_set_current_line(41, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 1288);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);

LAB13:    t2 = (t0 + 1288);
    t3 = (t2 + 36U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng3)));
    memset(t6, 0, 8);
    xsi_vlog_signed_less(t6, 32, t4, 32, t5, 32);
    t7 = (t6 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t6);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB14;

LAB15:    xsi_set_current_line(38, ng0);
    t2 = (t0 + 1196);
    t3 = (t2 + 36U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng4)));
    memset(t6, 0, 8);
    xsi_vlog_signed_add(t6, 32, t4, 32, t5, 32);
    t7 = (t0 + 1196);
    xsi_vlogvar_assign_value(t7, t6, 0, 0, 32);
    goto LAB9;

LAB14:    xsi_set_current_line(41, ng0);

LAB16:    xsi_set_current_line(42, ng0);
    *((int *)t17) = xsi_vlog_rtl_dist_uniform(0, 0, -2147483648, 2147483647);
    t13 = (t17 + 4);
    *((int *)t13) = 0;
    t14 = (t0 + 1472);
    xsi_vlogvar_assign_value(t14, t17, 0, 0, 32);
    xsi_set_current_line(43, ng0);
    t2 = (t0 + 1472);
    t3 = (t2 + 36U);
    t4 = *((char **)t3);
    t5 = (t0 + 1012);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 32);
    xsi_set_current_line(44, ng0);
    t2 = (t0 + 1988);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB17;
    goto LAB1;

LAB17:    xsi_set_current_line(41, ng0);
    t2 = (t0 + 1288);
    t3 = (t2 + 36U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng4)));
    memset(t6, 0, 8);
    xsi_vlog_signed_add(t6, 32, t4, 32, t5, 32);
    t7 = (t0 + 1288);
    xsi_vlogvar_assign_value(t7, t6, 0, 0, 32);
    goto LAB13;

LAB18:    xsi_set_current_line(49, ng0);

LAB21:    xsi_set_current_line(50, ng0);
    t13 = (t0 + 1564);
    t14 = (t13 + 36U);
    t15 = *((char **)t14);
    xsi_vlogfile_write(1, 0, 0, ng5, 2, t0, (char)119, t15, 32);
    goto LAB20;

}

static void Always_59_1(char *t0)
{
    char t8[8];
    char t12[8];
    char t16[8];
    char t17[8];
    char t18[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t9;
    char *t10;
    char *t11;
    char *t13;
    char *t14;
    char *t15;
    char *t19;
    char *t20;
    char *t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;

LAB0:    t1 = (t0 + 2232U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(59, ng0);
    t2 = (t0 + 2428);
    *((int *)t2) = 1;
    t3 = (t0 + 2260);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(59, ng0);

LAB5:    xsi_set_current_line(60, ng0);
    t4 = (t0 + 2132);
    xsi_process_wait(t4, 1000LL);
    *((char **)t1) = &&LAB6;
    goto LAB1;

LAB6:    xsi_set_current_line(61, ng0);
    t2 = (t0 + 920);
    t3 = (t2 + 36U);
    t4 = *((char **)t3);
    t5 = (t0 + 1012);
    t6 = (t5 + 36U);
    t7 = *((char **)t6);
    memset(t8, 0, 8);
    xsi_vlog_unsigned_add(t8, 32, t4, 32, t7, 32);
    t9 = (t0 + 1104);
    t10 = (t9 + 36U);
    t11 = *((char **)t10);
    memset(t12, 0, 8);
    xsi_vlog_unsigned_add(t12, 32, t8, 32, t11, 1);
    t13 = (t0 + 692U);
    t14 = *((char **)t13);
    t13 = (t0 + 600U);
    t15 = *((char **)t13);
    t13 = ((char*)((ng7)));
    memset(t16, 0, 8);
    xsi_vlog_unsigned_lshift(t16, 32, t15, 1, t13, 32);
    memset(t17, 0, 8);
    xsi_vlog_unsigned_add(t17, 32, t14, 32, t16, 32);
    memset(t18, 0, 8);
    if (*((unsigned int *)t12) != *((unsigned int *)t17))
        goto LAB8;

LAB7:    t19 = (t12 + 4);
    t20 = (t17 + 4);
    if (*((unsigned int *)t19) != *((unsigned int *)t20))
        goto LAB8;

LAB9:    t21 = (t18 + 4);
    t22 = *((unsigned int *)t21);
    t23 = (~(t22));
    t24 = *((unsigned int *)t18);
    t25 = (t24 & t23);
    t26 = (t25 != 0);
    if (t26 > 0)
        goto LAB10;

LAB11:
LAB12:    goto LAB2;

LAB8:    *((unsigned int *)t18) = 1;
    goto LAB9;

LAB10:    xsi_set_current_line(61, ng0);

LAB13:    xsi_set_current_line(62, ng0);
    t27 = (t0 + 920);
    t28 = (t27 + 36U);
    t29 = *((char **)t28);
    t30 = (t0 + 1012);
    t31 = (t30 + 36U);
    t32 = *((char **)t31);
    t33 = (t0 + 1104);
    t34 = (t33 + 36U);
    t35 = *((char **)t34);
    t36 = (t0 + 692U);
    t37 = *((char **)t36);
    t36 = (t0 + 600U);
    t38 = *((char **)t36);
    xsi_vlogfile_write(1, 0, 0, ng8, 6, t0, (char)118, t29, 32, (char)118, t32, 32, (char)118, t35, 1, (char)118, t37, 32, (char)118, t38, 1);
    xsi_set_current_line(63, ng0);
    t2 = (t0 + 1564);
    t3 = (t2 + 36U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng4)));
    memset(t8, 0, 8);
    xsi_vlog_signed_add(t8, 32, t4, 32, t5, 32);
    t6 = (t0 + 1564);
    xsi_vlogvar_assign_value(t6, t8, 0, 0, 32);
    goto LAB12;

}


extern void work_m_00000000002644877524_1256557045_init()
{
	static char *pe[] = {(void *)Initial_31_0,(void *)Always_59_1};
	xsi_register_didat("work_m_00000000002644877524_1256557045", "isim/add_rca_32_bit_test_isim_beh.exe.sim/work/m_00000000002644877524_1256557045.didat");
	xsi_register_executes(pe);
}
