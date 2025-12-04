# GP Chronic Condition Management Plan FHIR Implementation Guide

This repository contains the source for the GP Chronic Condition Management Plan (GPCCMP) FHIR Implementation Guide.

## Overview

The GPCCMP Implementation Guide provides FHIR profiles and guidance for documenting and exchanging chronic condition management plans in Australian general practice settings.

## Building the Implementation Guide

### Prerequisites

- Java 11 or higher
- Node.js (for SUSHI)
- Internet connection (for downloading IG Publisher and dependencies)

### Building

1. Install SUSHI (if not already installed):
   ```bash
   npm install -g fsh-sushi
   ```

2. Download the IG Publisher:
   ```bash
   ./_updatePublisher.sh -y
   ```

3. Build the Implementation Guide:
   ```bash
   ./_genonce.sh
   ```

4. The output will be in the `output/` directory.

### Continuous Build

For continuous development with auto-rebuild:
```bash
./_gencontinuous.sh
```

## Structure

- `sushi-config.yaml` - SUSHI configuration file
- `ig.ini` - IG Publisher configuration
- `input/fsh/` - FSH (FHIR Shorthand) source files
- `input/pagecontent/` - Markdown pages for the IG
- `input/images/` - Images used in the IG
- `input/examples/` - Example resources

## Profiles

- **GPCCMP CarePlan** - Profile for chronic condition management plans
- **GPCCMP Goal** - Profile for treatment goals within management plans

## License

Copyright © 2024+ AEHRC. Licensed under Creative Commons Attribution 4.0.

## Contact

AEHRC - https://aehrc.csiro.au
