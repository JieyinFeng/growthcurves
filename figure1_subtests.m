%% Figure 1
% function to create figure 1 from Donnelly, et al (2017)
% prerequisites: run the preprocess.m function
% Patrick Donnelly; University of Washington; August 8th, 2017
%% Figure 1a
% Specify sessions of interest
sessions = [0 1 2 3 4 5 6];
% Make the time variable categorical
int_data.int_session_cat = categorical(int_data.int_session);
int_data.wj_srf_ss = str2double(int_data.wj_srf_ss);
% Gather stats
tests = {'WJ_LWID', 'WJ_WA', 'WJ_OR', 'WJ_SRF', 'TWRE_SWE', 'TOWRE_PDE'};
lme_lwid = fitlme(int_data, 'wj_lwid_ss ~ 1 + int_session_cat + (1|record_id) + (int_session_cat - 1|record_id)');
lme_wa = fitlme(int_data, 'wj_wa_ss ~ 1 + int_session_cat + (1|record_id) + (int_session_cat - 1|record_id)');
lme_or = fitlme(int_data, 'wj_or_ss ~ 1 + int_session_cat + (1|record_id) + (int_session_cat - 1|record_id)');
lme_srf = fitlme(int_data, 'wj_srf_ss ~ 1 + int_session_cat + (1|record_id) + (int_session_cat - 1|record_id)');
lme_twre_swe = fitlme(int_data, 'twre_swe_ss ~ 1 + int_session_cat + (1|record_id) + (int_session_cat - 1|record_id)');
lme_twre_pde = fitlme(int_data, 'twre_pde_ss ~ 1 + int_session_cat + (1|record_id) + (int_session_cat - 1|record_id)');

% Create figure
figure; hold;
dmap = lines; dmap = vertcat(dmap(2,:), dmap(1,:), dmap(5,:));
% Organize data
% initialize estimate arrays
lwid_est = lme_lwid.Coefficients.Estimate;
wa_est = lme_wa.Coefficients.Estimate;
or_est = lme_or.Coefficients.Estimate;
srf_est = lme_srf.Coefficients.Estimate;
twre_swe_est = lme_twre_swe.Coefficients.Estimate;
twre_pde_est = lme_twre_pde.Coefficients.Estimate;
% gather standard errors and p values
lwid_se = lme_lwid.Coefficients.SE;
lwid_p = lme_lwid.Coefficients.pValue;
wa_se = lme_wa.Coefficients.SE;
wa_p = lme_wa.Coefficients.pValue;
or_se = lme_or.Coefficients.SE;
or_p = lme_or.Coefficients.pValue;
srf_se = lme_srf.Coefficients.SE;
srf_p = lme_srf.Coefficients.pValue;
twre_swe_se = lme_twre_swe.Coefficients.SE;
twre_swe_p = lme_twre_swe.Coefficients.pValue;
twre_pde_se = lme_twre_pde.Coefficients.SE;
twre_pde_p = lme_twre_pde.Coefficients.pValue;
% extend intercept to components of estimates
for sess = 2:length(sessions)
    lwid_est(sess, 1) = (lwid_est(1,1) + lwid_est(sess, 1));
    wa_est(sess, 1) = (wa_est(1,1) + wa_est(sess, 1));
    or_est(sess, 1) = (or_est(1,1) + or_est(sess, 1));
    srf_est(sess, 1) = (srf_est(1,1) + srf_est(sess, 1));
    twre_swe_est(sess, 1) = (twre_swe_est(1,1) + twre_swe_est(sess, 1));
    twre_pde_est(sess, 1) = (twre_pde_est(1,1) + twre_pde_est(sess, 1));
end
% plot
plot(sessions', lwid_est, '-o', 'Color', dmap(1,:), 'MarkerFaceColor', dmap(1,:), 'LineWidth', 2, 'MarkerSize', 6, 'MarkerEdgeColor', dmap(1,:));
plot(sessions', wa_est, '-o', 'Color', dmap(2,:), 'MarkerFaceColor', dmap(2,:), 'LineWidth', 2, 'MarkerSize', 6, 'MarkerEdgeColor', dmap(2,:));

plot(sessions', or_est, '-o', 'Color', dmap(3,:), 'MarkerFaceColor', dmap(3,:), 'LineWidth', 2, 'MarkerSize', 6, 'MarkerEdgeColor', dmap(3,:));
plot(sessions', srf_est, '-o', 'Color', dmap(4,:), 'MarkerFaceColor', dmap(4,:), 'LineWidth', 2, 'MarkerSize', 6, 'MarkerEdgeColor', dmap(4,:));

plot(sessions', twre_swe_est, '-o', 'Color', dmap(5,:), 'MarkerFaceColor', dmap(5,:), 'LineWidth', 2, 'MarkerSize', 6, 'MarkerEdgeColor', dmap(5,:));
plot(sessions', twre_pde_est, '-o', 'Color', dmap(6,:), 'MarkerFaceColor', dmap(6,:), 'LineWidth', 2, 'MarkerSize', 6, 'MarkerEdgeColor', dmap(6,:));

% add error bars
errorbar(sessions', lwid_est, lwid_se, '.k', 'Color', dmap(1,:), 'LineWidth', 2);
errorbar(sessions', wa_est, wa_se, '.k', 'Color', dmap(2,:), 'LineWidth', 2);

errorbar(sessions', or_est, or_se, '.k', 'Color', dmap(3,:), 'LineWidth', 2);
errorbar(sessions', srf_est, srf_se, '.k', 'Color', dmap(4,:), 'LineWidth', 2);

errorbar(sessions', twre_swe_est, twre_swe_se, '.k', 'Color', dmap(5,:), 'LineWidth', 2);
errorbar(sessions', twre_pde_est, twre_pde_se, '.k', 'Color', dmap(6,:), 'LineWidth', 2);

%Format Plot
ax = gca;
ax.XLim = [-0.1 (max(sessions) + 0.1)];
ax.YLim = [70 100];
ax.XAxis.TickValues = sessions;
xlabel('Session'); ylabel('Standard Score');
title('Growth in Reading Skill');
grid('on');
legend(tests, 'Location', 'eastoutside');

%% Figure 1b
% plots a longitudinal plot of the basic reading skills measure
% with a trend line extracted from the linear mixed effects model
figure; hold;
plot(int_data.int_hours, int_data.wj_brs, '-k');   
axis('tight');
% format the plot nicely
ax = gca; ax.XLim = [0 160]; ax.YLim = [55 125];
ylabel('WJ BRS'); xlabel('Hours of Intervention');
ax.XAxis.TickValues = [0 40 80 120 160];
ax.YAxis.TickValues = [40 60 80 100 120 140];
grid('on')
% Add linear line of best fit
% fit model using hours as the time variable
lme_lwid = fitlme(int_data, 'wj_brs ~ 1 + int_hours_cen + (1|record_id) + (int_hours_cen - 1|record_id)');
plot(ax.XAxis.TickValues,polyval(flipud(lme_lwid.Coefficients.Estimate),ax.XAxis.TickValues),'--b','linewidth',3);

%% Figure 1c
% creates a histogram of the linear effects across all measures
% place estimates, standard errors, and p values in table
for test = 1:length(names)
    linear_data(test, :) = table(stats(test).name, stats(test).lme.Coefficients.Estimate(2), stats(test).lme.Coefficients.SE(2));
    linear_data.Properties.VariableNames = {'test_name', 'growth', 'se'};
end
% plot
figure; hold;
h = bar(linear_data.growth, 'FaceColor', 'w', 'EdgeColor', 'k');
errorbar(linear_data.growth, linear_data.se, 'kx');
% add p value astrisks
for test = 1:length(names)
    if stats(test).lme.Coefficients.pValue(2) <= 0.001
        text(test, linear_data.growth(test) + linear_data.se(test) + .002, ...
            '**', 'HorizontalAlignment', 'center', 'Color', 'b');
    elseif stats(test).lme.Coefficients.pValue(2) <= 0.05
        text(test,linear_data.growth(test) + linear_data.se(test) + .002, ...
            '*', 'HorizontalAlignment', 'center', 'Color', 'b');
    end
end
% Format
ylabel('Growth Estimate'); xlabel('Test Name');
ax = gca; axis('tight');
ax.XTick = 1:length(names);
ax.XTickLabel = names;
ax.XTickLabelRotation = 45;
title('Linear Growth Estimate by Test');