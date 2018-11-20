%This new state generation function follows the linear state spc eqn. x= Ax old+ Bv
function X= gen_newstate(model,X_old)
if isempty(X_old)
    X= [];
else
    X= model.A*X_old+ diag([model.sigmax model.sigmay model.sigmaw model.sigmah])*randn(size(model.A,1),size(X_old,2));
end
X=round(X);
end