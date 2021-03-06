include("../src/CenteredSparseMatrix.jl")
#include("sparse_centered.jl")

using Main.CenteredSparseMatrix
using Base.Test



# Just some setup

n = 5
m = 3
d = 0.8

k = 2

A = sprand(n, m, d);
Acd = full(A .- mean(A, 1));
Acs = CenteredSparseCSC(A);


x = rand(m);
X = rand(m, k);
y = rand(n);
Y = rand(n, k);

z = zeros(size(Acs, 1));
Z = zeros(size(Acs, 1), size(X, 2));
# the actual tests

@test isapprox(Acd * x, Acs * x)
@test isapprox(Acd * x, A_mul_B!(z, Acs, x))
@test isapprox(Acd * X, Acs * X)
@test isapprox(Acd * X, A_mul_B!(Z, Acs, X))
@test isapprox(Acd * X, CenteredSparseMatrix.A_mul_B1!(Z, Acs, X))

@test isapprox(Acd' * y, Ac_mul_B(Acs, y))
@test isapprox(Acd' * y, Acs' * y)
@test isapprox(Acd' * y, Acs'y)
@test isapprox(Acd' * Y, Ac_mul_B(Acs, Y))
@test isapprox(Acd' * Y, Acs' * Y)
@test isapprox(Acd' * Y, Acs'Y)


