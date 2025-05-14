# Decentralized Healthcare Provider Directory

A blockchain-based solution for managing healthcare provider information using Clarity smart contracts.

## Overview

This project implements a decentralized healthcare provider directory that enables secure, transparent management of healthcare provider information. The system allows for verification of providers, tracking of specialties and certifications, management of practice locations, and recording of insurance network affiliations.

## Features

- **Provider Verification**: Validate healthcare practitioners and manage their verification status
- **Specialty Certification**: Record and verify medical expertise and specialties
- **Practice Location Management**: Track service delivery sites and available services
- **Network Participation**: Record insurance affiliations and patient acceptance status
- **Directory Access Control**: Manage information retrieval with appropriate access controls

## Smart Contracts

### Provider Verification Contract

Manages the verification of healthcare providers:

- Register new providers
- Verify provider credentials
- Suspend providers when necessary
- Track license information

### Specialty Certification Contract

Records and verifies medical expertise:

- Add specialty certifications
- Track certification expiration dates
- Verify certification validity
- List all specialties for a provider

### Practice Location Contract

Tracks service delivery sites:

- Add practice locations
- Update location information
- Link locations to providers
- Record services offered at each location

### Network Participation Contract

Records insurance affiliations:

- Add network participation records
- Update network status
- Track contract dates
- Record patient acceptance status

### Directory Access Contract

Manages information retrieval:

- Control access to directory information
- Search providers by specialty
- Search providers by network
- Retrieve comprehensive provider information

## Getting Started

### Prerequisites

- Clarity development environment
- Testing framework (Vitest)

### Installation

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/healthcare-provider-directory.git
   ```

2. Navigate to the project directory:
   ```
   cd healthcare-provider-directory
   ```

3. Run tests:
   ```
   npm test
   ```

## Usage

### Deploying Contracts

Deploy the contracts in the following order:

1. Provider Verification Contract
2. Specialty Certification Contract
3. Practice Location Contract
4. Network Participation Contract
5. Directory Access Contract

### Interacting with Contracts

Example of registering a provider:

```clarity
(contract-call? .provider-verification register-provider "provider123" "MD12345" "CA")
