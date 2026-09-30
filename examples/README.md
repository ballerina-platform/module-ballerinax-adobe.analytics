# Examples

The `ballerinax/adobe.analytics` connector provides practical examples illustrating usage in various scenarios.

1. **[Page traffic report](https://github.com/ballerina-platform/module-ballerinax-adobe.analytics/tree/main/examples/page_traffic_report)** - Check that the page dimension and visits metric are available for a report suite, then run a ranked report of the most visited pages for a date range.

2. **[Workspace asset audit](https://github.com/ballerina-platform/module-ballerinax-adobe.analytics/tree/main/examples/workspace_asset_audit)** - Identify the authenticated user, collect all company users page by page, count visible projects and list calculated metrics.

## Prerequisites

1. Obtain an access token and API key for Adobe Analytics as described in the [Setup guide](https://github.com/ballerina-platform/module-ballerinax-adobe.analytics/blob/main/ballerina/README.md#setup-guide).

2. For each example, create a `Config.toml` file with the related configuration. Here's an example of how your Config.toml file should look:

```toml
accessToken = "<access-token>"
apiKey = "<api-key>"
companyId = "<global-company-id>"
```

Each example lists the additional values it needs in its own README.

## Running an example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the examples with the local module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

    ```bash
    ./build.sh build
    ```

* To run all the examples:

    ```bash
    ./build.sh run
    ```
