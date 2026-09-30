// Audit the users, projects and calculated metrics of an Adobe Analytics company.

import ballerina/io;
import ballerinax/adobe.analytics;

configurable string accessToken = ?;
configurable string apiKey = ?;
configurable string companyId = ?;
configurable int pageSize = 50;

public function main() returns error? {
    analytics:Client analyticsClient = check new (
        {authorization: "Bearer " + accessToken, xApiKey: apiKey}
    );

    // Step 1: Identify the authenticated user
    analytics:AnalyticsUser me = check analyticsClient->getCurrentUser(companyId);
    io:println("Signed in as: ", me?.login ?: "unknown");

    // Step 2: Collect every user, following pages until a short page is returned
    analytics:AnalyticsUser[] users = [];
    int page = 0;
    while true {
        analytics:AnalyticsUser[] batch = check analyticsClient->listAllUsersForCompany(companyId, 'limit = pageSize, page = page);
        users.push(...batch);
        if batch.length() < pageSize {
            break;
        }
        page += 1;
    }
    int disabledUsers = users.filter(u => u?.disabled ?: false).length();
    io:println("Users: ", users.length(), " (", disabledUsers, " disabled)");

    // Step 3: Count the projects the user can see
    analytics:AnalyticsProject[] projects = check analyticsClient->getProjectsOfUser(companyId, includeType = ["all"]);
    io:println("Projects: ", projects.length());

    // Step 4: List the calculated metrics
    analytics:AnalyticsCalculatedMetric[] calculatedMetrics = check analyticsClient->findCalculatedMetrics(companyId);
    foreach analytics:AnalyticsCalculatedMetric metric in calculatedMetrics {
        io:println("Calculated metric: ", metric?.name ?: "(unnamed)", " [", metric?.id ?: "", "]");
    }
}
