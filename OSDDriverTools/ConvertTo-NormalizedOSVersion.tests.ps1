
. $PSscriptRoot\ConvertTo-NormalizedOSVersion.ps1    

describe 'failure Control tests' {

    { ConvertTo-NormalizedOSVersion 'XP.x86' } | should throw
    { ConvertTo-NormalizedOSVersion 'Vista.x86'} | should throw
    { ConvertTo-NormalizedOSVersion 'Vista.x64'} | should throw
    { ConvertTo-NormalizedOSVersion 'XP.x64'} | should throw
    { ConvertTo-NormalizedOSVersion 'winpe3x.x86'} | should throw
    { ConvertTo-NormalizedOSVersion 'winpe3x.x64'} | should throw
    { ConvertTo-NormalizedOSVersion 'winpe4x.x86'} | should throw
    { ConvertTo-NormalizedOSVersion 'winpe4x.x64'} | should throw
    { ConvertTo-NormalizedOSVersion 'winpe5x.x86'} | should throw
    { ConvertTo-NormalizedOSVersion 'winpe5x.x64'} | should throw

    { ConvertTo-NormalizedOSVersion ''} | should throw
    { ConvertTo-NormalizedOSVersion 'garbage'} | should throw

}

describe 'basic HP tests' {

    ConvertTo-NormalizedOSVersion 'Windows 7 64-bit' | should be 'Win7.x64'
    ConvertTo-NormalizedOSVersion 'Windows 8.1 64-bit' | should be 'Win81.x64'
    ConvertTo-NormalizedOSVersion 'Windows 8 64-bit' | should be 'Win8.x64'
    ConvertTo-NormalizedOSVersion 'Windows 10 64-bit, version 1703' | should be 'Win10.x64.1703'
    ConvertTo-NormalizedOSVersion 'Windows 10 64-bit, version 1607' | should be 'Win10.x64.1607'
    ConvertTo-NormalizedOSVersion 'Windows 7 32-bit' | should be 'Win7.x86'
    ConvertTo-NormalizedOSVersion 'Windows 8 32-bit' | should be 'Win8.x86'
    ConvertTo-NormalizedOSVersion 'Windows 8.1 32-bit' | should be 'Win81.x86'

}

describe 'basic Dell tests' {

    ConvertTo-NormalizedOSVersion 'Windows7.x64' | should be 'Win7.x64'
    ConvertTo-NormalizedOSVersion 'winpe10x.x86' | should be 'Win10.x86'
    ConvertTo-NormalizedOSVersion 'winpe10x.x64' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'Windows10.x64' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'Windows7.x86' | should be 'Win7.x86'
    ConvertTo-NormalizedOSVersion 'Windows8.1.x64' | should be 'Win81.x64'
    ConvertTo-NormalizedOSVersion 'Windows10.x86' | should be 'Win10.x86'
    ConvertTo-NormalizedOSVersion 'Windows8.x64' | should be 'Win8.x64'
    ConvertTo-NormalizedOSVersion 'Windows8.x86' | should be 'Win8.x86'
    ConvertTo-NormalizedOSVersion 'Windows8.1.x86' | should be 'Win81.x86'

}


describe 'basic Lenovo tests' {

    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/thinkcentre_drivers/tc_m600_w1064_201609.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/thinkcentre_drivers/tc_m900_m800_m700_m900x_w732_201511.exe' | should be 'Win7.x86'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/thinkcentre_drivers/tc_m900_m800_m700_m900x_w8164_201511.exe' | should be 'win81.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/thinkcentre_drivers/m7_m8_w864_20161012.exe' | should be 'win8.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/thinkcentre_drivers/sccm_m700z_m800z_w1064_20160114.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/thinkcentre_drivers/sccm_m700z_m800z_w764_20160114.exe' | should be 'Win7.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/thinkcentre_drivers/sccm_m700z_m800z_w732_20160114.exe' | should be 'Win7.x86'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/thinkcentre_drivers/tc_m910-m910q-m710q-m710-m910x_w1064_201612.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/thinkcentre_drivers/tc_m910-m910q-m710q-m710-m910x_w732_201702.exe' | should be 'Win7.x86'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/thinkcentre_drivers/tc-m910-m910q-m710q-m710-m910x_w764_201702.exe' | should be 'Win7.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/thinkcentre_drivers/tc_m910-m910q-m710q-m710_m910x_w8164_201704.exe' | should be 'Win81.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/thinkcentre_drivers/tc_m900_m800_m700_m900x_w764_201511.exe' | should be 'Win7.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/thinkcentre_drivers/tc_m900-m800-m700-m900x_w1064_201610.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/thinkcentre_drivers/tc_m900z_w8164_201603.exe' | should be 'win81.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/thinkcentre_drivers/tc_m73p_m83_m93_m93p_w1064_201508.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/thinkcentre_drivers/tc_x1_w7_32_20160224.exe' | should be 'Win7.x86'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/thinkcentre_drivers/tc_x1_w7_64_20160224.exe' | should be 'Win7.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_thinkpad10_mt20e3-20e4_w1064_201706.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_thinkpad11e-yoga11e_wb64_201602.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_thinkpad11e-yoga11e_w1064_201706.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_11e_3rd_gen_w764_201604.exe' | should be 'Win7.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_11e_3rd_gen_w1064_201707.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_11e_3rd_gen_wb64_201604.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_11e_4th_gen_w1064_201708.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_13_w1064_201707.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_13_wb64_201608.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_13_w764_201608.exe' | should be 'Win7.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_13_w732_201608.exe' | should be 'Win7.x86'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_13_2nd_gen_w1064_201708.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_e470_e570_e470c_e570c_w1064_201708.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_e470_e570_e470c_e570c_w732_201707.exe' | should be 'Win7.x86'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_e470_e570_e470c_e570c_w764_201708.exe' | should be 'Win7.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_e475_e575_w1064_201708.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_l450_w732_20160211.exe' | should be 'Win7.x86'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_l450_w764_20160211.exe' | should be 'Win7.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_l450_w1064_201705.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_l450_wb64_20160211.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_l460_w1064_201705.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_l460_w732_201601.exe' | should be 'Win7.x86'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_l460_w764_201601.exe' | should be 'Win7.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_l470_w1064_201708.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_l470_skl_wb64_201704.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_l470_w764_201707.exe' | should be 'Win7.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_l470_w732_201707.exe' | should be 'Win7.x86'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_l560_w764_201608.exe' | should be 'Win7.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_l560_w1064_201705.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_l560_wb64_201603.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_l560_w732_201608.exe' | should be 'Win7.x86'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_l570_w1064_201708.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_l570_w764_201708.exe' | should be 'Win7.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_l570_w732_201707.exe' | should be 'Win7.x86'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_l570_mt20jq-20jr_wb64_201704.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_s3_yoga14_yoga460_yogap40_w764_20160119.exe' | should be 'Win7.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_s3_yoga14_yoga460_yogap40_wb64_20160119.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_s3-yoga14-yoga460-yogap40_w1064_201704.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_p50-p70_wb64_201604.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_p50-p70_w1064_201705.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_t560-p50s_w1064_201705.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_p51_p71_w1064_201707.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_t570-p51s_w1064_201708.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_t570-p51s_w732_201707.exe' | should be 'Win7.x86'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_t570-p51s_w764_201708.exe' | should be 'Win7.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_t570-p51s_mt20jw-20jx-20jy-20k0_wb64_201704.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_p50-p70_w764_201608.exe' | should be 'Win7.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles/tp_t440-t440s_w732_201502.exe' | should be 'Win7.x86'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles/tp_t440-t440s_w764_201502.exe' | should be 'Win7.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles/tp_t440-t440s_wb64_201502.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_t440p_wb64_201602.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_t440p_w1064_201706.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_t440-t440s_w1064_201611.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_t450_t450s_w1064_201705.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_t460_wb64_201603.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_t460_w1064_201706.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_t460p_w764_201603.exe' | should be 'Win7.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_t460p_w732_201603.exe' | should be 'Win7.x86'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_t460s_w1064_201704.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_t470_w1064_201708.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_t470_w732_201707.exe' | should be 'Win7.x86'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_t470_mt20jm-20jn_wb64_201704.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_t470p_w1064_201707.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_t470s_w1064_201707.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_t470s_mt20js-20jt_wb64_201704.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_t470s_w764_201707.exe' | should be 'Win7.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_t470s_w732_201707.exe' | should be 'Win7.x86'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles/tp_t540p-w54x_w732_201502.exe' | should be 'Win7.x86'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles/tp_t540p-w54x_w764_201502.exe' | should be 'Win7.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles/tp_t540p-w54x_wb64_201502.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_t540p-w54x_w1064_201706.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_t550-w550s_w1064_201706.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles/tp_x1carbon_mt20a7-20a8_w764_201502.exe' | should be 'Win7.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles/tp_x1carbon_mt20a7-20a8_w732_201502.exe' | should be 'Win7.x86'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles/tp_x1carbon_mt20a7-20a8_wb64_201502.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_x1carbon_mt20bs-20bt_w1064_201706.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_x1carbon_mt20fb-20fc-x1yoga_mt20fq-20fr_wb64_201601.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_x1carbon_mt20fb-20fc-x1yoga_mt20fq-20fr_w732_201608.exe' | should be 'Win7.x86'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_x1carbon_mt20fb-20fc-x1yoga_mt20fq-20fr_w764_201608.exe' | should be 'Win7.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_x1carbon_mt20fb-20fc-x1yoga_mt20fq-20fr_w1064_201705.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_x1carbon_mt20hq-20hr-20k3-20k4_w1064_201708.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_x1carbon_mt20k3-20k4_w1064_201702.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_x1carbon_mt20k3-20k4_wb64_201703.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_x1carbon_mt20k3-20k4_w764_201708.exe' | should be 'Win7.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_x1carbon_mt20k3-20k4_w732_201707.exe' | should be 'Win7.x86'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_x1tablet_gen2_w1064_201708.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_x1yoga_mt20jd-20je-20jf-20jg_w1064_201708.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles/tp_x131e_wb64_201402.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles/tp_x131e_wb32_201402.exe' | should be 'Win10.x86'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles/tp_x140e_wb64_201405.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles/tp_x140e_w732_201405.exe' | should be 'Win7.x86'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles/tp_x140e_w764_201405.exe' | should be 'Win7.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles/tp_x240-x240s_w732_201502.exe' | should be 'Win7.x86'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles/tp_x240-x240s_w764_201502.exe' | should be 'Win7.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles/tp_x240-x240s_wb64_201502.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_x240-x240s_w1064_201611.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_x250_w1064_201706.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_x260_w732_201601.exe' | should be 'Win7.x86'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_x260_w764_201601.exe' | should be 'Win7.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_x260_w1064_201706.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_x270_w1064_201708.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_x270_skl_wb64_201706.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_11e_yoga11e_w1064_201611.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_11e_yoga11e_wb64_201603.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_thinkpad11e_w764_201602.exe' | should be 'Win7.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_thinkpad11e_w732_201602.exe' | should be 'Win7.x86'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_yoga_11e_3rd_gen_wb64_201604.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_yoga_11e_3rd_gen_w1064_201704.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_yoga_11e_4th_gen_w1064_201708.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_s1_yoga_12_w1064_201705.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_s3_yoga_14_w764_201602.exe' | should be 'Win7.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_s5yoga15_w1064_201706.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_yoga260_wb64_201605.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_yoga260_w1064_201705.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/mobiles/tp_s1-yoga_370_w1064_201708.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/ibmdl/pub/pc/pccbbs/thinkcentre_drivers/tc_p300_w732_201504.exe' | should be 'Win7.x86'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/ibmdl/pub/pc/pccbbs/thinkcentre_drivers/tc_p300_w764_201504.exe' | should be 'Win7.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/ibmdl/pub/pc/pccbbs/thinkcentre_drivers/tc_p300_w8164_201504.exe' | should be 'win81.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/thinkcentre_drivers/ts_p310_w1064_201510.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/thinkcentre_drivers/ts_p310_w764_201510.exe' | should be 'Win7.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/thinkcentre_drivers/ts_p320_w1064_201703.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/thinkcentre_drivers/ts_p320_w764_201703.exe' | should be 'Win7.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/thinkcentre_drivers/ts_p410p510p710p910_w1064_201706.exe' | should be 'Win10.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/thinkcentre_drivers/ts_p410p510p710p910_w764_201706.exe' | should be 'Win7.x64'
    ConvertTo-NormalizedOSVersion 'https://download.lenovo.com/pccbbs/thinkcentre_drivers/ts_p500p700p900_w1064_201510.exe' | should be 'Win10.x64'

}

<#
@"
Windows 7 64-bit
Windows 8.1 64-bit
Windows 8 64-bit
Windows 10 64-bit, version 1703
Windows 10 64-bit, version 1607
Windows 7 32-bit
Windows 8 32-bit
Windows 8.1 32-bit
Windows7.x64
winpe10x.x86
winpe10x.x64
Windows10.x64
Windows7.x86
Windows8.1.x64
Windows10.x86
Windows8.x64
Windows8.x86
Windows8.1.x86
https://download.lenovo.com/pccbbs/thinkcentre_drivers/tc_m600_w1064_201609.exe
https://download.lenovo.com/pccbbs/thinkcentre_drivers/tc_m900_m800_m700_m900x_w732_201511.exe
https://download.lenovo.com/pccbbs/thinkcentre_drivers/tc_m900_m800_m700_m900x_w8164_201511.exe
https://download.lenovo.com/pccbbs/thinkcentre_drivers/m7_m8_w864_20161012.exe
https://download.lenovo.com/pccbbs/thinkcentre_drivers/sccm_m700z_m800z_w1064_20160114.exe
https://download.lenovo.com/pccbbs/thinkcentre_drivers/sccm_m700z_m800z_w764_20160114.exe
https://download.lenovo.com/pccbbs/thinkcentre_drivers/sccm_m700z_m800z_w732_20160114.exe
https://download.lenovo.com/pccbbs/thinkcentre_drivers/tc_m910-m910q-m710q-m710-m910x_w1064_201612.exe
https://download.lenovo.com/pccbbs/thinkcentre_drivers/tc_m910-m910q-m710q-m710-m910x_w732_201702.exe
https://download.lenovo.com/pccbbs/thinkcentre_drivers/tc-m910-m910q-m710q-m710-m910x_w764_201702.exe
https://download.lenovo.com/pccbbs/thinkcentre_drivers/tc_m910-m910q-m710q-m710_m910x_w8164_201704.exe
https://download.lenovo.com/pccbbs/thinkcentre_drivers/tc_m900_m800_m700_m900x_w764_201511.exe
https://download.lenovo.com/pccbbs/thinkcentre_drivers/tc_m900-m800-m700-m900x_w1064_201610.exe
https://download.lenovo.com/pccbbs/thinkcentre_drivers/tc_m900z_w8164_201603.exe
https://download.lenovo.com/pccbbs/thinkcentre_drivers/tc_m73p_m83_m93_m93p_w1064_201508.exe
https://download.lenovo.com/pccbbs/thinkcentre_drivers/tc_x1_w7_32_20160224.exe
https://download.lenovo.com/pccbbs/thinkcentre_drivers/tc_x1_w7_64_20160224.exe
https://download.lenovo.com/pccbbs/mobiles/tp_thinkpad10_mt20e3-20e4_w1064_201706.exe
https://download.lenovo.com/pccbbs/mobiles/tp_thinkpad11e-yoga11e_wb64_201602.exe
https://download.lenovo.com/pccbbs/mobiles/tp_thinkpad11e-yoga11e_w1064_201706.exe
https://download.lenovo.com/pccbbs/mobiles/tp_11e_3rd_gen_w764_201604.exe
https://download.lenovo.com/pccbbs/mobiles/tp_11e_3rd_gen_w1064_201707.exe
https://download.lenovo.com/pccbbs/mobiles/tp_11e_3rd_gen_wb64_201604.exe
https://download.lenovo.com/pccbbs/mobiles/tp_11e_4th_gen_w1064_201708.exe
https://download.lenovo.com/pccbbs/mobiles/tp_13_w1064_201707.exe
https://download.lenovo.com/pccbbs/mobiles/tp_13_wb64_201608.exe
https://download.lenovo.com/pccbbs/mobiles/tp_13_w764_201608.exe
https://download.lenovo.com/pccbbs/mobiles/tp_13_w732_201608.exe
https://download.lenovo.com/pccbbs/mobiles/tp_13_2nd_gen_w1064_201708.exe
https://download.lenovo.com/pccbbs/mobiles/tp_e470_e570_e470c_e570c_w1064_201708.exe
https://download.lenovo.com/pccbbs/mobiles/tp_e470_e570_e470c_e570c_w732_201707.exe
https://download.lenovo.com/pccbbs/mobiles/tp_e470_e570_e470c_e570c_w764_201708.exe
https://download.lenovo.com/pccbbs/mobiles/tp_e475_e575_w1064_201708.exe
https://download.lenovo.com/pccbbs/mobiles/tp_l450_w732_20160211.exe
https://download.lenovo.com/pccbbs/mobiles/tp_l450_w764_20160211.exe
https://download.lenovo.com/pccbbs/mobiles/tp_l450_w1064_201705.exe
https://download.lenovo.com/pccbbs/mobiles/tp_l450_wb64_20160211.exe
https://download.lenovo.com/pccbbs/mobiles/tp_l460_w1064_201705.exe
https://download.lenovo.com/pccbbs/mobiles/tp_l460_w732_201601.exe
https://download.lenovo.com/pccbbs/mobiles/tp_l460_w764_201601.exe
https://download.lenovo.com/pccbbs/mobiles/tp_l470_w1064_201708.exe
https://download.lenovo.com/pccbbs/mobiles/tp_l470_skl_wb64_201704.exe
https://download.lenovo.com/pccbbs/mobiles/tp_l470_w764_201707.exe
https://download.lenovo.com/pccbbs/mobiles/tp_l470_w732_201707.exe
https://download.lenovo.com/pccbbs/mobiles/tp_l560_w764_201608.exe
https://download.lenovo.com/pccbbs/mobiles/tp_l560_w1064_201705.exe
https://download.lenovo.com/pccbbs/mobiles/tp_l560_wb64_201603.exe
https://download.lenovo.com/pccbbs/mobiles/tp_l560_w732_201608.exe
https://download.lenovo.com/pccbbs/mobiles/tp_l570_w1064_201708.exe
https://download.lenovo.com/pccbbs/mobiles/tp_l570_w764_201708.exe
https://download.lenovo.com/pccbbs/mobiles/tp_l570_w732_201707.exe
https://download.lenovo.com/pccbbs/mobiles/tp_l570_mt20jq-20jr_wb64_201704.exe
https://download.lenovo.com/pccbbs/mobiles/tp_s3_yoga14_yoga460_yogap40_w764_20160119.exe
https://download.lenovo.com/pccbbs/mobiles/tp_s3_yoga14_yoga460_yogap40_wb64_20160119.exe
https://download.lenovo.com/pccbbs/mobiles/tp_s3-yoga14-yoga460-yogap40_w1064_201704.exe
https://download.lenovo.com/pccbbs/mobiles/tp_p50-p70_wb64_201604.exe
https://download.lenovo.com/pccbbs/mobiles/tp_p50-p70_w1064_201705.exe
https://download.lenovo.com/pccbbs/mobiles/tp_t560-p50s_w1064_201705.exe
https://download.lenovo.com/pccbbs/mobiles/tp_p51_p71_w1064_201707.exe
https://download.lenovo.com/pccbbs/mobiles/tp_t570-p51s_w1064_201708.exe
https://download.lenovo.com/pccbbs/mobiles/tp_t570-p51s_w732_201707.exe
https://download.lenovo.com/pccbbs/mobiles/tp_t570-p51s_w764_201708.exe
https://download.lenovo.com/pccbbs/mobiles/tp_t570-p51s_mt20jw-20jx-20jy-20k0_wb64_201704.exe
https://download.lenovo.com/pccbbs/mobiles/tp_p50-p70_w764_201608.exe
https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles/tp_t440-t440s_w732_201502.exe
https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles/tp_t440-t440s_w764_201502.exe
https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles/tp_t440-t440s_wb64_201502.exe
https://download.lenovo.com/pccbbs/mobiles/tp_t440p_wb64_201602.exe
https://download.lenovo.com/pccbbs/mobiles/tp_t440p_w1064_201706.exe
https://download.lenovo.com/pccbbs/mobiles/tp_t440-t440s_w1064_201611.exe
https://download.lenovo.com/pccbbs/mobiles/tp_t450_t450s_w1064_201705.exe
https://download.lenovo.com/pccbbs/mobiles/tp_t460_wb64_201603.exe
https://download.lenovo.com/pccbbs/mobiles/tp_t460_w1064_201706.exe
https://download.lenovo.com/pccbbs/mobiles/tp_t460p_w764_201603.exe
https://download.lenovo.com/pccbbs/mobiles/tp_t460p_w732_201603.exe
https://download.lenovo.com/pccbbs/mobiles/tp_t460s_w1064_201704.exe
https://download.lenovo.com/pccbbs/mobiles/tp_t470_w1064_201708.exe
https://download.lenovo.com/pccbbs/mobiles/tp_t470_w732_201707.exe
https://download.lenovo.com/pccbbs/mobiles/tp_t470_mt20jm-20jn_wb64_201704.exe
https://download.lenovo.com/pccbbs/mobiles/tp_t470p_w1064_201707.exe
https://download.lenovo.com/pccbbs/mobiles/tp_t470s_w1064_201707.exe
https://download.lenovo.com/pccbbs/mobiles/tp_t470s_mt20js-20jt_wb64_201704.exe
https://download.lenovo.com/pccbbs/mobiles/tp_t470s_w764_201707.exe
https://download.lenovo.com/pccbbs/mobiles/tp_t470s_w732_201707.exe
https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles/tp_t540p-w54x_w732_201502.exe
https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles/tp_t540p-w54x_w764_201502.exe
https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles/tp_t540p-w54x_wb64_201502.exe
https://download.lenovo.com/pccbbs/mobiles/tp_t540p-w54x_w1064_201706.exe
https://download.lenovo.com/pccbbs/mobiles/tp_t550-w550s_w1064_201706.exe
https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles/tp_x1carbon_mt20a7-20a8_w764_201502.exe
https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles/tp_x1carbon_mt20a7-20a8_w732_201502.exe
https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles/tp_x1carbon_mt20a7-20a8_wb64_201502.exe
https://download.lenovo.com/pccbbs/mobiles/tp_x1carbon_mt20bs-20bt_w1064_201706.exe
https://download.lenovo.com/pccbbs/mobiles/tp_x1carbon_mt20fb-20fc-x1yoga_mt20fq-20fr_wb64_201601.exe
https://download.lenovo.com/pccbbs/mobiles/tp_x1carbon_mt20fb-20fc-x1yoga_mt20fq-20fr_w732_201608.exe
https://download.lenovo.com/pccbbs/mobiles/tp_x1carbon_mt20fb-20fc-x1yoga_mt20fq-20fr_w764_201608.exe
https://download.lenovo.com/pccbbs/mobiles/tp_x1carbon_mt20fb-20fc-x1yoga_mt20fq-20fr_w1064_201705.exe
https://download.lenovo.com/pccbbs/mobiles/tp_x1carbon_mt20hq-20hr-20k3-20k4_w1064_201708.exe
https://download.lenovo.com/pccbbs/mobiles/tp_x1carbon_mt20k3-20k4_w1064_201702.exe
https://download.lenovo.com/pccbbs/mobiles/tp_x1carbon_mt20k3-20k4_wb64_201703.exe
https://download.lenovo.com/pccbbs/mobiles/tp_x1carbon_mt20k3-20k4_w764_201708.exe
https://download.lenovo.com/pccbbs/mobiles/tp_x1carbon_mt20k3-20k4_w732_201707.exe
https://download.lenovo.com/pccbbs/mobiles/tp_x1tablet_gen2_w1064_201708.exe
https://download.lenovo.com/pccbbs/mobiles/tp_x1yoga_mt20jd-20je-20jf-20jg_w1064_201708.exe
https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles/tp_x131e_wb64_201402.exe
https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles/tp_x131e_wb32_201402.exe
https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles/tp_x140e_wb64_201405.exe
https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles/tp_x140e_w732_201405.exe
https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles/tp_x140e_w764_201405.exe
https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles/tp_x240-x240s_w732_201502.exe
https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles/tp_x240-x240s_w764_201502.exe
https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles/tp_x240-x240s_wb64_201502.exe
https://download.lenovo.com/pccbbs/mobiles/tp_x240-x240s_w1064_201611.exe
https://download.lenovo.com/pccbbs/mobiles/tp_x250_w1064_201706.exe
https://download.lenovo.com/pccbbs/mobiles/tp_x260_w732_201601.exe
https://download.lenovo.com/pccbbs/mobiles/tp_x260_w764_201601.exe
https://download.lenovo.com/pccbbs/mobiles/tp_x260_w1064_201706.exe
https://download.lenovo.com/pccbbs/mobiles/tp_x270_w1064_201708.exe
https://download.lenovo.com/pccbbs/mobiles/tp_x270_skl_wb64_201706.exe
https://download.lenovo.com/pccbbs/mobiles/tp_11e_yoga11e_w1064_201611.exe
https://download.lenovo.com/pccbbs/mobiles/tp_11e_yoga11e_wb64_201603.exe
https://download.lenovo.com/pccbbs/mobiles/tp_thinkpad11e_w764_201602.exe
https://download.lenovo.com/pccbbs/mobiles/tp_thinkpad11e_w732_201602.exe
https://download.lenovo.com/pccbbs/mobiles/tp_yoga_11e_3rd_gen_wb64_201604.exe
https://download.lenovo.com/pccbbs/mobiles/tp_yoga_11e_3rd_gen_w1064_201704.exe
https://download.lenovo.com/pccbbs/mobiles/tp_yoga_11e_4th_gen_w1064_201708.exe
https://download.lenovo.com/pccbbs/mobiles/tp_s1_yoga_12_w1064_201705.exe
https://download.lenovo.com/pccbbs/mobiles/tp_s3_yoga_14_w764_201602.exe
https://download.lenovo.com/pccbbs/mobiles/tp_s5yoga15_w1064_201706.exe
https://download.lenovo.com/pccbbs/mobiles/tp_yoga260_wb64_201605.exe
https://download.lenovo.com/pccbbs/mobiles/tp_yoga260_w1064_201705.exe
https://download.lenovo.com/pccbbs/mobiles/tp_s1-yoga_370_w1064_201708.exe
https://download.lenovo.com/ibmdl/pub/pc/pccbbs/thinkcentre_drivers/tc_p300_w732_201504.exe
https://download.lenovo.com/ibmdl/pub/pc/pccbbs/thinkcentre_drivers/tc_p300_w764_201504.exe
https://download.lenovo.com/ibmdl/pub/pc/pccbbs/thinkcentre_drivers/tc_p300_w8164_201504.exe
https://download.lenovo.com/pccbbs/thinkcentre_drivers/ts_p310_w1064_201510.exe
https://download.lenovo.com/pccbbs/thinkcentre_drivers/ts_p310_w764_201510.exe
https://download.lenovo.com/pccbbs/thinkcentre_drivers/ts_p320_w1064_201703.exe
https://download.lenovo.com/pccbbs/thinkcentre_drivers/ts_p320_w764_201703.exe
https://download.lenovo.com/pccbbs/thinkcentre_drivers/ts_p410p510p710p910_w1064_201706.exe
https://download.lenovo.com/pccbbs/thinkcentre_drivers/ts_p410p510p710p910_w764_201706.exe
https://download.lenovo.com/pccbbs/thinkcentre_drivers/ts_p500p700p900_w1064_201510.exe
"@  -split "`r`n" | % { "ConvertTo-NormalizedOSVersion '$_' | should be 'Win10.x86'" } 

#>