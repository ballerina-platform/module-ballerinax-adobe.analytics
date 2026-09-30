# Ballerina Adobe Analytics connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-adobe.analytics/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-adobe.analytics/actions/workflows/ci.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-adobe.analytics.svg)](https://github.com/ballerina-platform/module-ballerinax-adobe.analytics/commits/main)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/adobe.analytics.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%2Fadobe.analytics)

## Overview

[Adobe Analytics](https://business.adobe.com/products/analytics/adobe-analytics.html) is a web and digital analytics platform for collecting, segmenting and reporting on customer behavior across channels.

The Adobe Analytics connector lets Ballerina applications call the Adobe Analytics 2.0 API to run reports, manage segments, calculated metrics, projects, date ranges, annotations, tags and shares, browse dimensions and metrics, and read users and audit logs. It supports version 2.0 of the Adobe Analytics API.

## Setup guide

To use the Adobe Analytics connector, you need an Adobe Analytics product profile and access to the [Adobe Developer Console](https://developer.adobe.com/console).

### Step 1: Create a project and add the Analytics API

1. Sign in to the Adobe Developer Console and create a new project.
2. Choose **Add API**, select **Adobe Analytics**, and pick the OAuth Server-to-Server credential type.
3. Assign the credential to a product profile that has access to the report suites you want to use.

### Step 2: Note the credentials

Copy the **Client ID** (used as the API key) and the **Client Secret** from the credential page.

### Step 3: Generate an access token

Request an access token from Adobe IMS. Access tokens expire after 24 hours, so repeat this step to refresh it.

```bash
curl -X POST https://ims-na1.adobelogin.com/ims/token/v3 \
  -d "client_id=<Client ID>" \
  -d "client_secret=<Client Secret>" \
  -d "grant_type=client_credentials" \
  -d "scope=openid,AdobeID,additional_info.projectedProductContext"
```

### Step 4: Find your global company ID

Call the discovery endpoint with the access token and API key. The `globalCompanyId` in the response is the value the connector methods take as their first argument.

```bash
curl https://analytics.adobe.io/discovery/me \
  -H "Authorization: Bearer <access token>" \
  -H "x-api-key: <Client ID>"
```

## Quickstart

To use the Adobe Analytics connector in your Ballerina application, update the `.bal` file as follows:

### Step 1: Import the module

Import the `adobe.analytics` module.

```ballerina
import ballerinax/adobe.analytics;
```

### Step 2: Instantiate a new connector

1. Create a `Config.toml` file and configure the credentials obtained in the steps above:

```toml
accessToken = "<Access Token>"
apiKey = "<Client ID>"
companyId = "<Global Company ID>"
```

2. Create an `analytics:ApiKeysConfig` with the access token and API key, and initialize the connector with it.

```ballerina
configurable string accessToken = ?;
configurable string apiKey = ?;
configurable string companyId = ?;

final analytics:Client analyticsClient = check new ({
    authorization: "Bearer " + accessToken,
    xApiKey: apiKey
});
```

### Step 3: Invoke the connector operation

Now, utilize the available connector operations.

#### Get the current user

```ballerina
public function main() returns error? {
    analytics:AnalyticsUser _ = check analyticsClient->getCurrentUser(companyId);
}
```

### Step 4: Run the Ballerina application

```bash
bal run
```

## Examples

The Adobe Analytics connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-adobe.analytics/tree/main/examples/), covering the following use cases:

1. [Page traffic report](https://github.com/ballerina-platform/module-ballerinax-adobe.analytics/tree/main/examples/page_traffic_report) - Check that the page dimension and visits metric are available for a report suite, then run a ranked report of the most visited pages for a date range.

2. [Workspace asset audit](https://github.com/ballerina-platform/module-ballerinax-adobe.analytics/tree/main/examples/workspace_asset_audit) - Identify the authenticated user, collect all company users page by page, count visible projects and list calculated metrics.

## Build from the source

### Setting up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 21. You can download it from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

   > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

   > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,

    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal access token>
    ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

   ```bash
   ./gradlew clean build
   ```

2. To run the tests:

   ```bash
   ./gradlew clean test
   ```

3. To build the without the tests:

   ```bash
   ./gradlew clean build -x test
   ```

4. To run tests against different environments:

   ```bash
   ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
   ```

5. To debug the package with a remote debugger:

   ```bash
   ./gradlew clean build -Pdebug=<port>
   ```

6. To debug with the Ballerina language:

   ```bash
   ./gradlew clean build -PbalJavaDebug=<port>
   ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* For more information go to the [`adobe.analytics` package](https://central.ballerina.io/ballerinax/adobe.analytics/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
