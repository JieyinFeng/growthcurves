% run preprocess_revision
preprocess_revision;
%% condense to summer data
% load data and filter for summer group
summer_group = sub_map('summer');
summer_indx = ismember(int_data.record_id, summer_group);
summer_data = int_data(summer_indx, :);
% get rid of irrelevant columns
summer_data.score = [];
% add iq score for subject 72
% find 197_BK
iq_col = find(ismember(summer_data.record_id, 72));
select = summer_data(iq_col, :);
% find first intervention session
temp2 = find(ismember(select.study_name, 0));
location = (iq_col(temp2));
summer_data{location,30} = 48;
summer_data{location,31} = 44;
summer_data{location,32} = 93;
%% extract predictor variables
% intial reading score
brs_init = summer_data.wj_brs(summer_data.int_session == 1);
% wasi score
iq = summer_data.wasi_fs2(summer_data.int_session == 0);
iq_mr = summer_data.wasi_mr_ts(summer_data.int_session == 0);
iq_vocab = summer_data.wasi_vocab_ts(summer_data.int_session == 0);
% three subjects had multiple baselines
iq = iq(isnan(iq) == 0);
iq_mr = iq_mr(isnan(iq_mr) == 0);
iq_vocab = iq_vocab(isnan(iq_vocab) == 0);
% discrepancy score
discrep = iq - brs_init;
% rapid naming
rapid = summer_data.ctopp_rapid(summer_data.int_session == 0);
subs = unique(summer_data.record_id);
empty_scores = [];
for sub = 1:length(subs)
   sub_indx = find(ismember(summer_data.record_id(summer_data.int_session == 0), subs(sub)));
   if numel(sub_indx) == 1 && isnan(rapid(sub_indx(1)))
       empty_scores = vertcat(empty_scores, sub_indx(1));
   elseif numel(sub_indx) > 1 && ~isnan(rapid(sub_indx(2)))
       rapid(sub_indx(2)) = NaN;
   end
end
rapid(empty_scores(1)) = 82;
rapid(empty_scores(2)) = 79;
rapid = rapid(~isnan(rapid));
% Age
age = summer_data.visit_age(summer_data.int_session == 1);
% Elision
elision = summer_data.ctopp_elision_ss(summer_data.int_session == 0);
subs = unique(summer_data.record_id);
empty_scores = [];
for sub = 1:length(subs)
   sub_indx = find(ismember(summer_data.record_id(summer_data.int_session == 0), subs(sub)));
   if numel(sub_indx) == 1 && isnan(elision(sub_indx(1)))
       empty_scores = vertcat(empty_scores, sub_indx(1));
   elseif numel(sub_indx) > 1 && ~isnan(elision(sub_indx(2)))
       elision(sub_indx(2)) = NaN;
   end
end
elision(empty_scores(1)) = 9;
elision(empty_scores(2)) = 6;
elision = elision(~isnan(elision));
%% Zero in on intervention sessions (no baseline)
sessions = [1 2 3 4];
sess_indx = ismember(summer_data.int_session, sessions);
summer_data = summer_data(sess_indx,:);
% center time variables
summer_data.int_sess_cen = center(summer_data, 'int_session', 'record_id');
summer_data.int_hours_cen = center(summer_data, 'int_hours', 'record_id');
%% Create predictor columns
% expand to 4 columns
quad_brs_init = horzcat(brs_init, brs_init, brs_init, brs_init);
quad_iq = horzcat(iq, iq, iq, iq);
quad_iq_mr = horzcat(iq_mr, iq_mr, iq_mr, iq_mr); 
quad_iq_vocab = horzcat(iq_vocab,iq_vocab,iq_vocab,iq_vocab);
quad_discrep = horzcat(discrep, discrep, discrep, discrep);
quad_rapid = horzcat(rapid, rapid, rapid, rapid);
quad_elision = horzcat(elision, elision, elision, elision);
% intialize column arrays
brs_init_col = []; iq_col = []; iq_mr_col = []; iq_vocab_col = [];
discrep_col = []; rapid_col = []; elision_col = [];
% loop through and collapse rows to single columns
ii = 1;
for jj = 1:length(iq)
    for kk = 1:length(sessions)
        brs_init_col(ii, 1) = quad_brs_init(jj, kk);
        iq_col(ii, 1) = quad_iq(jj, kk);
        iq_mr_col(ii, 1) = quad_iq_mr(jj, kk);
        iq_vocab_col(ii, 1) = quad_iq_vocab(jj, kk);
        discrep_col(ii, 1) = quad_discrep(jj, kk);
        rapid_col(ii, 1) = quad_rapid(jj, kk);
        elision_col(ii, 1) = quad_elision(jj,kk);
        ii = ii+1;
    end
end
% append to summer data table
summer_data.brs_init = brs_init_col(:,1);
summer_data.iq = iq_col(:,1);
summer_data.iq_mr = iq_mr_col(:,1);
summer_data.iq_vocab = iq_vocab_col(:,1);
summer_data.discrep = discrep_col(:,1);
summer_data.rapid = rapid_col(:,1);
summer_data.elision = elision_col(:,1);

%% LME analysis
% WJ_BRS
fitlme(summer_data, 'wj_brs ~ 1 + int_sess_cen + int_sess_cen*brs_init + (1|record_id) + (int_sess_cen - 1|record_id)')
fitlme(summer_data, 'wj_brs ~ 1 + int_sess_cen + int_sess_cen*iq + (1|record_id) + (int_sess_cen - 1|record_id)')
fitlme(summer_data, 'wj_brs ~ 1 + int_sess_cen + int_sess_cen*discrep + (1|record_id) + (int_sess_cen - 1|record_id)')
% WJ_RF
fitlme(summer_data, 'wj_rf ~ 1 + int_sess_cen + int_sess_cen*brs_init + (1|record_id) + (int_sess_cen - 1|record_id)')
fitlme(summer_data, 'wj_rf ~ 1 + int_sess_cen + int_sess_cen*iq + (1|record_id) + (int_sess_cen - 1|record_id)')
fitlme(summer_data, 'wj_rf ~ 1 + int_sess_cen + int_sess_cen*discrep + (1|record_id) + (int_sess_cen - 1|record_id)')
% TWRE_INDEX
fitlme(summer_data, 'twre_index ~ 1 + int_sess_cen + int_sess_cen*brs_init + (1|record_id) + (int_sess_cen - 1|record_id)')
fitlme(summer_data, 'twre_index ~ 1 + int_sess_cen + int_sess_cen*iq + (1|record_id) + (int_sess_cen - 1|record_id)')
fitlme(summer_data, 'twre_index ~ 1 + int_sess_cen + int_sess_cen*discrep + (1|record_id) + (int_sess_cen - 1|record_id)')




