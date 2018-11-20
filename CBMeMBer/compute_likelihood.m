%compute the likelihood function g y(x) in the form of a vector for all particles
function g= compute_likelihood(p_g,upper_hists,lower_hists,X,img)
M= size(X,2);
g=zeros(M,1);
P= ceil(X); 
upper_hists_1=hist_vector(upper_hists);
lower_hists_2=hist_vector(lower_hists);
for i=1:M
    img1=image_grab(img,[P(1,i) P(2,i) P(3,i) ceil(P(4,i)/2)]);
    v1=hist_vector(img1);
    img2=image_grab(img,[P(1,i) P(2,i)+ceil(P(4,i)/2) P(3,i) ceil(P(4,i)/2)]);
    v2=hist_vector(img2);
    % The histogram likelihoods
    p1=kernel_likelihood(v1,upper_hists_1);
    p2=kernel_likelihood(v2,lower_hists_2);
    % The multinomial pmf values
    g(i)=p1*p2/(p_g^(X(3,i)*X(4,i)));
end
end