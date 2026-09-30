# Change Log

This file contains all the notable changes done to the Ballerina Adobe Analytics connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Annotation operations: `listAnnotations`, `createAnnotation`, `getAnnotation`, `updateAnnotation` and `deleteAnnotation`.
- The `runRealtimeReport` operation.

### Changed

- Every operation now takes the global company ID as its first argument (`globalCompanyId`), because the Adobe Analytics
  2.0 API scopes all endpoints under `/{globalCompanyId}`.
- The client now authenticates with an `ApiKeysConfig` holding the `authorization` header value (`"Bearer <token>"`)
  and the `xApiKey` header value, both of which the API requires on every call. It replaces the 1.x
  `http:BearerTokenConfig|OAuth2RefreshTokenGrantConfig` `auth` field.
- The default service URL is now `https://analytics.adobe.io/api`.
- Operation names from 1.x are kept where the same endpoint exists. Response and payload record types follow the 2.0
  specification.

- `validateSegment` takes an `AnalyticsSegmentDefinition` payload instead of a `string`, so the body is sent as a JSON
  object.
- `listAnnotations` and `getDateRangesForUser` return page records (`ResponsePageAnalyticsAnnotation`,
  `ResponsePageExpandedDateRange`) with `content` and pagination fields, and `getMetricsForReportSuite` returns
  `AnalyticsMetric[]`.

### Removed

- `listReportSuites` and `getReportSuite`, which are not part of the current API specification.
