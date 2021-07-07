#!/usr/bin/bash
#Author: Nitin Kushwah
#Version 1.0
#Script is only meant to be run inside jbodlogs folder of wddcs logs.

i=0

if [[ `ls show_ses*` =~ "scsi" ]]; then
for x in `ls show_ses_* |awk -F'_' '{print $3"_"$4}'`
do
echo "WDDCS for windows"
sg[$i]=$x
i=$(( i+1))
done

else
for x in `ls show_ses_* |awk -F'_' '{print $3}'`
do
echo "WDDCS for Linux"
sg[$i]=$x
i=$(( i+1))
done

fi

#----------#
for ((j=0; j<i;j++))
do

cat sec1_err_cnts_0-60_read_"${sg[$j]}" > sec1_err_cnts_0-60_read_map_"${sg[$j]}"
cat sec2_err_cnts_0-60_read_"${sg[$j]}" > sec2_err_cnts_0-60_read_map_"${sg[$j]}"

cat sec1_phyinfo_buffer_"${sg[$j]}" > sec1_phyinfo_buffer_map_"${sg[$j]}"
cat sec2_phyinfo_buffer_"${sg[$j]}" > sec2_phyinfo_buffer_map_"${sg[$j]}"

cat sec1_phyinfo_"${sg[$j]}" > sec1_phyinfo_map_"${sg[$j]}"
cat sec2_phyinfo_"${sg[$j]}" > sec2_phyinfo_map_"${sg[$j]}"

cat sec1_show_phys_"${sg[$j]}" > sec1_show_phys_map_"${sg[$j]}"
cat sec2_show_phys_"${sg[$j]}" > sec2_show_phys_map_"${sg[$j]}"

done


#--------------------------------------------------------------------------------------
#--------------Data102-----------------------------------------------------------------

for (( k=0; k<j; k++))
do
#sec2#

model=`cat show_ses_"${sg[$k]}" |grep Product |awk -F':' '{print $2}'`
if [ $model = "H4102-J" ]; then
echo "Data102"
handle=`echo "${sg[$k]}" |awk -F"." '{print $1}'`
echo "Mapping PHYs for Device: $handle ($model)"

#sec2_ud102.txt
sed -i "s/Id/Slot/" sec2_show_phys_map_"${sg[$k]}"
sed -i "s/Phy/Slot/" sec2_err_cnts_0-60_read_map_"${sg[$k]}"
sed -i "s/Phy/Slot/" sec2_phyinfo_map_"${sg[$k]}"
sed -i "s/PHY/Slot/" sec2_phyinfo_buffer_map_"${sg[$k]}"

m=0
for n in {0..41}
do
slot_sec2_ud102[$n]=$m
sed -i "s/\<$n\> :/S"${slot_sec2_ud102[$n]}" :/" sec2_show_phys_map_"${sg[$k]}"
sed -i "s/\<$n\>\t/S"${slot_sec2_ud102[$n]}":\t/" sec2_err_cnts_0-60_read_map_"${sg[$k]}"
sed -i "s/\<$n\> /S"${slot_sec2_ud102[$n]}" /" sec2_phyinfo_map_"${sg[$k]}"
sed -i "s/\<$n\> /S"${slot_sec2_ud102[$n]}" /" sec2_phyinfo_buffer_map_"${sg[$k]}"
m=$(( m+1))
done


#slot_sec2_ud102[42]=43
sed -i "s/\<42\> :/S43 :/" sec2_show_phys_map_"${sg[$k]}"
sed -i "s/\<42\>\t/S43:\t/" sec2_err_cnts_0-60_read_map_"${sg[$k]}"
sed -i "s/\<42\> /S43 /" sec2_phyinfo_map_"${sg[$k]}"
sed -i "s/\<42\> /S43 /" sec2_phyinfo_buffer_map_"${sg[$k]}"
m=45
for n in {43..50}
do
slot_sec2_ud102[$n]=$m
sed -i "s/\<$n\> :/S"${slot_sec2_ud102[$n]}" :/" sec2_show_phys_map_"${sg[$k]}"
sed -i "s/\<$n\>\t/S"${slot_sec2_ud102[$n]}":\t/" sec2_err_cnts_0-60_read_map_"${sg[$k]}"
sed -i "s/\<$n\> /S"${slot_sec2_ud102[$n]}" /" sec2_phyinfo_map_"${sg[$k]}"
sed -i "s/\<$n\> /S"${slot_sec2_ud102[$n]}" /" sec2_phyinfo_buffer_map_"${sg[$k]}"
m=$(( m+1))
done


#sec1#

#sec1_ud102.txt
sed -i "s/Id/Slot/" sec1_show_phys_map_"${sg[$k]}"
sed -i "s/Phy/Slot/" sec1_phyinfo_map_"${sg[$k]}"
sed -i "s/PHY/Slot/" sec1_phyinfo_buffer_map_"${sg[$k]}"
sed -i "s/Phy/Slot/" sec1_err_cnts_0-60_read_map_"${sg[$k]}"
slot_sec1_ud102[0]=42
slot_sec1_ud102[1]=44
sed -i "s/\<0\> :/S42 :/" sec1_show_phys_map_"${sg[$k]}"
sed -i "s/\<1\> :/S44 :/" sec1_show_phys_map_"${sg[$k]}"
sed -i "s/\<0\> /S42 /" sec1_phyinfo_map_"${sg[$k]}"
sed -i "s/\<1\> /S44 /" sec1_phyinfo_map_"${sg[$k]}"
sed -i "s/\<0\> /S42 /" sec1_phyinfo_buffer_map_"${sg[$k]}"
sed -i "s/\<1\> /S44 /" sec1_phyinfo_buffer_map_"${sg[$k]}"


sed -i "s/\<0\>\t/S42:\t/" sec1_err_cnts_0-60_read_map_"${sg[$k]}"
sed -i "s/\<1\>\t/S44:\t/" sec1_err_cnts_0-60_read_map_"${sg[$k]}"
m=53
for n in {2..50}

do
slot_sec1_ud102[$n]=$m
sed -i "s/\<$n\> :/S"${slot_sec1_ud102[$n]}" :/" sec1_show_phys_map_"${sg[$k]}"
sed -i "s/\<$n\>\t/S"${slot_sec1_ud102[$n]}":\t/" sec1_err_cnts_0-60_read_map_"${sg[$k]}"
sed -i "s/\<$n\> /S"${slot_sec1_ud102[$n]}" /" sec1_phyinfo_map_"${sg[$k]}"
sed -i "s/\<$n\> /S"${slot_sec1_ud102[$n]}" /" sec1_phyinfo_buffer_map_"${sg[$k]}"
m=$(( m+1))
done

#-------------------------------------------------------------------------------
#----------UD60--------------------------------------------------------------
elif [[ $model =~ "H4060" ]]; then
echo "Data60/Serv60+8"
handle=`echo "${sg[$k]}" |awk -F"." '{print $1}'`
echo "Mapping PHYs for Device: $handle ($model)"

sed -i "s/Id/Slot/" sec1_show_phys_map_"${sg[$k]}"
sed -i "s/Phy/Slot/" sec1_err_cnts_0-60_read_map_"${sg[$k]}"
sed -i "s/PHY/Slot/" sec1_phyinfo_buffer_map_"${sg[$k]}"
declare -a slot_sec1_ud60=(0 2 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 - - - - - - - - - -)


for n in {0..150}
do
sed -i "s/\<$n\> :/S"${slot_sec1_ud60[$n]}" :/" sec1_show_phys_map_"${sg[$k]}"
sed -i "s/\<$n\>\t/S"${slot_sec1_ud60[$n]}":\t/" sec1_err_cnts_0-60_read_map_"${sg[$k]}"
sed -i "s/\<$n\> /S"${slot_sec1_ud60[$n]}" /" sec1_phyinfo_map_"${sg[$k]}"
sed -i "s/\<$n\> /S"${slot_sec1_ud60[$n]}" /" sec1_phyinfo_buffer_map_"${sg[$k]}"
done

#echo "-------------------------------------"
sed -i "s/Id/Slot/" sec2_show_phys_map_"${sg[$k]}"
sed -i "s/Phy/Slot/" sec2_err_cnts_0-60_read_map_"${sg[$k]}"
sed -i "s/PHY/Slot/" sec2_phyinfo_buffer_map_"${sg[$k]}"
m=1
for n in {42..50}
do
 slot_sec2_ud60[$n]=$m
sed -i "s/\<$n\> :/S"${slot_sec2_ud60[$n]}" :/" sec2_show_phys_map_"${sg[$k]}"
sed -i "s/\<$n\>\t/S"${slot_sec2_ud60[$n]}":\t/" sec2_err_cnts_0-60_read_map_"${sg[$k]}"
sed -i "s/\<$n\> /S"${slot_sec2_ud60[$n]}" /" sec2_phyinfo_map_"${sg[$k]}"
sed -i "s/\<$n\> /S"${slot_sec2_ud60[$n]}" /" sec2_phyinfo_buffer_map_"${sg[$k]}"
 m=$(( m+1))
done

else
echo "no matches found"
fi


done
