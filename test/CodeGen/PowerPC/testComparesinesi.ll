; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-linux-gnu -O2 \
; RUN:   -ppc-gpr-icmps=all -ppc-asm-full-reg-names -mcpu=pwr8 < %s | FileCheck %s \
; RUN:  --implicit-check-not cmpw --implicit-check-not cmpd --implicit-check-not cmpl
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu -O2 \
; RUN:   -ppc-gpr-icmps=all -ppc-asm-full-reg-names -mcpu=pwr8 < %s | FileCheck %s \
; RUN:  --implicit-check-not cmpw --implicit-check-not cmpd --implicit-check-not cmpl
; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py

@glob = common local_unnamed_addr global i32 0, align 4

define signext i32 @test_inesi(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: test_inesi:
; CHECK:    xor r3, r3, r4
; CHECK-NEXT:    cntlzw r3, r3
; CHECK-NEXT:    srwi r3, r3, 5
; CHECK-NEXT:    xori r3, r3, 1
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ne i32 %a, %b
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}

define signext i32 @test_inesi_sext(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: test_inesi_sext:
; CHECK:    xor r3, r3, r4
; CHECK-NEXT:    cntlzw r3, r3
; CHECK-NEXT:    srwi r3, r3, 5
; CHECK-NEXT:    xori r3, r3, 1
; CHECK-NEXT:    neg r3, r3
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ne i32 %a, %b
  %sub = sext i1 %cmp to i32
  ret i32 %sub
}

define signext i32 @test_inesi_z(i32 signext %a) {
; CHECK-LABEL: test_inesi_z:
; CHECK:    cntlzw r3, r3
; CHECK-NEXT:    srwi r3, r3, 5
; CHECK-NEXT:    xori r3, r3, 1
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ne i32 %a, 0
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}

define signext i32 @test_inesi_sext_z(i32 signext %a) {
; CHECK-LABEL: test_inesi_sext_z:
; CHECK:    cntlzw r3, r3
; CHECK-NEXT:    srwi r3, r3, 5
; CHECK-NEXT:    xori r3, r3, 1
; CHECK-NEXT:    neg r3, r3
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ne i32 %a, 0
  %sub = sext i1 %cmp to i32
  ret i32 %sub
}

define void @test_inesi_store(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: test_inesi_store:
; CHECK:    xor r3, r3, r4
; CHECK:    cntlzw r3, r3
; CHECK:    srwi r3, r3, 5
; CHECK:    xori r3, r3, 1
; CHECK:    stw r3, 0(r4)
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ne i32 %a, %b
  %conv = zext i1 %cmp to i32
  store i32 %conv, i32* @glob, align 4
  ret void
}

define void @test_inesi_sext_store(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: test_inesi_sext_store:
; CHECK:    xor r3, r3, r4
; CHECK:    cntlzw r3, r3
; CHECK:    srwi r3, r3, 5
; CHECK:    xori r3, r3, 1
; CHECK:    neg r3, r3
; CHECK:    stw r3, 0(r4)
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ne i32 %a, %b
  %sub = sext i1 %cmp to i32
  store i32 %sub, i32* @glob, align 4
  ret void
}

define void @test_inesi_z_store(i32 signext %a) {
; CHECK-LABEL: test_inesi_z_store:
; CHECK:    cntlzw r3, r3
; CHECK:    srwi r3, r3, 5
; CHECK:    xori r3, r3, 1
; CHECK:    stw r3, 0(r4)
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ne i32 %a, 0
  %conv = zext i1 %cmp to i32
  store i32 %conv, i32* @glob, align 4
  ret void
}

define void @test_inesi_sext_z_store(i32 signext %a) {
; CHECK-LABEL: test_inesi_sext_z_store:
; CHECK:    cntlzw r3, r3
; CHECK:    srwi r3, r3, 5
; CHECK:    xori r3, r3, 1
; CHECK:    neg r3, r3
; CHECK:    stw r3, 0(r4)
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ne i32 %a, 0
  %sub = sext i1 %cmp to i32
  store i32 %sub, i32* @glob, align 4
  ret void
}
