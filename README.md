# Lando-Bedrock-NextJS Starter

***WORK IN PROGRESS***

A starter with Lando, Bedrock & NextJS configured to work together as a static generated site with WordPress backend. 

Forked from [lando-bedrock-starter](https://github.com/revoltmedia/lando-bedrock-starter) with additional configuration for a NextJS frontend.

## Getting Started

### Dependencies

 * [Docker](https://docs.docker.com/get-docker/)
 * [Lando](https://docs.lando.dev/getting-started/)
   * _Suggestion_: [Trust the Lando CA](https://docs.lando.dev/core/v3/security.html#trusting-the-ca) to avoid HTTPS errors.

### Initialize Backend (Bedrock)

The `init-backend` and `generate-env` tooling will generate the bedrock project under `/backend` and generate a `.env` file based on the `.env.example` with randomized salts.

 1. Run `lando init-backend`
 2. Run `lando generate-env`
 3. Run `lando start`
 4. Access your local instance at the URL provided after the start command finishes.
 
### Initialize Frontend

 1. `lando init-frontend`
 2. Answer the prompts

### Cleaning Up

If you want to clean up the starter specific files once your project is set up, 
from the project root run: `rm -rf starter-scripts .lando-base.yml`

Note that this will remove the `init-backend` tooling.

## Tooling

 * `generate-env` Generates a `.env` file based on the `.env.example`
 * `init-backend` Generates a Bedrock project under the `/backend` directory

## Notes

  * `wp-admin` is under `/wp/` at `https://lando-bedrock-nextjs.lndo.site/wp/wp-admin`
  * `composer ...` commands can be run via `lando composer ...`

## What did you do here?

 1. Setup a `.lando.yml` config with some settings defined explicitly including some configs and env vars that are mostly personal taste.
 2. Initialization of Bedrock via `lando composer create-project roots/bedrock`
 3. Wrote this README with steps and tips.

## Todo

 - [ ] Setup initial NextJS project
 - [ ] Create/Add blank theme placeholder for NextJS site
 - [ ] Add basic plugins neeeded to connect NextJS
    * WP-GraphQL
 - [ ] Add connection config to NextJS to get data
 - [ ] Create/Add React blocks plugin based on:
        https://medium.com/geekculture/headless-wordpress-gutenberg-next-js-part-1-3-creating-a-block-with-react-e8d69e8460d4
 - [ ] Create/Add "S3 Uploads for Bedrock" plugin

## References & Inspiration

 * [Bedrock Installation](https://roots.io/bedrock/docs/installation/)
 * [Bedrock with Lando](https://roots.io/bedrock/docs/bedrock-with-lando/)
 * [S3-Uploads](https://github.com/humanmade/S3-Uploads)

## Suggestions

### Use S3 File Uploads

Many S3 compatible plugins exist for WP. While it has drawbacks, it's a good idea to do something like this to separate the file uploads from the core code. The [S3-Uploads](https://github.com/humanmade/S3-Uploads) plugin is great for use with Bedrock / composer.

  * Their install steps can be used modifying them to `lando composer ...` or `lando wp ...`
  * Their `wp-config.php` lines should be placed in `backend/config/applicaton.php`
    * Change `define` to `Config::define`
    * Replace the values with environment variables `env('S3_UPLOADS_BUCKET')` 
      ```
      /**
       * S3 Uploads Plugin settings
       */

      Config::define( 'S3_UPLOADS_BUCKET', env('S3_UPLOADS_BUCKET') );
      // The s3 bucket region (excluding the rest of the URL)
      Config::define( 'S3_UPLOADS_REGION', env('S3_UPLOADS_REGION') );

      // You can set key and secret directly:
      Config::define( 'S3_UPLOADS_KEY', env('S3_UPLOADS_KEY') );
      Config::define( 'S3_UPLOADS_SECRET', env('S3_UPLOADS_SECRET') );

      // Define the base bucket URL (without trailing slash)
      Config::define( 'S3_UPLOADS_BUCKET_URL', env('S3_UPLOADS_BUCKET_URL') );
      ```

    * Don't forget to add those variables to the `.env` file
      ```
      # S3 Uploads Bucket Config
      S3_UPLOADS_KEY='xxxx'
      S3_UPLOADS_SECRET='xxxx'
      S3_UPLOADS_BUCKET='xxxx'
      S3_UPLOADS_REGION='us-west-2'
      # Define the base bucket URL (without trailing slash)
      S3_UPLOADS_BUCKET_URL='https://s3.us-west-2.amazonaws.com/xxxx'
      ```


## About this Repo

This starter project was created by [bear](https://github.com/chaoticbear) for [Revolt Media](https://github.com/revoltmedia). It is a tool to spin up relevant projects faster. Please don't expect regular updates, and feel free to use it as a starting point.