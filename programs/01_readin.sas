/* readin dutystation file */
%let dataloc=../data;

data dsfl;
infile "&dataloc./dsfls.txt" missover lrecl=59;
length
  higeo $ 2
  city $ 4
  county $ 3
  lpa $ 2
  cbsa $ 5
  csa $ 3
  duty_station_name $ 40
  ;
input
  higeo $ 1-2
  city $ 3-6
  county $ 7-9
  lpa $ 10-11
  cbsa $ 12-16
  csa $ 17-19
  duty_station_name $ 20-59
;
if higeo > "99" then foreign = 1; else foreign = 0;
if foreign=1 then do;
  city="";
  county="";
end;
else do;
  state=higeo;
  state_postal=fipstate(put(state,2.));
end;
drop higeo;

label
  state="State name"
  city="City"
  county="County (FIPS)"
  lpa="Locality Pay Area (LPA)"
  cbsa="Core Based Statistical Area (CBSA) (or blank if the duty station is not in a CBSA)."
  csa="Combined Statistical Area (CSA) (or blank if the duty station is not in a CSA)."
  duty_station_name="Duty Station Name"
  ;
run;
