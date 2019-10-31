#!/bin/bash

mkdir -p tmp_pool

rm -f chr*_*.subsam
mv chr*_*_A.cand1 tmp_pool/
mv chr*_*_A.chr tmp_pool/
mv chr*_*_A.st1 tmp_pool/
mv chr*_*_A.st3 tmp_pool/
mv chr*_*_A.st4 tmp_pool/
mv chr*_*_C.cand1 tmp_pool/
mv chr*_*_C.chr tmp_pool/
mv chr*_*_C.st1 tmp_pool/
mv chr*_*_C.st3 tmp_pool/
mv chr*_*_C.st4 tmp_pool/
mv chr*_*.dup tmp_pool/
mv chr*_*.exc tmp_pool/
mv chr*_*.gc tmp_pool/
mv chr*_*_G.cand1 tmp_pool/
mv chr*_*_G.chr tmp_pool/
mv chr*_*.god tmp_pool/
mv chr*_*_G.st1 tmp_pool/
mv chr*_*_G.st3 tmp_pool/
mv chr*_*_G.st4 tmp_pool/
mv chr*_*.info tmp_pool/
mv chr*_*.ok tmp_pool/
mv chr*_*.region tmp_pool/
mv chr*_*.res tmp_pool/
mv chr*_*.seq tmp_pool/
mv chr*_*_T.cand1 tmp_pool/
mv chr*_*_T.chr tmp_pool/
mv chr*_*_T.st1 tmp_pool/
mv chr*_*_T.st3 tmp_pool/
mv chr*_*_T.st4 tmp_pool/

du -sh tmp_pool

