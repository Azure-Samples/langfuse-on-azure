# Langfuse on Azure

Use the Azure Developer CLI to deploy [Langfuse](https://langfuse.com/) to Azure.

Run:

```shell
azd up
```

## Enabling authentication

By default, the deployed Azure Container App will use the Langfuse authentication system, meaning anyone with routable network access to the web app can attempt to login to it.

To enable Entra-based authentication, follow these steps before running `azd up`:

1. Create a Python virtual environment.
2. Install the required packages:

    ```shell
    python -m install -r requirements.txt
    ```

3. Run this command to enable Entra authentication:

    ```shell
    azd env set AZURE_USE_AUTHENTICATION true
    ```

4. Run this command to specify your tenant ID:

    ```shell
    azd env set AZURE_AUTH_TENANT_ID your-tenant-id
    ```

5. Run the `up` command:

    ```shell
    azd up
    ```

The `azd up` flow will enable Entra authentication for the deployed app by:

* Using a preprovision hook to call `auth_init.py` to create an App Registration. That script sets the `AZURE_AUTH_APP_ID`, `AZURE_AUTH_CLIENT_ID`, and `AZURE_AUTH_CLIENT_SECRET` environment variables.
* During provisioning, passing those environment variables to the Azure Container App, and disabling non-Entra authentication methods.
* Using a postprovision hook to call `auth_update.py` to set the redirect URI to the URL of the deployed Azure Container App.

## Disclaimer

Langfuse is an external project and is not affiliated with Microsoft. You should review their terms, security, and privacy policies before deploying the langfuse image to Azure.
