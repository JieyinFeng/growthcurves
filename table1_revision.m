%% Create Data Table 1 Figure
% Patrick M. Donnelly
% University of Washington
% July 19th, 2017


sifted_data = horzcat(int_data.int_session, int_data.wj_lwid_ss, int_data.wj_wa_ss, ...
    int_data.wj_brs, int_data.wj_or_ss, int_data.wj_srf_ss, ...
    int_data.wj_rf, int_data.twre_swe_ss, int_data.twre_pde_ss, ...
    int_data.twre_index, int_data.wj_mff_ss, int_data.wj_calc_ss, ...
    int_data.wj_mcs);
tests = {'LWID', 'WA', 'BRS', 'OR', 'SRF', ...
    'RF', 'SWE', 'PDE', 'TWRE', 'MFF', 'CALC', 'MCS'};


numrows = length(tests);
numcols = 15;
mean0 = []; std0 = [];
mean1 = []; std1 = [];
mean2 = []; std2 = [];
mean3 = []; std3 = [];
mean4 = []; std4 = [];

time = sifted_data(:,1);
for ii = 2:(length(tests)+1)
score = sifted_data(:, ii);
    
mean0 = vertcat(mean0, nanmean(score(time == 0)));
std0 = vertcat(std0, nanstd(score(time == 0)));
    
mean1 = vertcat(mean1, nanmean(score(time == 1)));
std1 = vertcat(std1, nanstd(score(time == 1)));

mean2 = vertcat(mean2, nanmean(score(time == 2)));
std2 = vertcat(std2, nanstd(score(time == 2)));
 
mean3 = vertcat(mean3, nanmean(score(time == 3)));
std3 = vertcat(std3, nanstd(score(time == 3)));

mean4 = vertcat(mean4, nanmean(score(time == 4)));
std4 = vertcat(std4, nanstd(score(time == 4)));
end

table1 = table(tests', mean0, std0, ...
                mean1, std1, mean2, std2, ...
                mean3, std3, mean4, std4);
            
filename = 'C:\Users\Patrick\Desktop\supp_table1.xlsx';
writetable(table1, filename);

%% Gather LME stats
% run lmeLong with different parameters
% long_var = hours
linear_slope = []; pval = []; se = []; lower = []; upper = []; aic = []; bic = []; loglik = []; 
for ii = 1:length(tests)
    linear_slope = vertcat(linear_slope, stats(ii).lme.Coefficients.Estimate(2));
    pval = vertcat(pval, stats(ii).lme.Coefficients.pValue(2));   
    se = vertcat(se, stats(ii).lme.Coefficients.SE(2));
    lower = vertcat(lower, stats(ii).lme.Coefficients.Lower(2));
    upper = vertcat(upper, stats(ii).lme.Coefficients.Upper(2));
    aic = vertcat(aic, stats(ii).lme.ModelCriterion.AIC);
    bic = vertcat(bic, stats(ii).lme.ModelCriterion.BIC);
    loglik = vertcat(loglik, stats(ii).lme.LogLikelihood);
end

table2 = table(linear_slope, se, pval, lower, upper, aic, bic, loglik);

filename = 'C:\Users\Patrick\Desktop\supp_tbl_lme.xlsx';
writetable(table2, filename);