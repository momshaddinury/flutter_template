---
paths:
  - "lib/src/data/models/**/*.dart"
  - "lib/src/data/mappers/**/*.dart"
  - "lib/src/data/repositories/**/*.dart"
  - "lib/src/data/services/**/*.dart"
  - "lib/src/domain/entities/**/*.dart"
  - "lib/src/presentation/**/models/**/*.dart"
---
# Models

This file defines the model taxonomy and implementation rules. Layer boundaries are in [architecture.md](architecture.md).

## Names and locations

### Data model

- Name it `XRequestModel` or `XResponseModel` and put it in `data/models/`.
- Use it to match a server request or response.
- It may import serialization packages and other data models. It never imports domain or presentation types.

### Entity

- Name a class `XEntity`. Put entity classes and domain enums in `domain/entities/`.
- Use them for application and business values with raw, typed fields.
- They may import Dart, domain entities, and domain value types. They never import Flutter, intl, data models, or presentation types.

### Presentation model

- Give it a plain noun and put it in `features/<feature>/models/`.
- Use it for state or combined data needed by one feature.
- It may import domain entities and presentation types. It never imports data models.
- When two or more features use it, move it to `presentation/core/models/`. Features import the shared model from core, never from each other.
- A presentation extension is not a presentation model. Keep a feature-specific extension beside its consumers and a shared extension in `presentation/core/extensions/`.
- A state class or enum owned by one Riverpod provider is not a general feature
  model. Keep it beside that provider as described in [riverpod.md](riverpod.md).

## Layer rules

- A service returns an infrastructure value. It does not construct an entity.
- A repository decodes a server response into a data model and uses a mapper to create an entity.
- A repository interface exposes entities and domain values. Data models do not leave the data layer.
- A data model never extends an entity.
- Write one mapper per independently owned response model. The primary mapper also maps any nested models that stay in its file.
- Name a mapper's primary conversion `toEntity`. Name other deterministic conversions `toX`, with a leading underscore when private. Use `parseX` for text parsing and `resolveX` for choosing among candidates or fallbacks.
- A screen reads an entity by default. Add a presentation model only for screen state, filtered data, or data combined from multiple entities.

## File ownership

- Prefer one primary data model, entity, presentation model, or domain enum per file.
- A secondary declaration may share the file when it has meaning only as an owned or nested part of the primary declaration.
- Move the secondary declaration to its own file when another data model, entity, or presentation model reuses it. Imports from repositories, mappers, providers, or widgets do not trigger this move.
- Sharing a feature or API module is not enough reason to share a file.

Examples:

- `TokenResponseModel` and `ResetTicketModel` use separate files because they describe independent responses.
- `AddressResponseModel` may stay with `AccountResponseModel` while it is only a nested part of that response.
- A domain enum may stay with the entity it exclusively describes. Move it to its own file when another entity uses it.

## Values

- Keep constructor parameters in field-declaration order. Related types keep
  their shared parameters in the same order.
- Data-model fields match the server shape. Keep enum-valued fields as `String` and date or time fields as `String`.
- A mapper converts wire strings to domain enums with an explicit switch expression. It throws `FormatException` for an unknown value.
- A mapper converts wire dates and instants to typed domain values. Use `DateTime` for dates and UTC `DateTime` for instants. Add month-only or clock-only value types when the domain requires them.
- Entities contain raw values. They do not contain localized or preformatted text.
- Widgets or presentation extensions format values with the current locale.
- An entity may derive a value from its own fields. A decision that needs another entity, the current date, or a policy belongs in a use case.

## Writes

- Use cases and repository interfaces accept named parameters made from domain types.
- The repository builds the server request.
- Create a request model when the body has more than three fields or contains a nested object. Otherwise, build the map inline.
