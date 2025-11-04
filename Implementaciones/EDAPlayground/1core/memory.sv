`timescale 1ns / 1ps

module EightPortArray(
    output [7:0] DataBus0,
    output [7:0] DataBus1,
    output [7:0] DataBus2,
    output [7:0] DataBus3,
    output [7:0] DataBus4,
    output [7:0] DataBus5,
    output [7:0] DataBus6,
    output [7:0] DataBus7,
    input [7:0] AddressBus0,
    input [7:0] AddressBus1,
    input [7:0] AddressBus2,
    input [7:0] AddressBus3,
    input [7:0] AddressBus4,
    input [7:0] AddressBus5,
    input [7:0] AddressBus6,
    input [7:0] AddressBus7,
    input reset
    );

  reg [7:0] Data[255:0];

  assign DataBus0=Data[AddressBus0];
  assign DataBus1=Data[AddressBus1];
  assign DataBus2=Data[AddressBus2];
  assign DataBus3=Data[AddressBus3];
  assign DataBus4=Data[AddressBus4];
  assign DataBus5=Data[AddressBus5];
  assign DataBus6=Data[AddressBus6];
  assign DataBus7=Data[AddressBus7];	 
	 
 
  always @ reset
  if (reset==0)
    begin
      // Col 1 (0-63)      Col 2 (64-127)    Col 3 (128-191)   Col 4 (192-255)
    Data[  0]=  0;    Data[ 64]=  0;    Data[128]=  0;    Data[192]=  0;
    Data[  1]=  1;    Data[ 65]=  1;    Data[129]=  3;    Data[193]= 1;
    Data[  2]=  1;    Data[ 66]=  1;    Data[130]=1;    Data[194]=  1;
    Data[  3]= 90;    Data[ 67]=114;    Data[131]= 184;    Data[195]=  126;
    Data[  4]= 78;    Data[ 68]=  1;    Data[132]=  1;    Data[196]=  1;
    Data[  5]=  1;    Data[ 69]=  1;    Data[133]=238;    Data[197]=  1;
    Data[  6]=  13;    Data[ 70]= 1;    Data[134]=  1;    Data[198]=  1;
    Data[  7]=  1;    Data[ 71]=  1;    Data[135]=  1;    Data[199]=  1;
    Data[  8]=  1;    Data[ 72]= 92;    Data[136]=140;    Data[200]=  1;
    Data[  9]=112;    Data[ 73]=  1;    Data[137]=  1;    Data[201]=  1;
    Data[ 10]=  1;    Data[ 74]= 86;    Data[138]=  1;    Data[202]=  1;
    Data[ 11]= 48;    Data[ 75]=  1;    Data[139]= 72;    Data[203]= 76;
    Data[ 12]=  1;    Data[ 76]=  1;    Data[140]=  1;    Data[204]=  1;
    Data[ 13]=  1;    Data[ 77]=234;    Data[141]=  1;    Data[205]=  1;
    Data[ 14]=  1;    Data[ 78]= 96;    Data[142]= 12;    Data[206]=  1;
    Data[ 15]= 40;    Data[ 79]=  1;    Data[143]=  1;    Data[207]=  1;
    Data[ 16]= 66;    Data[ 80]=  1;    Data[144]= 46;    Data[208]=  1;
    Data[ 17]=  1;    Data[ 81]=  1;    Data[145]=  1;    Data[209]=  1;
    Data[ 18]=  1;    Data[ 82]=  1;    Data[146]=252;    Data[210]=  1;
    Data[ 19]= 16;    Data[ 83]=  1;    Data[147]=  1;    Data[211]= 56;
    Data[ 20]=180;    Data[ 84]=  1;    Data[148]=  1;    Data[212]=  1;
    Data[ 21]=  1;    Data[ 85]=108;    Data[149]=  1;    Data[213]=  1;
    Data[ 22]=  1;    Data[ 86]=222;    Data[150]=148;    Data[214]=  1;
    Data[ 23]=  1;    Data[ 87]=  1;    Data[151]=  1;    Data[215]= 22;
    Data[ 24]=  1;    Data[ 88]=176;    Data[152]=136;    Data[216]= 50;
    Data[ 25]=120;    Data[ 89]=  1;    Data[153]=220;    Data[217]=  1;
    Data[ 26]=  1;    Data[ 90]=  1;    Data[154]=  1;    Data[218]=  1;
    Data[ 27]=  1;    Data[ 91]= 14;    Data[155]=  1;    Data[219]=  1;
    Data[ 28]=164;    Data[ 92]=  1;    Data[156]=  1;    Data[220]= 54;
    Data[ 29]=196;    Data[ 93]=200;    Data[157]= 10;    Data[221]=  1;
    Data[ 30]=  1;    Data[ 94]=  1;    Data[158]=  1;    Data[222]=168;
    Data[ 31]=  1;    Data[ 95]=  1;    Data[159]= 60;    Data[223]=  1;
    Data[ 32]=142;    Data[ 96]= 44;    Data[160]=  1;    Data[224]=228;
    Data[ 33]=102;    Data[ 97]= 58;    Data[161]=  1;    Data[225]=  1;
    Data[ 34]=  1;    Data[ 98]=  1;    Data[162]=190;    Data[226]=  1;
    Data[ 35]=  1;    Data[ 99]=  1;    Data[163]=214;    Data[227]=  1;
    Data[ 36]=  1;    Data[100]= 32;    Data[164]= 28;    Data[228]=  1;
    Data[ 37]= 70;    Data[101]=146;    Data[165]=  1;    Data[229]=172;
    Data[ 38]=  1;    Data[102]=  1;    Data[166]=  1;    Data[230]=130;
    Data[ 39]=  1;    Data[103]=128;    Data[167]=  1;    Data[231]=  1;
    Data[ 40]=  1;    Data[104]=  1;    Data[168]=  212;    Data[232]=  1;
    Data[ 41]=  1;    Data[105]=160;    Data[169]=  1;    Data[233]=  1;
    Data[ 42]=152;    Data[106]=  1;    Data[170]=  1;    Data[234]=  1;
    Data[ 43]=  1;    Data[107]=242;    Data[171]=  1;    Data[235]=226;
    Data[ 44]= 62;    Data[108]=246;    Data[172]=  1;    Data[236]=  1;
    Data[ 45]=110;    Data[109]=138;    Data[173]=188;    Data[237]=  1;
    Data[ 46]=  1;    Data[110]=  1;    Data[174]= 68;    Data[238]=  1;
    Data[ 47]=  1;    Data[111]=230;    Data[175]=  1;    Data[239]=192;
    Data[ 48]=  1;    Data[112]= 24;    Data[176]=  1;    Data[240]=  1;
    Data[ 49]=  1;    Data[113]= 84;    Data[177]=122;    Data[241]=166;
    Data[ 50]=170;    Data[114]=  210;  Data[178]=186;    Data[242]=  1;
    Data[ 51]=  1;    Data[115]=224;    Data[179]=  1;    Data[243]=  1;
    Data[ 52]=254;    Data[116]= 74;    Data[180]=  240;    Data[244]=  8;
    Data[ 53]=  1;    Data[117]=  1;    Data[181]=  1;    Data[245]=248;
    Data[ 54]=134;    Data[118]=  1;    Data[182]=  1;    Data[246]=  4;
    Data[ 55]=100;    Data[119]=  77;   Data[183]=  1;    Data[247]=  2;
    Data[ 56]=  1;    Data[120]=  1;    Data[184]=  1;    Data[248]=  1;
    Data[ 57]=  1;    Data[121]=  1;    Data[185]=158;    Data[249]=  1;
    Data[ 58]=178;    Data[122]=  1;    Data[186]=156;    Data[250]=204;
    Data[ 59]=202;    Data[123]=  198;  Data[187]= 1;    Data[251]=150;
    Data[ 60]=126;    Data[124]= 52;    Data[188]=  1;    Data[252]=  1;
    Data[ 61]=1;      Data[125]=1;      Data[189]=1;    Data[253]=  1;
    Data[ 62]=  1;    Data[126]=  1;    Data[190]=1;    Data[254]=  1;
    Data[ 63]=  0;    Data[127]=0;      Data[191]=  0;    Data[255]=0;
          // 24               27                      23              19
    // total_num_pares = 95

    end
endmodule
