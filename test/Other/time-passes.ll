; RUN: opt < %s -disable-output -instcombine -instcombine -licm -time-passes 2>&1 | FileCheck %s --check-prefix=TIME --check-prefix=TIME-LEGACY
; RUN: opt < %s -disable-output -instcombine -instcombine -licm -licm -time-passes 2>&1 | FileCheck %s --check-prefix=TIME --check-prefix=TIME-LEGACY --check-prefix=TIME-DOUBLE-LICM
;
; TIME: Pass execution timing report
; TIME: Total Execution Time:
; TIME: Name
; TIME-LEGACY-DAG:   Combine redundant instructions{{$}}
; TIME-LEGACY-DAG:   Combine redundant instructions #2
; TIME-LEGACY-DAG:   Loop Invariant Code Motion{{$}}
; TIME-DOUBLE-LICM-DAG:  Loop Invariant Code Motion #2
; TIME-LEGACY-DAG:   Scalar Evolution Analysis
; TIME-LEGACY-DAG:   Loop-Closed SSA Form Pass
; TIME-LEGACY-DAG:   LCSSA Verifier
; TIME-LEGACY-DAG:   Canonicalize natural loops
; TIME-LEGACY-DAG:   Natural Loop Information
; TIME-LEGACY-DAG:   Dominator Tree Construction
; TIME-LEGACY-DAG:   Module Verifier
; TIME-LEGACY-DAG:   Target Library Information
; TIME: Total{{$}}

define i32 @foo() {
  %res = add i32 5, 4
  br label %loop1
loop1:
  br i1 false, label %loop1, label %end
end:
  ret i32 %res
}

define void @bar_with_loops() {
  br label %loop1
loop1:
  br i1 false, label %loop1, label %loop2
loop2:
  br i1 true, label %loop2, label %end
end:
  ret void

}
