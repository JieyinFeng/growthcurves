%% Create Data Table 1 Figure
% Patrick M. Donnelly
% University of Washington
% December 15th, 2017


sifted_data = horzcat(cntrl_data.int_session, cntrl_data.wj_lwid_ss, cntrl_data.wj_wa_ss, ...
    cntrl_data.wj_brs, cntrl_data.wj_or_ss, cntrl_data.wj_srf_ss, ...
    cntrl_data.wj_rf, cntrl_data.twre_swe_ss, cntrl_data.twre_pde_ss, ...
    cntrl_data.twre_index, cntrl_data.wj_mff_ss, cntrl_data.wj_calc_ss, cntrl_data.wj_mcs);
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
            
filename = 'C:\Users\Patrick\Desktop\supp_tbl1a.xlsx';
writetable(table1, filename);

%% Gather LME stats
% run lmeLong with different parameters
% long_var = hours
linear_slope = []; pval = []; se = []; aic = []; bic = []; loglik = []; 
for ii = 1:length(tests)
    linear_slope = vertcat(linear_slope, cntrl_stats(ii).lme.Coefficients.Estimate(2));
    pval = vertcat(pval, cntrl_stats(ii).lme.Coefficients.pValue(2));   
    se = vertcat(se, cntrl_stats(ii).lme.Coefficients.SE(2));
    aic = vertcat(aic, cntrl_stats(ii).lme.ModelCriterion.AIC);
    bic = vertcat(bic, cntrl_stats(ii).lme.ModelCriterion.BIC);
    loglik = vertcat(loglik, cntrl_stats(ii).lme.LogLikelihood);
end

table2 = table(linear_slope, se, pval, aic, bic, loglik);

filename = 'C:\Users\Patrick\Desktop\supptbl1b.xlsx';
writetable(table2, filename);

% compile interaction statistics
beta = []; pval = []; se = []; aic = []; bic = []; loglik = []; 
for ii = 1:length(tests)
    beta = vertcat(beta, inter_stats(ii).lme_int.Coefficients.Estimate(4));
    pval = vertcat(pval, inter_stats(ii).lme_int.Coefficients.pValue(4));   
    se = vertcat(se, inter_stats(ii).lme_int.Coefficients.SE(4));
    aic = vertcat(aic, inter_stats(ii).lme_int.ModelCriterion.AIC);
    bic = vertcat(bic, inter_stats(ii).lme_int.ModelCriterion.BIC);
    loglik = vertcat(loglik, inter_stats(ii).lme_int.LogLikelihood);
end

table3 = table(beta, se, pval, aic, bic, loglik);

filename = 'C:\Users\Patrick\Desktop\supptbl1c.xlsx';
writetable(table3, filename);
