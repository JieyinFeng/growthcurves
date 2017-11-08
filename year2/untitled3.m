%% Figure 1a
% Specify sessions of interest
sessions = [0 1 2 3 4 5];
% Make the time variable categorical
int_data.int_session_cat = categorical(int_data.int_session);
% Gather stats
% composites = {'WJ BRS', 'WJ RF', 'TWRE INDEX', 'LWID', 'WA', 'SWE', 'PDE'};
raw = {'WJ BRS', 'WJ RF', 'TWRE INDEX', 'LWID', 'WA', 'SWE', 'PDE', 'RAPID'};
lme_brs = fitlme(int_data, 'wj_brs ~ 1 + int_session_cat + (1|record_id) + (int_session_cat - 1|record_id)');
lme_rf = fitlme(int_data, 'wj_rf ~ 1 + int_session_cat + (1|record_id) + (int_session_cat - 1|record_id)');
lme_twre = fitlme(int_data, 'twre_index ~ 1 + int_session_cat + (1|record_id) + (int_session_cat - 1|record_id)');
% lme_lwid = fitlme(int_data, 'wj_lwid_raw ~ 1 + int_session_cat + (1|record_id) + (int_session_cat - 1|record_id)');
% lme_wa = fitlme(int_data, 'wj_wa_raw ~ 1 + int_session_cat + (1|record_id) + (int_session_cat - 1|record_id)');
% lme_swe = fitlme(int_data, 'twre_swe_raw ~ 1 + int_session_cat + (1|record_id) + (int_session_cat - 1|record_id)');
% lme_pde = fitlme(int_data, 'twre_pde_raw ~ 1 + int_session_cat + (1|record_id) + (int_session_cat - 1|record_id)');
% lme_rapid = fitlme(int_data, 'ctopp_rapid ~ 1 + int_session_cat + (1|record_id) + (int_session_cat - 1|record_id)');
% Create figure
figure; hold;
dmap = lines; 
% Organize data
% initialize estimate arrays
brs_est = lme_brs.Coefficients.Estimate;
rf_est = lme_rf.Coefficients.Estimate;
twre_est = lme_twre.Coefficients.Estimate;
% lwid_est = lme_lwid.Coefficients.Estimate;
% wa_est = lme_wa.Coefficients.Estimate;
% swe_est = lme_swe.Coefficients.Estimate;
% pde_est = lme_pde.Coefficients.Estimate;
% rapid_est = lme_rapid.Coefficients.Estimate;
% gather standard errors and p values
brs_se = lme_brs.Coefficients.SE;
brs_p = lme_brs.Coefficients.pValue;
rf_se = lme_rf.Coefficients.SE;
rf_p = lme_rf.Coefficients.pValue;
twre_se = lme_twre.Coefficients.SE;
twre_p = lme_twre.Coefficients.pValue;
% lwid_se = lme_lwid.Coefficients.SE;
% lwid_p = lme_lwid.Coefficients.pValue;
% wa_se = lme_wa.Coefficients.SE;
% wa_p = lme_wa.Coefficients.pValue;
% swe_se = lme_swe.Coefficients.SE;
% swe_p = lme_swe.Coefficients.pValue;
% pde_se = lme_pde.Coefficients.SE;
% pde_p = lme_pde.Coefficients.pValue;
% rapid_se = lme_rapid.Coefficients.SE;
% rapid_p = lme_rapid.Coefficients.pValue;
% extend intercept to components of estimates
for sess = 2:length(sessions)
    brs_est(sess, 1) = (brs_est(1,1) + brs_est(sess, 1));
    rf_est(sess, 1) = (rf_est(1,1) + rf_est(sess, 1));
    twre_est(sess, 1) = (twre_est(1,1) + twre_est(sess, 1));
%     lwid_est(sess, 1) = (lwid_est(1,1) + lwid_est(sess, 1));
%     wa_est(sess, 1) = (wa_est(1,1) + wa_est(sess, 1));
%     swe_est(sess, 1) = (swe_est(1,1) + swe_est(sess, 1));
%     pde_est(sess, 1) = (pde_est(1,1) + pde_est(sess, 1));
%     rapid_est(sess, 1) = (rapid_est(1,1) + rapid_est(sess, 1));
end
% plot
plot(sessions', brs_est, '-o', 'Color', dmap(1,:), 'MarkerFaceColor', dmap(1,:), 'LineWidth', 2, 'MarkerSize', 6, 'MarkerEdgeColor', dmap(1,:));
plot(sessions', rf_est, '-o', 'Color', dmap(2,:), 'MarkerFaceColor', dmap(2,:), 'LineWidth', 2, 'MarkerSize', 6, 'MarkerEdgeColor', dmap(2,:));
plot(sessions', twre_est, '-o', 'Color', dmap(3,:), 'MarkerFaceColor', dmap(3,:), 'LineWidth', 2, 'MarkerSize', 6, 'MarkerEdgeColor', dmap(3,:));
% plot(sessions', lwid_est, '-o', 'Color', dmap(4,:), 'MarkerFaceColor', dmap(4,:), 'LineWidth', 2, 'MarkerSize', 6, 'MarkerEdgeColor', dmap(4,:));
% plot(sessions', wa_est, '-o', 'Color', dmap(5,:), 'MarkerFaceColor', dmap(5,:), 'LineWidth', 2, 'MarkerSize', 6, 'MarkerEdgeColor', dmap(5,:));
% plot(sessions', swe_est, '-o', 'Color', dmap(6,:), 'MarkerFaceColor', dmap(6,:), 'LineWidth', 2, 'MarkerSize', 6, 'MarkerEdgeColor', dmap(6,:));
% plot(sessions', pde_est, '-o', 'Color', dmap(7,:), 'MarkerFaceColor', dmap(7,:), 'LineWidth', 2, 'MarkerSize', 6, 'MarkerEdgeColor', dmap(7,:));
% plot(sessions', rapid_est, '-o', 'Color', dmap(8,:), 'MarkerFaceColor', dmap(8,:), 'LineWidth', 2, 'MarkerSize', 6, 'MarkerEdgeColor', dmap(8,:));

% add error bars
errorbar(sessions', brs_est, brs_se, '.k', 'Color', dmap(1,:), 'LineWidth', 2);
errorbar(sessions', rf_est, rf_se, '.k', 'Color', dmap(2,:), 'LineWidth', 2);
errorbar(sessions', twre_est, twre_se, '.k', 'Color', dmap(3,:), 'LineWidth', 2);
% errorbar(sessions', lwid_est, lwid_se, '.k', 'Color', dmap(4,:), 'LineWidth', 2);
% errorbar(sessions', wa_est, wa_se, '.k', 'Color', dmap(5,:), 'LineWidth', 2);
% errorbar(sessions', swe_est, swe_se, '.k', 'Color', dmap(6,:), 'LineWidth', 2);
% errorbar(sessions', pde_est, pde_se, '.k', 'Color', dmap(7,:), 'LineWidth', 2);
% errorbar(sessions', rapid_est, rapid_se, '.k', 'Color', dmap(8,:), 'LineWidth', 2);
%Format Plot
ax = gca;
ax.XLim = [-0.1 (max(sessions) + 0.1)];
ax.YLim = [70 100];
ax.XAxis.TickValues = sessions;
xlabel('Session'); ylabel('Standard Score');
title('Growth in Reading Skill');
grid('on');
legend(raw, 'Location', 'eastoutside');



%% Correlations

brs_1 = int_data.wj_brs(int_data.study_name == 1);
brs_4 = int_data.wj_brs(int_data.study_name == 4);
brs_5 = int_data.wj_brs(int_data.study_name == 5);


rf_1 = int_data.wj_rf(int_data.study_name == 1);
rf_4 = int_data.wj_rf(int_data.study_name == 4);
rf_5 = int_data.wj_rf(int_data.study_name == 5);


twre_1 = int_data.twre_index(int_data.study_name == 1);
twre_4 = int_data.twre_index(int_data.study_name == 4);
twre_5 = int_data.twre_index(int_data.study_name == 5);
