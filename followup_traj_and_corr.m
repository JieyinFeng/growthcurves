% creates a graph correlating intervention driven growth and 
% follow up change scores for the 2016 summer group
% 18 kids
% Patrick M. Donnelly
% October 26th, 2017

% compute growth between sessions 4 and 5
% session 5
brs_s5 = int_data.wj_brs(int_data.int_session == 5);
rf_s5 = int_data.wj_rf(int_data.int_session == 5);
twre_s5 = int_data.twre_index(int_data.int_session == 5);
lwid_s5 = int_data.wj_lwid_raw(int_data.int_session == 5);
wa_s5 = int_data.wj_wa_raw(int_data.int_session == 5);
swe_s5 = int_data.twre_swe_raw(int_data.int_session == 5);
pde_s5 = int_data.twre_pde_raw(int_data.int_session == 5);
or_s5 = int_data.wj_or_ss(int_data.int_session == 5);
srf_s5 = int_data.wj_srf_ss(int_data.int_session == 5);
% session 4
brs_s4 = int_data.wj_brs(int_data.int_session == 4);
rf_s4 = int_data.wj_rf(int_data.int_session == 4);
twre_s4 = int_data.twre_index(int_data.int_session == 4);
lwid_s4 = int_data.wj_lwid_raw(int_data.int_session == 4);
wa_s4 = int_data.wj_wa_raw(int_data.int_session == 4);
swe_s4 = int_data.twre_swe_raw(int_data.int_session == 4);
pde_s4 = int_data.twre_pde_raw(int_data.int_session == 4);
or_s4 = int_data.wj_or_ss(int_data.int_session == 4);
srf_s4 = int_data.wj_srf_ss(int_data.int_session == 4);
% change scores
brs_change = brs_s5 - brs_s4;
rf_change = rf_s5 - rf_s4;
twre_change = twre_s5 - twre_s4;
lwid_change = lwid_s5 - lwid_s4;
wa_change = wa_s5 - wa_s4;
swe_change = swe_s5 - swe_s4;
pde_change = pde_s5 - pde_s4;
or_change = or_s5 - or_s4;
srf_change = srf_s5 - srf_s4;

% compute RTI variable
% use only the intervention sessions
sessions = [1 2 3 4];
sess_indx = ismember(int_data.int_session, sessions);
int_data = int_data(sess_indx,:);
% append centered hours variable
int_data.int_sess_cen = center(int_data, 'int_session', 'record_id');
% Calculate individual slope estimates
s = unique(int_data.record_id);
for sub = 1:length(s)
    sub_indx = ismember(int_data.record_id, s(sub));
    indiv_slopes_brs(sub,:) = polyfit(int_data.int_sess_cen(sub_indx, :)-1, ...
        int_data.wj_brs(sub_indx, :), 1);
    indiv_slopes_rf(sub,:) = polyfit(int_data.int_sess_cen(sub_indx, :)-1, ...
        int_data.wj_rf(sub_indx, :), 1);
    indiv_slopes_twre(sub,:) = polyfit(int_data.int_sess_cen(sub_indx, :)-1, ...
        int_data.twre_index(sub_indx, :), 1);
    indiv_slopes_lwid(sub,:) = polyfit(int_data.int_sess_cen(sub_indx, :)-1, ...
        int_data.wj_lwid_raw(sub_indx, :), 1);
    indiv_slopes_wa(sub,:) = polyfit(int_data.int_sess_cen(sub_indx, :)-1, ...
        int_data.wj_wa_raw(sub_indx, :), 1);
    indiv_slopes_swe(sub,:) = polyfit(int_data.int_sess_cen(sub_indx, :)-1, ...
        int_data.twre_swe_raw(sub_indx, :), 1);
    indiv_slopes_pde(sub,:) = polyfit(int_data.int_sess_cen(sub_indx, :)-1, ...
        int_data.twre_pde_raw(sub_indx, :), 1);
    indiv_slopes_or(sub,:) = polyfit(int_data.int_sess_cen(sub_indx, :)-1, ...
        int_data.wj_or_ss(sub_indx, :), 1);
    indiv_slopes_srf(sub,:) = polyfit(int_data.int_sess_cen(sub_indx, :)-1, ...
        int_data.wj_srf_ss(sub_indx, :), 1);
end
rti_brs = indiv_slopes_brs(:,1);
rti_rf = indiv_slopes_rf(:,1);
rti_twre = indiv_slopes_twre(:,1);
rti_lwid = indiv_slopes_lwid(:,1);
rti_wa = indiv_slopes_wa(:,1);
rti_swe = indiv_slopes_swe(:,1);
rti_pde = indiv_slopes_pde(:,1);
rti_or = indiv_slopes_or(:,1);
rti_srf = indiv_slopes_srf(:,1);

figure; hold;
suptitle('Comparing Intervention Slopes and Follow Up Change Scores');
subplot(3,3,1);
scatter(rti_brs, brs_change, 'MarkerFaceColor', ifsig(brs_change, rti_brs)); lsline; 
grid('on'); axis('tight');
% xlim([50 120]); ylim([-2 12]); xticks([50 60 70 80 90 100 110 120]);
ylabel('Follow Up Change'); xlabel('Intervention Growth Rate (BRS)');

subplot(3,3,2);
scatter(rti_rf, rf_change, 'MarkerFaceColor', ifsig(rf_change, rti_rf)); lsline; 
grid('on'); axis('tight');
% xlim([50 120]); ylim([-2 8]); xticks([50 60 70 80 90 100 110 120]);
ylabel('Follow Up Change'); xlabel('Intervention Growth Rate (RF)');

subplot(3,3,3);
scatter(rti_twre, twre_change, 'MarkerFaceColor', ifsig(twre_change, rti_twre)); lsline; 
grid('on'); axis('tight');
% xlim([50 120]); ylim([-2 8]); xticks([50 60 70 80 90 100 110 120]);
ylabel('Follow Up Change'); xlabel('Intervention Growth Rate (TOWRE)');

subplot(3,3,4);
scatter(rti_lwid, lwid_change, 'MarkerFaceColor', ifsig(rti_lwid, lwid_change)); lsline; 
grid('on'); axis('tight');
% xlim([50 120]); ylim([-2 12]); xticks([50 60 70 80 90 100 110 120]);
ylabel('Follow Up Change'); xlabel('Intervention Growth Rate (LWIDraw)');

subplot(3,3,5);
scatter(rti_wa, wa_change, 'MarkerFaceColor', ifsig(rti_wa, wa_change)); lsline; 
grid('on'); axis('tight');
% xlim([50 120]); ylim([-2 8]); xticks([50 60 70 80 90 100 110 120]);
ylabel('Follow Up Change'); xlabel('Intervention Growth Rate (WAraw)');

subplot(3,3,6);
scatter(rti_swe, swe_change, 'MarkerFaceColor', ifsig(rti_swe, swe_change)); lsline; 
grid('on'); axis('tight');
% xlim([50 120]); ylim([-2 8]); xticks([50 60 70 80 90 100 110 120]);
ylabel('Follow Up Change'); xlabel('Intervention Growth Rate (SWEraw)');

subplot(3,3,7);
scatter(rti_pde, pde_change, 'MarkerFaceColor', ifsig(rti_pde, pde_change)); lsline; 
grid('on'); axis('tight');
% xlim([50 120]); ylim([-2 12]); xticks([50 60 70 80 90 100 110 120]);
ylabel('Follow Up Change'); xlabel('Intervention Growth Rate (PDEraw)');

subplot(3,3,8);
scatter(rti_or, or_change, 'MarkerFaceColor', ifsig(rti_or, or_change)); lsline; 
grid('on'); axis('tight');
% xlim([50 120]); ylim([-2 8]); xticks([50 60 70 80 90 100 110 120]);
ylabel('Follow Up Change'); xlabel('Intervention Growth Rate (OR)');

subplot(3,3,9);
scatter(rti_srf, srf_change, 'MarkerFaceColor', ifsig(rti_srf, srf_change)); lsline; 
grid('on'); axis('tight');
% xlim([50 120]); ylim([-2 8]); xticks([50 60 70 80 90 100 110 120]);
ylabel('Follow Up Change'); xlabel('Intervention Growth Rate (SRF)');

