dir = '/home/kris/Desktop/link_to_kris_ganymede/old_scratch_kris/data_and_coding_folder/extended_80415202001_forspecfit_take_two/spec_chu13_1820/'
rmf_file = 'nu80415202001A06_chu13_N_sr'
rmf_ext = '.rmf'
filename = dir+rmf_file+rmf_ext

rmfread, dir+rmf_file+rmf_ext, rmf_info, compressed='UNCOMPRESSED'
;; plot to see what the matrix looks like
loadct, 3
plot_image, alog(transpose(*(rmf_info.data))), xtitle='Channel', ytitle='Energy'

load_nsspec, dir+rmf_file, specstr

err=''
fxbopen, unit, filename, 'MATRIX', hh, errmsg=err

fxbreadm, unit, ['ENERG_LO','ENERG_HI','N_GRP','F_CHAN','N_CHAN','MATRIX'], $
  elo, ehi, ngrp, fchan, nchan, matrix, errmsg=err

fxbclose, unit

col = fxbcolnum(unit, 'ENERG_LO')
eunit = strtrim(fxpar(hh, 'TUNIT'+strtrim(col,2), count=ct),2)
nchans   = fxpar(hh, 'DETCHANS')

vcol2arr, ngrp, ngrp
vcol2arr, fchan,fchan
vcol2arr, nchan,nchan

nbins = n_elements(ngrp)
rsp=fltarr(nbins,nbins)
for rr = 0, nbins-1 do rsp[*,rr]=specstr.rmf[*,rr]*specstr.arf[rr];/dE[rr]
plot_image, rsp, xtitle='Channel', ytitle='Energy'

vrmf2arr, matrix, nchans, ngrp, fchan, nchan, rmf_arr, compressed='UNCOMPRESSED'
lchan = fchan+nchan-1
;ii = matrix.indices
;nc = ii(1:*)-ii
;plot_image, alog(*(ptr_new(rmf_arr))), xtitle='Channel', ytitle='Energy'
;save, rmf_arr, filename='/home/kris/Desktop/rmf_array.sav'
;save, ngrp, filename='/home/kris/Desktop/ngrp.sav'
;save, fchan, filename='/home/kris/Desktop/fchan.sav'
;save, nchan, filename='/home/kris/Desktop/nchan.sav'
;save, lchan, filename='/home/kris/Desktop/lchan.sav'
;save, rsp, filename='/home/kris/Desktop/rsp.sav'
end