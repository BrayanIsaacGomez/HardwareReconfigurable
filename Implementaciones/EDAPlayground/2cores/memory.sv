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
      Data[  0]=10;    
      Data[  1]=1;
      Data[  2]=2;    
      Data[  3]=3;
      Data[  4]=4;    
      Data[  5]=5;
      Data[  6]=1;    
      Data[  7]=1;
      Data[  8]=1;    
      Data[  9]=9;
      Data[ 10]=1;    
      Data[ 11]=1;
      Data[ 12]=1;    
      Data[ 13]=3;
      Data[ 14]=1;    
      Data[ 15]=1;
      Data[ 16]=1;    
      Data[ 17]=7;
      Data[ 18]=6;    
      Data[ 19]=1;
      Data[ 20]=1;    
      Data[ 21]=1;
      Data[ 22]=1;    
      Data[ 23]=1;
      Data[ 24]=1;    
      Data[ 25]=9;
      Data[ 26]=1;    
      Data[ 27]=1;
      Data[ 28]=1;    
      Data[ 29]=8;
      Data[ 30]=1;    
      Data[ 31]=1;
      Data[ 32]=1;    
      Data[ 33]=1;
      Data[ 34]=1;    
      Data[ 35]=1;
      Data[ 36]=1;    
      Data[ 37]=1;
      Data[ 38]=1;    
      Data[ 39]=1;
      Data[ 40]=1;    
      Data[ 41]=26;
      Data[ 42]=1;    
      Data[ 43]=1;
      Data[ 44]=1;    
      Data[ 45]=1;
      Data[ 46]=1;    
      Data[ 47]=3;
      Data[ 48]=1;    
      Data[ 49]=4;
      Data[ 50]=1;      
      Data[ 51]=1;
      Data[ 52]=0;    
      Data[ 53]=0;
      Data[ 54]=0;    
      Data[ 55]=5;
      Data[ 56]=0;    
      Data[ 57]=0;
      Data[ 58]=0;    
      Data[ 59]=0;
      Data[ 60]=0;     
      Data[ 61]=0;
      Data[ 62]=0;    
      Data[ 63]=0;
      Data[ 64]=0;    
      Data[ 65]=0;
      Data[ 66]=0;    
      Data[ 67]=0;
      Data[ 68]=0;    
      Data[ 69]=0;
      Data[ 70]=0;     
      Data[ 71]=0;
      Data[ 72]=0;    
      Data[ 73]=0;
      Data[ 74]=0;    
      Data[ 75]=0;
      Data[ 76]=0;    
      Data[ 77]=0;
      Data[ 78]=0;    
      Data[ 79]=0;
      Data[ 80]=0;     
      Data[ 81]=0;
      Data[ 82]=0;    
      Data[ 83]=0;
      Data[ 84]=0;    
      Data[ 85]=0;
      Data[ 86]=0;    
      Data[ 87]=0;
      Data[ 88]=0;    
      Data[ 89]=0;
      Data[ 90]=0;     
      Data[ 91]=0;
      Data[ 92]=0;    
      Data[ 93]=0;
      Data[ 94]=0;    
      Data[ 95]=0;
      Data[ 96]=0;    
      Data[ 97]=0;
      Data[ 98]=0;    
      Data[ 99]=0;
      Data[100]=0;    
      Data[101]=0;
      Data[102]=0;    
      Data[103]=0;
      Data[104]=0;    
      Data[105]=0;
      Data[106]=0;    
      Data[107]=0;
      Data[108]=0;    
      Data[109]=0;
      Data[110]=0;    
      Data[111]=0;
      Data[112]=0;    
      Data[113]=0;
      Data[114]=0;    
      Data[115]=0;
      Data[116]=0;    
      Data[117]=0;
      Data[118]=1;    
      Data[119]=0;
      Data[120]=2;    
      Data[121]=0;
      Data[122]=3;    
      Data[123]=0;
      Data[124]=0;    
      Data[125]=0;
      Data[126]=0;    
      Data[127]=0;
      Data[128]=0;    
      Data[129]=0;
      Data[130]=0;    
      Data[131]=0;
      Data[132]=0;    
      Data[133]=0;
      Data[134]=0;    
      Data[135]=0;
      Data[136]=0;    
      Data[137]=0;
      Data[138]=0;    
      Data[139]=0;
      Data[140]=0;    
      Data[141]=0;
      Data[142]=0;    
      Data[143]=0;
      Data[144]=0;    
      Data[145]=0;
      Data[146]=0;    
      Data[147]=0;
      Data[148]=0;    
      Data[149]=0;
      Data[150]=0;      
      Data[151]=0;
      Data[152]=0;    
      Data[153]=0;
      Data[154]=0;    
      Data[155]=0;
      Data[156]=0;    
      Data[157]=0;
      Data[158]=0;    
      Data[159]=0;
      Data[160]=0;     
      Data[161]=0;
      Data[162]=0;    
      Data[163]=0;
      Data[164]=0;    
      Data[165]=0;
      Data[166]=0;    
      Data[167]=0;
      Data[168]=0;    
      Data[169]=0;
      Data[170]=0;     
      Data[171]=0;
      Data[172]=0;    
      Data[173]=0;
      Data[174]=0;    
      Data[175]=0;
      Data[176]=0;    
      Data[177]=0;
      Data[178]=0;    
      Data[179]=0;
      Data[180]=0;     
      Data[181]=0;
      Data[182]=0;    
      Data[183]=0;
      Data[184]=0;    
      Data[185]=0;
      Data[186]=0;    
      Data[187]=0;
      Data[188]=0;    
      Data[189]=0;
      Data[190]=0;     
      Data[191]=0;
      Data[192]=0;    
      Data[193]=0;
      Data[194]=0;    
      Data[195]=0;
      Data[196]=0;    
      Data[197]=0;
      Data[198]=0;    
      Data[199]=0;
      Data[200]=0;
      Data[201]=0;
      Data[202]=0;    
      Data[203]=0;
      Data[204]=0;    
      Data[205]=0;
      Data[206]=0;    
      Data[207]=0;
      Data[208]=0;    
      Data[209]=0;
      Data[210]=0;    
      Data[211]=0;
      Data[212]=0;    
      Data[213]=0;
      Data[214]=0;    
      Data[215]=0;
      Data[216]=0;    
      Data[217]=0;
      Data[218]=0;    
      Data[219]=0;
      Data[220]=0;    
      Data[221]=0;
      Data[222]=0;    
      Data[223]=0;
      Data[224]=0;    
      Data[225]=0;
      Data[226]=0;    
      Data[227]=0;
      Data[228]=0;    
      Data[229]=0;
      Data[230]=0;    
      Data[231]=0;
      Data[232]=0;    
      Data[233]=0;
      Data[234]=0;    
      Data[235]=0;
      Data[236]=0;    
      Data[237]=5;
      Data[238]=0;    
      Data[239]=0;
      Data[240]=0;    
      Data[241]=4;
      Data[242]=0;    
      Data[243]=0;
      Data[244]=0;    
      Data[245]=0;
      Data[246]=22;    
      Data[247]=0;
      Data[248]=0;    
      Data[249]=98;
      Data[250]=121;      
      Data[251]=0;
      Data[252]=0;    
      Data[253]=0;
      Data[254]=2;    
      Data[255]=0;
    end
endmodule
