# Workspace asset audit

This example identifies the authenticated user, collects every user of the company page by page, counts the visible projects and lists the calculated metrics. It only reads data.

## Prerequisites

### 1. Set up Adobe Analytics API access

Follow the [Setup guide](https://github.com/ballerina-platform/module-ballerinax-adobe.analytics/blob/main/ballerina/README.md#setup-guide) to obtain an access token and API key, and find your global company ID.

### 2. Configuration

Create a `Config.toml` file in this example's directory with the following content:

```toml
accessToken = "<access-token>"
apiKey = "<api-key>"
companyId = "<global-company-id>"
pageSize = 50
```

## Run the example

Execute the following command to run the example:

```bash
bal run
```
