# Data Studio Data Registry
A registry of data sources, categories, and organizations to use with [Data Studio Community Connectors](https://developers.google.com/datastudio/connector/overview).

The registry contains the following resources:

| Path                  | Description |
| --------              | ----------- |
| `sources/`            | Data source definitions and associated metadata.|
| `categories.json`     | Metadata about data source categories.|
| `organizations/`      | Organization definitions and associated metadata.|

**Important**: This is not a connector registry. This registry is used to define data sources. For example, if you build a Google Analytics connector, the data source defined in this registry would be for Google Analytics and the organization is Google. Your connector and company details should be defined in your [Community Connector Manifest](https://developers.google.com/datastudio/connector/manifest), not in this registry.

## How to use the registry

Use the registry to populate the [`sources`](https://developers.google.com/datastudio/connector/manifest#sources_ref) property of your [Community Connector Manifest](https://developers.google.com/datastudio/connector/manifest).

For example, if your connector fetches data from Google Analytics then find the Google Analytics source definition ([***google_analytics.json***](https://github.com/googledatastudio/ds-data-registry/blob/master/sources/google_analytics.json)) in the [***sources***](https://github.com/googledatastudio/ds-data-registry/tree/master/sources) directory. In your Community Connector manifest, use the value of the data source `id` property, `GOOGLE_ANALYTICS`.

Example snippet of a Community Connector manifest using the Google Analytics source Id:
```
    "dataStudio": {
        // ... manifest details
        sources: ['GOOGLE_ANALYTICS']
    }
```

If no matching source definition exists for your connector then add a new source.

## Add a source

If you can't find an appropriate source for your connector in the data registry then send a pull request to add a new source.

**Important**: This is not a connector registry. Sources should describe data and the source generating that data. Before sending a pull request consider the source of the data and whether you're describing the connector or the underlying data source.

1. Under the ***sources*** directory create a new JSON file for your source. Use lowercase characters and underscores for spaces. The filename should match the Id property of the source definition.
2. Define the source using the following format:
```
{
  "id": "SOURCE_ID",
  "name": "Source name",
  "categories": ["CATEGORIES"],
  "organization": "ORG_NAME",
  "iconUrl": "https://imageUrl",
  "sourceUrl": "https://sourceUrl",
  "dataVisibility": ["PRIVATE"]
}
```

| Property          | Description |
| --------          | ------------ |
| id                | A unique Id. This is used in the [`sources`](https://developers.google.com/datastudio/connector/manifest#sources_ref) property of Community Connector manifests. |
| name              | The user-friendly name of the source. |
| categories        | A list of Category Ids. This is used to associate the source with general categories such as Marketing, Advertising, etc. Category Ids must be defined in the [***categories.json***](https://github.com/googledatastudio/ds-data-registry/blob/master/categories.json) registry file.
| organization      | An organization Id that represents the entity responsible for this source. This is used to associate a source with a top-level organization (E.g. a company or developer). Organization Ids must be defined in the [***organizations.json***](https://github.com/googledatastudio/ds-data-registry/blob/master/organizations.json) registry file.
| iconUrl           | A link to an icon image representing this source. Recommended dimensions are 40px by 40px. It is your responsibility to review and comply with all applicable third party TOS.
| sourceUrl         | A link users can follow to learn more about the source.
| dataVisibility    | Valid values: `PUBLIC`, `PRIVATE`. Describes whether the source returns data that is generally available to all users or private. This is not related to authentication or access to data but only about the availability of the data. For example, the data visibility for a Twitter source that returns the number of [@googleanalytics](https://twitter.com/googleanalytics) followers is PUBLIC since the source returns the same data for any user. However, for a source such as Google Analytics, the data returned is unique and private to each user so data visibility is `PRIVATE`. A simple test is if two unique users connected to the source would they receive the same data (`PUBLIC`) or unique data specific to their account (`PRIVATE`).
3. run `npm install && npm run prettier` to automatically format the JSON.

## Add a category

Data sources can be associated with categories to make it easier to organize and group similar sources.

Try to use existing categories when possible. If required new categories can be added to the categories.json registry file by sending a pull request.
```
  {
    "id": "CATEGORY_ID",
    "name": "Category name",
    "description": "Optional description"
  }
```
| Property          | Description |
| --------          | ------------ |
| id                | A unique Id. This will be used in source definitions.
| name              | A user-friendly name of the category.
| description       | An optional description of the category.

After editing this file, run `npm install && npm run prettier` to automatically format the JSON.

## Add an organization

Data sources can be associated with an organization to make it easier to view all sources from the same entity.

The organization represents an entity (E.g. company, developer) responsible for a source.

A new organization can be added to the registry by sending a pull request.

1. Under the ***organizations*** directory create a new JSON file for the organization. Use lowercase characters and underscores for spaces. The filename should match the Id property of the organization definition.
2. Define the organization using the following format:

```
  {
    "id": "ORGANIZATION_ID",
    "name": "Organization name",
    "iconUrl": "https://iconUrl",
    "orgUrl": "https://orgUrl"

  }
```
| Property          | Description |
| --------          | ------------ |
| id                | A unique Id. This will be used in source definitions.
| name              | A user-friendly name of the organization.
| iconUrl           | A link to an icon image representing this organization. Recommended dimensions are 40px by 40px. It is your responsibility to review and comply with all applicable third party TOS. 
| orgUrl            | A link users can follow to learn more about the organization.
3. run `npm install && npm run prettier` to automatically format the JSON.

## How this information is used
This information will be used to help categorize and organize Community Connectors, making it easier for users to discover and connect to data. Visit the [Data Studio Gallery](https://developers.google.com/datastudio/connector/gallery).

Questions or requests related to this registry can be sent to community-connector-feedback@google.com.
