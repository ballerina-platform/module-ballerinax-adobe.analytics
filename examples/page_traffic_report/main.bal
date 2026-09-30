// Report the most visited pages of a report suite for a date range.

import ballerina/io;
import ballerinax/adobe.analytics;

configurable string accessToken = ?;
configurable string apiKey = ?;
configurable string companyId = ?;
configurable string reportSuiteId = ?;
configurable string dateRange = ?;
configurable int rowLimit = 10;

const string PAGE_DIMENSION = "variables/page";
const string VISITS_METRIC = "metrics/visits";

public function main() returns error? {
    analytics:Client analyticsClient = check new (
        {authorization: "Bearer " + accessToken, xApiKey: apiKey}
    );

    // Step 1: Confirm the page dimension is available for the report suite
    analytics:AnalyticsDimension[] dimensions = check analyticsClient->getDimensionsForReportSuite(companyId, rsid = reportSuiteId);
    boolean dimensionFound = false;
    foreach analytics:AnalyticsDimension dimension in dimensions {
        if dimension?.id == PAGE_DIMENSION {
            dimensionFound = true;
            break;
        }
    }
    if !dimensionFound {
        return error("Dimension " + PAGE_DIMENSION + " is not available for report suite " + reportSuiteId);
    }

    // Step 2: Confirm the visits metric is available
    analytics:AnalyticsMetric[] metrics = check analyticsClient->getMetricsForReportSuite(companyId, rsid = reportSuiteId);
    boolean metricFound = false;
    foreach analytics:AnalyticsMetric metric in metrics {
        if metric?.id == VISITS_METRIC {
            metricFound = true;
            break;
        }
    }
    if !metricFound {
        return error("Metric " + VISITS_METRIC + " is not available for report suite " + reportSuiteId);
    }

    // Step 3: Run a ranked report of visits by page
    analytics:RankedReportData report = check analyticsClient->runReport(companyId, {
        rsid: reportSuiteId,
        dimension: PAGE_DIMENSION,
        globalFilters: [{'type: "dateRange", dateRange: dateRange}],
        metricContainer: {metrics: [{columnId: "0", id: VISITS_METRIC, sort: "desc"}]},
        settings: {'limit: <int:Signed32>rowLimit, page: 0}
    });

    io:println("Report ID: ", report?.reportId ?: "unknown");
    analytics:Row[] rows = report?.rows ?: [];
    foreach analytics:Row row in rows {
        decimal[] data = row?.data ?: [];
        decimal visits = data.length() > 0 ? data[0] : 0d;
        io:println(row?.value ?: "(unknown)", ": ", visits, " visits");
    }
}
