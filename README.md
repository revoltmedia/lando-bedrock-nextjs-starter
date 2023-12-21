# Lando-Bedrock Starter

A starter with Lando & Bedrock configured to work together.

## Getting Started

### Dependencies

 * [Docker](https://docs.docker.com/get-docker/)
 * [Lando](https://docs.lando.dev/getting-started/)
   * _Suggestion_: [Trust the Lando CA](https://docs.lando.dev/core/v3/security.html#trusting-the-ca) to avoid HTTPS errors.

### Setup config preferences

 1. Copy the `.env` file and edit with your preferences.
    `cp .env.example .env`
 2. Generate WP salt keys for your `.env` file. A handy tool for this is the [roots.io salt generator](https://roots.io/salts.html)
 3. _Suggestion_: change the name of your site in the following locatons:
    * `.lando.yml`:
      * `name`
      * `proxy`: `pma` URL subdomain
    * `.env` `WP_HOME` URL subdomain
 4. Run `lando start`
 5. Access your local instance at the URL provided after the start command finishes.

 ## Notes

  * `wp-admin` is under `/wp/` at `https://lando-bedrock.lndo.site/wp/wp-admin`
  * `composer ...` commands can be run via `lando composer ...`
