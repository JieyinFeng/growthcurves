% run the preprocess_revision script
preprocess_revision;

% Interaction
[stats_int_brs] = fitlme(case_cntrl_data, 'wj_brs ~ 1 + int_days_cen + int_days_cen*group + (1|record_id) + (int_days_cen - 1|record_id)');
[stats_int_rf] = fitlme(case_cntrl_data, 'wj_rf ~ int_days_cen*group + (1|record_id) + (int_days_cen - 1|record_id)')
[stats_int_rf_1] = fitlme(case_cntrl_data(case_cntrl_data.group==1,:), 'wj_rf ~ 1 + int_days_cen + (1|record_id) + (int_days_cen - 1|record_id)')
[stats_int_rf_0] = fitlme(case_cntrl_data(case_cntrl_data.group==0,:), 'wj_rf ~ 1 + int_days_cen + (1|record_id) + (int_days_cen - 1|record_id)')
[stats_int_twre] = fitlme(case_cntrl_data, 'twre_index ~ 1 + int_days_cen + int_days_cen*group + (1|record_id) + (int_days_cen - 1|record_id)')
[stats_int_mcs] = fitlme(case_cntrl_data, 'wj_mcs ~ 1 + int_days_cen + int_days_cen*group + (1|record_id) + (int_days_cen - 1|record_id)')


[stats_int_srf] = fitlme(case_cntrl_data, 'wj_srf_ss ~ int_days_cen*group + (1|record_id) + (int_days_cen - 1|record_id)')
[stats_int_srf_1] = fitlme(case_cntrl_data(case_cntrl_data.group==1,:), 'wj_srf_ss ~ 1 + int_days_cen + (1|record_id) + (int_days_cen - 1|record_id)')
[stats_int_srf_0] = fitlme(case_cntrl_data(case_cntrl_data.group==0,:), 'wj_srf_ss ~ 1 + int_days_cen + (1|record_id) + (int_days_cen - 1|record_id)')