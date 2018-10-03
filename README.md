# shellacc
This is a tool kits for shell.Accelerate shell using and executing or so on.

For example,the script RunHistoryByDateMultithread.sh is used for execute a script with multi process from start-date to end-date daily, of course your script must accept only one parameter which is a date format [yyyyMMdd].

$ sh RunHistoryByDateMultithread.sh [yourscript] [start-date] [end-date] [threads]
e.g.
$ sh RunHistoryByDateMultithread.sh echoDate.sh 20180901 20180905 2

//Result
>>>>>>>>>>>>>>>echoDate.sh's new peroid started!>>>>>>>>>>>>>>>
20180901
20180902
Peroid 20180901 Succeeded!
Peroid 20180902 Succeeded!
>>>>>>>>>>>>>>>echoDate.sh's new peroid finished successfully!>>>>>>>>>>>>>>>


>>>>>>>>>>>>>>>echoDate.sh's new peroid started!>>>>>>>>>>>>>>>
20180904
20180903
Peroid 20180904 Succeeded!
Peroid 20180903 Succeeded!
>>>>>>>>>>>>>>>echoDate.sh's new peroid finished successfully!>>>>>>>>>>>>>>>


>>>>>>>>>>>>>>>echoDate.sh's new peroid started!>>>>>>>>>>>>>>>
20180905
Peroid 20180905 Succeeded!
>>>>>>>>>>>>>>>echoDate.sh's new peroid finished successfully!>>>>>>>>>>>>>>>
