context("Testing ancombc function")
library(ANCOMBC)
library(testthat)

data(atlas1006, package = "microbiome")

# subset to baseline
pseq = phyloseq::subset_samples(atlas1006, time == 0)

# test
test_that("`ancombc` function provides expected results", {
    set.seed(123)
    out = ancombc(data = pseq,
                  tax_level = "Family",
                  formula = "age + nationality + bmi_group",
                  p_adj_method = "holm", prv_cut = 0.10, lib_cut = 1000,
                  group = "bmi_group", struc_zero = TRUE, neg_lb = FALSE,
                  tol = 1e-5, max_iter = 100, conserve = TRUE,
                  alpha = 0.05, global = TRUE, n_cl = 1, verbose = FALSE)
    res_prim = out$res
    test_output = round(res_prim$W[1, 3], 2)
    expect_equal(test_output, -4.9)
})


