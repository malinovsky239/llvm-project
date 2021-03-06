; RUN: llc -mtriple=x86_64-apple-macosx10.10.0 < %s | FileCheck %s

target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"

; The assertions are *enhanced* from update_test_checks.ll to include
; the constant load values because those are important.

; CHECK:        [[SIGNMASK1:L.+]]:
; CHECK-NEXT:   .quad -9223372036854775808    ## double -0
; CHECK-NEXT:   .quad -9223372036854775808    ## double -0

define double @mag_pos0_double(double %x) nounwind {
; CHECK-LABEL: mag_pos0_double:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    andps [[SIGNMASK1]](%rip), %xmm0
; CHECK-NEXT:    retq
;
  %y = call double @copysign(double 0.0, double %x)
  ret double %y
}

; CHECK:        [[SIGNMASK2:L.+]]:
; CHECK-NEXT:   .quad -9223372036854775808    ## double -0

define double @mag_neg0_double(double %x) nounwind {
; CHECK-LABEL: mag_neg0_double:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    movsd [[SIGNMASK2]](%rip), %xmm1
; CHECK-NEXT:    andps %xmm1, %xmm0
; CHECK-NEXT:    retq
;
  %y = call double @copysign(double -0.0, double %x)
  ret double %y
}

; CHECK:        [[SIGNMASK3:L.+]]:
; CHECK-NEXT:   .quad -9223372036854775808    ## double -0
; CHECK-NEXT:   .quad -9223372036854775808    ## double -0
; CHECK:        [[ONE3:L.+]]:
; CHECK-NEXT:   .quad 4607182418800017408     ## double 1

define double @mag_pos1_double(double %x) nounwind {
; CHECK-LABEL: mag_pos1_double:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    andps [[SIGNMASK3]](%rip), %xmm0
; CHECK-NEXT:    movsd [[ONE3]](%rip), %xmm1
; CHECK-NEXT:    orps %xmm1, %xmm0
; CHECK-NEXT:    retq
;
  %y = call double @copysign(double 1.0, double %x)
  ret double %y
}

; CHECK:        [[SIGNMASK4:L.+]]:
; CHECK-NEXT:   .quad -9223372036854775808    ## double -0
; CHECK-NEXT:   .quad -9223372036854775808    ## double -0
; CHECK:        [[ONE4:L.+]]:
; CHECK-NEXT:   .quad 4607182418800017408     ## double 1
; CHECK-NEXT:   .quad 4607182418800017408     ## double 1

define double @mag_neg1_double(double %x) nounwind {
; CHECK-LABEL: mag_neg1_double:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    andps [[SIGNMASK4]](%rip), %xmm0
; CHECK-NEXT:    orps [[ONE4]](%rip), %xmm0
; CHECK-NEXT:    retq
;
  %y = call double @copysign(double -1.0, double %x)
  ret double %y
}

; CHECK:       [[SIGNMASK5:L.+]]:
; CHECK-NEXT:  .long 2147483648              ## float -0
; CHECK-NEXT:  .long 2147483648              ## float -0
; CHECK-NEXT:  .long 2147483648              ## float -0
; CHECK-NEXT:  .long 2147483648              ## float -0

define float @mag_pos0_float(float %x) nounwind {
; CHECK-LABEL: mag_pos0_float:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    andps [[SIGNMASK5]](%rip), %xmm0
; CHECK-NEXT:    retq
;
  %y = call float @copysignf(float 0.0, float %x)
  ret float %y
}

; CHECK:       [[SIGNMASK6:L.+]]:
; CHECK-NEXT:  .long 2147483648              ## float -0

define float @mag_neg0_float(float %x) nounwind {
; CHECK-LABEL: mag_neg0_float:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    movss [[SIGNMASK6]](%rip), %xmm1
; CHECK-NEXT:    andps %xmm1, %xmm0
; CHECK-NEXT:    retq
;
  %y = call float @copysignf(float -0.0, float %x)
  ret float %y
}

; CHECK:       [[SIGNMASK7:L.+]]:
; CHECK-NEXT:  .long 2147483648              ## float -0
; CHECK-NEXT:  .long 2147483648              ## float -0
; CHECK-NEXT:  .long 2147483648              ## float -0
; CHECK-NEXT:  .long 2147483648              ## float -0
; CHECK:        [[ONE7:L.+]]:
; CHECK-NEXT:  .long 1065353216              ## float 1

define float @mag_pos1_float(float %x) nounwind {
; CHECK-LABEL: mag_pos1_float:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    andps [[SIGNMASK7]](%rip), %xmm0
; CHECK-NEXT:    movss [[ONE7]](%rip), %xmm1
; CHECK-NEXT:    orps %xmm1, %xmm0
; CHECK-NEXT:    retq
;
  %y = call float @copysignf(float 1.0, float %x)
  ret float %y
}

; CHECK:       [[SIGNMASK8:L.+]]:
; CHECK-NEXT:  .long 2147483648              ## float -0
; CHECK-NEXT:  .long 2147483648              ## float -0
; CHECK-NEXT:  .long 2147483648              ## float -0
; CHECK-NEXT:  .long 2147483648              ## float -0
; CHECK:        [[ONE8:L.+]]:
; CHECK-NEXT:  .long 1065353216              ## float 1
; CHECK-NEXT:  .long 1065353216              ## float 1
; CHECK-NEXT:  .long 1065353216              ## float 1
; CHECK-NEXT:  .long 1065353216              ## float 1

define float @mag_neg1_float(float %x) nounwind {
; CHECK-LABEL: mag_neg1_float:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    andps [[SIGNMASK8]](%rip), %xmm0
; CHECK-NEXT:    orps [[ONE8]](%rip), %xmm0
; CHECK-NEXT:    retq
;
  %y = call float @copysignf(float -1.0, float %x)
  ret float %y
}

declare double @copysign(double, double) nounwind readnone
declare float @copysignf(float, float) nounwind readnone

