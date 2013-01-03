task t1 < in=(B: a b) > out { … }

task t2 < in=$out@t1[B:a] > out :: Q=(X: x y) { … }

task t3 < in1=$out@t1 in2=$out@t2 > out { … }

task t4 < in1=$out@t3[B:b,X:y] in2=$out@t2[X:x] :: Q=(B: a b) { … }
