%% LME data input for RedCap transition
% Patrick Donnelly; University of Washington
% June 28th, 2017
%% Read in files
lmb_subs = readtable('C:\Users\Patrick\Desktop\lmb_subs.xlsx');
lmb_data = readtable('C:\Users\Patrick\Desktop\lmb_data.xlsx');
data = outerjoin(lmb_subs, lmb_data);
% gather column headings
data_ref = data.Properties.VariableNames;
% isolate lmb participants
subs = unique(data.record_id_lmb_data)'; 
subs = subs(isnan(subs)==0)';
nlr_id = unique(data.nlr_id);
nlr_id = nlr_id(2:end, :);
sid = unique(data.sid);
sid = sid(2:end, :);
% add '\' preceding each "_" for nicer looking titles/formatting
data_ref = strrep(data_ref, '_', '\_');
%% Specify Intervention Group, if applicable
usesubs = [2,9,35,37,44,45,46,49,51,52,57,81,82,83,84,228,234,235,237,248];
excluded = [75,76,77,78,79,80,81]; 
%% Specify Control Group
cntrlsubs = {5,19,21,23,25,26,29,32,33,36,64,66,70,72,275}';
cntrlsubs = cell2mat(cntrlsubs);
%% condense data table to necessary information
indx = ismember(data.record_id_lmb_data, usesubs);
cntrl_indx = ismember(data.record_id_lmb_data,cntrlsubs);
int_data = data(indx,6:end);
cntrl_data = data(cntrl_indx,6:end);
%% Concentrate on sessions of interest, if applicable
usesessions = [1 2 3 4];
sess_indx = ismember(int_data.int_session, usesessions);
cntrl_sess_indx = ismember(cntrl_data.int_session, usesessions);
int_data = int_data(sess_indx, :);
cntrl_data = cntrl_data(cntrl_sess_indx, :);



