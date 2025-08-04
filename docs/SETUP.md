# Setup Guide for Container Orchestration Platform Case Study

This guide provides instructions on how to set up and run the sample application and configurations within this case study. It assumes you have access to an OpenShift cluster or a local Kubernetes environment (e.g., Minikube, Kind) with `oc` (OpenShift CLI) or `kubectl` installed.

## Prerequisites

*   **OpenShift Cluster Access:** You need access to an OpenShift cluster where you have permissions to create projects, deploy applications, and manage resources. Alternatively, a local Kubernetes cluster with OpenShift routes enabled (if you want to test routes).
*   **OpenShift CLI (`oc`) or Kubernetes CLI (`kubectl`):** Ensure you have the appropriate command-line tool installed and configured to connect to your cluster.
*   **Docker (Optional):** If you plan to build the sample application image locally, you will need Docker installed.

## Steps to Deploy the Sample Application

1.  **Clone the Repository:**
    ```bash
    git clone https://github.com/YOUR_USERNAME/container-orchestration-platform.git
    cd container-orchestration-platform
    ```

2.  **Build and Push Docker Image (Optional - if not using pre-built image):**
    If you want to build the `sample-app` Docker image locally and push it to an image registry accessible by your cluster:
    ```bash
    cd sample-app
    docker build -t your-registry/sample-app:latest .
    docker push your-registry/sample-app:latest
    cd ..
    ```
    *   **Note:** You will need to update the `image:` field in `kubernetes/deployment.yaml` to point to your pushed image (e.g., `image: your-registry/sample-app:latest`).

3.  **Apply Kubernetes/OpenShift Configurations:**
    Navigate to the root of the cloned repository and apply the Kubernetes deployment and service configurations. If you are on OpenShift, this will also create a Route.
    ```bash
    oc apply -f kubernetes/deployment.yaml
    # or for plain Kubernetes:
    # kubectl apply -f kubernetes/deployment.yaml
    ```

4.  **Verify Deployment:**
    Check the status of your deployment and pods:
    ```bash
    oc get pods -l app=sample-app
    oc get svc sample-app-service
    oc get route sample-app-route # For OpenShift
    ```

5.  **Access the Application:**
    *   **OpenShift:** Get the hostname of the route:
        ```bash
        oc get route sample-app-route -o jsonpath='{.spec.host}'
        ```
        Then, open the URL in your web browser.
    *   **Kubernetes (without OpenShift Route):** You might need to set up port-forwarding or an Ingress controller to access the `sample-app-service`.
        ```bash
        kubectl port-forward svc/sample-app-service 8080:80
        ```
        Then, access `http://localhost:8080` in your web browser.

## Troubleshooting

*   **Pods not running:**
    *   Check pod logs: `oc logs <pod-name>`
    *   Describe pod for events: `oc describe pod <pod-name>`
    *   Ensure image is accessible and correctly specified in `deployment.yaml`.
*   **Application not accessible:**
    *   Verify service and route/ingress status.
    *   Check network policies if any are applied.
    *   Ensure correct port forwarding or route hostname.
*   **`oc` or `kubectl` command not found:**
    *   Ensure the CLI tool is installed and added to your system's PATH.
*   **Permissions issues:**
    *   Ensure your user has the necessary permissions in the OpenShift project or Kubernetes namespace.

For further assistance, please refer to the [CONTRIBUTING.md](CONTRIBUTING.md) guide or open an issue in the repository.


