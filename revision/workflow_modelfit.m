%% Model Fit Workflow for Donnelly, 17 Revision
%
% Workflow as outlined by MathWorks on the Linear Mixed Model documentation
% Model fit is calculated using the Basic Reading Skills composite measure
% 
% Patrick Donnelly, University of Washington, November 6th, 2017

% run preprocess.m
preprocess;

% create data table with BRS composite
score = int_data.wj_brs;
hours_cen = int_data.int_hours_cen;
hours = int_data.int_hours;
subject = int_data.record_id;

data = table(subject, hours_cen, hours, score);
data.Properties.VariableNames = {'subject', 'hours_cen', 'hours', 'score'};

% fit simple linear fit
lme_1 = fitlme(data, 'score ~ 1 + hours + (1|subject)');
% plot residuals
plotResiduals(lme_1,'fitted');

% fit simple linear fit with independent random term for time grouped by
% subject
lme_2 = fitlme(data, 'score ~ 1 + hours + (1|subject) + (hours-1|subject)');

% compare models 1 & 2
compare(lme_1, lme_2, 'CheckNesting', true)

% with an additional random effect term
lme_3 = fitlme(data, 'score ~ 1 + hours + (1|subject) + (1|hours)');

% compare models 1 and 3
compare(lme_1, lme_3)

% check for correlation between random effects terms
lme_4 = fitlme(data, 'score ~ 1 + hours + (1+hours|subject)');
% correlation exists, albeit not significant

% compare models 1 & 4
compare(lme_1, lme_4, 'CheckNesting', true)
% better than 1, but need to check with lme_2

% compare models 2 & 4
compare(lme_2, lme_4, 'CheckNesting', true)
% lme_2 is the stronger fit

% git rid of intercept from correlation term in lme_4
lme_5 = fitlme(data, 'score ~ 1 + hours + (hours-1|subject)');
% overparamaterized

% add quadratic term to lme_2
lme_quad = fitlme(data, 'score ~ 1 + hours^2 + (1|subject) + (hours-1|subject)');

% add a cubic term to lme_quad
lme_cube = fitlme(data, 'score ~ 1 + hours^2 + hours^3 + (1|subject) + (hours-1|subject)');

% plot the fitted responses
F = fitted(lme_2);
R = response(lme_2);
figure();
plot(R,F,'rx')
xlabel('Response')
ylabel('Fitted')


