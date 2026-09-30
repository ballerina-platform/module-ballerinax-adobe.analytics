# Page traffic report

This example checks that the page dimension and the visits metric are available for a report suite, then runs a ranked report and prints the most visited pages for a date range.

## Prerequisites

### 1. Set up Adobe Analytics API access

Follow the [Setup guide](https://github.com/ballerina-platform/module-ballerinax-adobe.analytics/blob/main/ballerina/README.md#setup-guide) to obtain an access token and API key, and find your global company ID and report suite ID.

### 2. Configuration

Create a `Config.toml` file in this example's directory with the following content:

```toml
accessToken = "<access-token>"
apiKey = "<api-key>"
companyId = "<global-company-id>"
reportSuiteId = "<report-suite-id>"
dateRange = "<date-range, e.g. 2026-09-01T00:00:00.000/2026-09-08T00:00:00.000>"
rowLimit = 10
```

## Run the example

Execute the following command to run the example:

```bash
bal run
```
