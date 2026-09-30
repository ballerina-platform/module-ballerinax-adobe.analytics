_Author_:  @DimuthuMadushan \
_Created_: 30-09-2026 \
_Updated_: 30-09-2026 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from Adobe Analytics.
The OpenAPI specification is obtained from [wso2/api-specs](https://github.com/wso2/api-specs/blob/main/openapi/adobe/analytics/2.0/openapi.json).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.

## Sanitization Details

1. **Authentication moved from header parameters to security schemes**
   - **Original**: The specification has no `securityDefinitions`. Every operation declares two header parameters, `Authorization` and `x-api-key`, described with an OpenAPI 3 style `schema` (invalid in Swagger 2.0).
   - **Updated**: The two header parameters are removed from every operation and replaced by two `apiKey` security schemes, `authorization` (header `Authorization`, the value is `Bearer <access token>`) and `apiKey` (header `x-api-key`), both required through a single top-level `security` requirement. The client therefore takes an `ApiKeysConfig` with `authorization` and `xApiKey`.
   - **Reason**: Without a security scheme the generated client has no `auth`. An OAuth 2.0 scheme cannot be combined with the `x-api-key` header in one requirement, because the generator turns the two into alternatives and the API key would be dropped.

2. **Missing path parameter added**
   - **Original**: `GET /{globalCompanyId}/users/me` does not declare `globalCompanyId`.
   - **Updated**: Added the `globalCompanyId` path parameter to the path item.
   - **Reason**: `bal openapi` rejects a path placeholder that has no parameter.

3. **Server URL scheme**
   - **Original**: `host` and `basePath` with no `schemes`, which flatten turns into `//analytics.adobe.io/api`.
   - **Updated**: `https://analytics.adobe.io/api`, re-applied by `fix_aligned.py` after every align.
   - **Reason**: The API is served over HTTPS only.

4. **Audit log response media type**
   - **Original**: `GET /{globalCompanyId}/auditlogs/usage` declares `*/*` for its 200 response.
   - **Updated**: `application/json`, re-applied by `fix_aligned.py`.
   - **Reason**: A `*/*` response generates an `http:Response` return instead of the typed page.

5. **Missing operation descriptions**
   - **Original**: 34 operations have an empty `description`.
   - **Updated**: The description is the operation summary, re-applied by `fix_aligned.py`.
   - **Reason**: Generated method documentation would otherwise be empty.

6. **Operation names kept from the 1.x connector**
   - **Original**: operationIds such as `segments_getSegments` or `getAnnotations_1`.
   - **Updated**: Where the 1.x connector exposed the same method and path, its method name is reused (for example `findCalculatedMetrics`, `getDimensionsForReportSuite`); the remaining six operations use `list*/get*/create*/update*/delete*` names. The decisions are stored in `ai-mappings.json`.
   - **Reason**: Keeps existing call sites working where the endpoint is unchanged.

7. **Response and body shapes corrected**
   - **Original**: `POST /{globalCompanyId}/segments/validate` takes a body typed `string`, `GET /{globalCompanyId}/annotations` and `GET /{globalCompanyId}/dateranges` return a single object, and `GET /{globalCompanyId}/metrics` returns a single `AnalyticsMetric`.
   - **Updated**: The `validateSegment` body is `AnalyticsSegmentDefinition` (sent as a JSON object, not a JSON-encoded string). `listAnnotations` returns the new page schema `ResponsePageAnalyticsAnnotation` and `getDateRangesForUser` returns `ResponsePageExpandedDateRange`, both with `content` and the same pagination fields as `ResponsePageUsageLogDto`. `getMetricsForReportSuite` returns an array of `AnalyticsMetric`.
   - **Reason**: These are collection or object-bodied endpoints, and the generated types must match what is sent and received.

7a. **Known limitation: other list operations that return one object**
   - **Original**: `GET` segments is declared to return a single object, not a collection.
   - **Updated**: Left as declared; the generated method returns the declared record.
   - **Reason**: The correct response shape is not established by the specification, so no schema was invented.

8. **Known difference from the api-specs copy**
   - The copy on the `wso2/api-specs` `incubator` branch (`openapi/adobe/analytics/2.0/openapi.json`) lacks the `parameters` section that its operations reference, uses `basePath` `/`, and omits several `AnalyticsDimension` properties (`allocationType`, `expirationType`, `attributionModel`, `dataType`, `expirationCustomDays`, `ecomAllocationType`, `bindingEvents`, `merchandisingSyntax`). The specification in this repository contains them; the copy on `main` does not exist yet.

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/aligned_ballerina_openapi.json -o ballerina --mode client --license docs/license.txt --client-methods remote
```

Note: The license year is hardcoded to 2026, change if necessary.
