# Running Tests

## Prerequisites

To run the tests against the live Adobe Analytics API you need an access token, the API key (client ID) of the Adobe Developer Console credential, your global company ID and a report suite ID. Follow the [Setup guide](https://github.com/ballerina-platform/module-ballerinax-adobe.analytics/blob/main/ballerina/README.md#setup-guide) to obtain them.

## Test approach

The tests call 25 client operations covering annotations, calculated metrics, segments, projects, date ranges, dimensions, metrics, reports and users. By default they run against a local mock service (`tests/mock_service.bal`) that listens on port 9090. Tests that create, update or delete data are skipped against the live API.

## Running the tests

### Against the mock service

```bash
bal test
```

### Against the live API

Set the following environment variables and enable the live server:

```bash
export IS_LIVE_SERVER=true
export ADOBE_ANALYTICS_ACCESS_TOKEN=<access token>
export ADOBE_ANALYTICS_API_KEY=<client ID>
export ADOBE_ANALYTICS_COMPANY_ID=<global company ID>
export ADOBE_ANALYTICS_RSID=<report suite ID>
bal test --groups live_tests
```
