function resample_idx= resample(w,L)
resample_idx= [];
[~,sort_idx]= sort(-w);
rv= rand(L,1);
i= 0; threshold= 0;
while ~isempty(rv)
    i= i+1; threshold= threshold+ w(sort_idx(i));
    rv_len= length(rv);
    idx= find(rv>threshold);
    resample_idx= [ resample_idx; sort_idx(i)*ones(rv_len-length(idx),1) ];  %#ok<AGROW>
    rv= rv(idx);
end
end