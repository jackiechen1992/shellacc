#!/bin/bash
source ~/.bashrc
#根据传入时间顺序执行

getos(){
  #2 means macos,3 means linux
  os_type=1
  os_mac=`uname | grep "Darwin" | wc -l`
  os_linux=`uname | grep "Linux\|GNU" | wc -l`
  if [ $os_mac -ge 1 ];then
    os_type=2
  elif [ $os_linux -ge 1 ];then
    os_type=3
  fi
  return $os_type
}

executor(){
  script=$1
  start=$2
  end=$3
  threads=$4
  acc=$5
  os_type=$6
  let sub=(${end}-${start})*${acc}
  while [ ${sub} -ge 0 ];
  do
    thread_number=0
    datelist=()
    while([ ${sub} -ge 0  ] && [ ${thread_number} -lt ${threads} ]);
    do
        datelist=("${start}" "${datelist[@]}")
        if [ $os_type -eq 2 ];then
          start=`date -v${acc}d -j -f "%Y%m%d" ${start} +"%Y%m%d"`
        elif [ $os_type -eq 3 ];then 
          start=`date -d "${start} ${acc} day" +%Y%m%d`
        else
          exit -1
        fi
        let sub=(${end}-${start})*${acc}
        let thread_number=${thread_number}+1
    done
    
    if [ $os_type -eq 2 ];then
      printf "\n"
    else
      echo -e "\n"
    fi
    echo ">>>>>>>>>>>>>>>${script}'s new peroid started!>>>>>>>>>>>>>>>"
    for dateIndex in ${datelist[@]};
    do
      (
        /bin/bash ${script} ${dateIndex}
        if [ $? -ne 0 ];then
          echo "Peroid ${dateIndex} Failed!"
        else
          echo "Peroid ${dateIndex} Succeeded!"
        fi 
      )&
    done
    wait
    echo ">>>>>>>>>>>>>>>${script}'s new peroid finished successfully!>>>>>>>>>>>>>>>"
    if [ $os_type -eq 2 ];then
      printf "\n"
    else
      echo -e "\n"
    fi
  done
}

script=$1
start=$2
end=$3
threads=$4
acc=1
getos
os_type=$?

#parameters check
if [ $os_type -eq 1 ];then
  echo ">>>os_type not support!>>>"
  exit -1
fi
#other parameters check haven't been done.
#echo ">>>sh RunHistoryByDateMultithread.sh [yourscript] [start-date] [end-date] [threads]>>>"

let sub=${start}-${end}
if [ $sub -ge 0 ];then
  acc=-1
else
  acc=+1
fi
executor $script $start $end $threads $acc $os_type
